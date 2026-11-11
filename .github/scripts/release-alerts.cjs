const FAILURE_STATES = new Set(['failure', 'timed_out', 'cancelled', 'action_required', 'startup_failure']);
const GRACE_MS = 60 * 60 * 1000;

async function collectAlerts({ github, context, now = Date.now() }) {
  const repo = context.repo;
  const run = context.payload.workflow_run;
  if (run) {
    const published = run.name === 'brew pr-pull' && run.conclusion === 'success'
      && run.event === 'pull_request_target';
    if (!published && !FAILURE_STATES.has(run.conclusion)) return [];
    // Branch pushes run the early lint check too. Only alert for main and PRs.
    if (run.event === 'push' && run.head_branch !== 'main') return [];
    const text = `${run.name} ${run.conclusion} on ${run.head_branch}: ${run.html_url}`;
    if (['pull_request', 'pull_request_target'].includes(run.event)) {
      // workflow_run.pull_requests is often empty. Look up the current PR so
      // validation, publishing, and the hourly watchdog share one incident key.
      const prs = await github.paginate(github.rest.pulls.list, {
        ...repo, state: 'open', per_page: 100,
        head: `${run.head_repository?.owner.login || repo.owner}:${run.head_branch}`,
      });
      // A published revision is on main even if the PR has moved on since, so
      // its open PR is still an incident. Failures only matter for the current revision.
      const affected = published ? prs : prs.filter(pr => pr.head.sha === run.head_sha);
      return affected.map(pr => ({
        key: `pr:${pr.number}:${run.head_sha}`,
        text: published
          ? `Publishing reported success, but the release PR is still open. The release may already be available; check PR cleanup before retrying.\nAffected PR: ${pr.html_url}\nPublishing run: ${run.html_url}`
          : `${text}\nAffected PR: ${pr.html_url}`,
      }));
    }
    if (['bottle', 'nightly bottle'].includes(run.name)) {
      const name = run.name === 'bottle' ? 'wendy' : 'wendy-nightly';
      const { data: file } = await github.rest.repos.getContent({ ...repo, path: `Formula/${name}.rb`, ref: run.head_sha });
      const tag = Buffer.from(file.content, 'base64').toString().match(/releases\/download\/([^\"]+)"/)?.[1];
      if (!tag) throw new Error(`No bottle release URL for ${name}`);
      return [{ key: `bottle:${tag}`, text }];
    }
    return [{ key: `run:${run.name}:${run.head_sha}`, text }];
  }

  const alerts = [];
  const prs = await github.paginate(github.rest.pulls.list, { ...repo, state: 'open', per_page: 100 });
  for (const pr of prs) {
    if (!pr.labels.some(label => label.name === 'pr-pull')) continue;
    if (now - Date.parse(pr.created_at) < GRACE_MS) continue;
    alerts.push({ key: `pr:${pr.number}:${pr.head.sha}`, text: `Release PR has been waiting over an hour: ${pr.title} ${pr.html_url}` });
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
    alerts.push({ key: `bottle:${tag}`, text: `${problem}: https://github.com/${repo.owner}/${repo.repo}/releases/tag/${tag}` });
  }
  return alerts;
}

function selectNewAlerts(alerts, notified = {}) {
  return alerts.filter(alert => !Object.hasOwn(notified, alert.key));
}

module.exports = { collectAlerts, selectNewAlerts };
