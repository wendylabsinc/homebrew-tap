const FAILURE_STATES = new Set(['failure', 'timed_out', 'cancelled', 'action_required', 'startup_failure']);
const GRACE_MS = 60 * 60 * 1000;

async function collectAlerts({ github, context, now = Date.now() }) {
  const repo = context.repo;
  const run = context.payload.workflow_run;
  if (run) {
    if (!FAILURE_STATES.has(run.conclusion)) return [];
    // Branch pushes run the early lint check too. Only alert for main and PRs.
    if (run.event === 'push' && run.head_branch !== 'main') return [];
    const prs = (run.pull_requests || []).map(pr => `#${pr.number}`).join(', ');
    return [`${run.name} ${run.conclusion} on ${run.head_branch}${prs ? ` (${prs})` : ''}: ${run.html_url}`];
  }

  const alerts = [];
  const prs = await github.paginate(github.rest.pulls.list, { ...repo, state: 'open', per_page: 100 });
  for (const pr of prs) {
    if (!pr.labels.some(label => label.name === 'pr-pull')) continue;
    if (now - Date.parse(pr.created_at) < GRACE_MS) continue;
    alerts.push(`Release PR has been waiting over an hour: ${pr.title} ${pr.html_url}`);
  }

  // Check the published artifact too: a green merge is not a completed release.
  for (const name of ['wendy', 'wendy-nightly']) {
    const path = `Formula/${name}.rb`;
    const { data: file } = await github.rest.repos.getContent({ ...repo, path, ref: 'main' });
    const formula = Buffer.from(file.content, 'base64').toString();
    const tag = formula.match(/root_url "https:\/\/github.com\/wendylabsinc\/homebrew-tap\/releases\/download\/([^\"]+)"/)?.[1];
    if (!tag) throw new Error(`No bottle release URL in ${path}`);
    const version = tag.slice(name.length + 1);
    const assetName = `${name}-${version}.arm64_tahoe.bottle.tar.gz`;
    const checksum = formula.match(/arm64_tahoe: "([a-f0-9]{64})"/)?.[1];
    let problem;
    try {
      const { data: release } = await github.rest.repos.getReleaseByTag({ ...repo, tag });
      const asset = release.assets.find(asset => asset.name === assetName && asset.state === 'uploaded');
      if (release.draft || !asset) problem = `Bottle asset is missing from ${tag}`;
      else if (asset.digest && asset.digest !== `sha256:${checksum}`) problem = `Bottle checksum does not match ${path}`;
    } catch (error) {
      if (error.status !== 404) throw error;
      problem = `Bottle release ${tag} is missing`;
    }
    if (!problem) continue;
    const { data: commits } = await github.rest.repos.listCommits({ ...repo, path, sha: 'main', per_page: 1 });
    if (!commits[0]) throw new Error(`No commit found for ${path}`);
    if (now - Date.parse(commits[0].commit.committer.date) < GRACE_MS) continue;
    alerts.push(`${problem}: https://github.com/${repo.owner}/${repo.repo}/releases/tag/${tag}`);
  }
  return alerts;
}

module.exports = { collectAlerts };
