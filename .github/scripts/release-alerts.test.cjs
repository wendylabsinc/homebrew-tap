const { test } = require('node:test');
const assert = require('node:assert/strict');
const { collectAlerts, selectNewAlerts } = require('./release-alerts.cjs');

const now = Date.parse('2026-11-10T12:00:00Z');
const old = '2026-11-10T10:00:00Z';
const recent = '2026-11-10T11:45:00Z';
const repo = { owner: 'wendylabsinc', repo: 'homebrew-tap' };
const context = { repo, payload: {} };

function fixture({ prs = [], missing = false, digest, date = old, apiError } = {}) {
  const github = {
    paginate: async () => prs,
    rest: {
      pulls: { list() {} },
      repos: {
        getContent: async ({ path }) => {
          const name = path.slice('Formula/'.length, -3);
          const text = `root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/${name}-2026.11.10-062304"\nsha256 arm64_tahoe: "${'a'.repeat(64)}"`;
          return { data: { content: Buffer.from(text).toString('base64') } };
        },
        getReleaseByTag: async ({ tag }) => {
          if (apiError) throw Object.assign(new Error('API unavailable'), { status: 503 });
          if (missing) throw Object.assign(new Error('Not Found'), { status: 404 });
          return { data: { draft: false, assets: [{ name: `${tag}.arm64_tahoe.bottle.tar.gz`, state: 'uploaded', digest: digest || `sha256:${'a'.repeat(64)}` }] } };
        },
        listCommits: async () => ({ data: [{ commit: { committer: { date } } }] }),
      },
    },
  };
  return { github, context, now };
}

test('failed PR runs alert immediately with PR and run links', async () => {
  const run = { conclusion: 'failure', event: 'pull_request', head_branch: 'release', head_sha: 'abc', name: 'brew test-bot', pull_requests: [], html_url: 'https://github.com/run/1' };
  const input = fixture({ prs: [{ number: 315, head: { sha: 'abc' }, html_url: 'https://github.com/pull/315' }] });
  const alerts = await collectAlerts({ ...input, context: { repo, payload: { workflow_run: run } } });
  assert.equal(alerts[0].key, 'pr:315:abc');
  assert.match(alerts[0].text, /brew test-bot failure.*https:\/\/github.com\/run\/1/);
  assert.match(alerts[0].text, /Affected PR: https:\/\/github.com\/pull\/315/);
});

test('successful runs and non-main branch pushes do not alert', async () => {
  for (const run of [{ conclusion: 'success' }, { conclusion: 'failure', event: 'push', head_branch: 'feature' }]) {
    assert.deepEqual(await collectAlerts({ context: { repo, payload: { workflow_run: run } } }), []);
  }
});

test('successful publishing alerts immediately if its PR remains open', async () => {
  const pr = { number: 320, head: { sha: 'abc' }, title: 'release', labels: [{ name: 'pr-pull' }], created_at: recent, html_url: 'pr-url' };
  const input = fixture({ prs: [pr] });
  const run = { conclusion: 'success', name: 'brew pr-pull', event: 'pull_request_target', head_branch: 'release', head_sha: 'abc', html_url: 'run-url', pull_requests: [] };
  let query;
  input.github.paginate = async (_method, params) => { query = params; return [pr]; };
  const alerts = await collectAlerts({ ...input, context: { repo, payload: { workflow_run: run } } });
  assert.equal(alerts.length, 1);
  assert.equal(query.state, 'open');
  assert.equal(query.head, 'wendylabsinc:release');
  assert.equal(alerts[0].key, 'pr:320:abc');
  assert.match(alerts[0].text, /reported success.*still open/);
  assert.match(alerts[0].text, /pr-url/);
  assert.match(alerts[0].text, /run-url/);
  const later = await collectAlerts({ ...fixture({ prs: [{ ...pr, created_at: old }] }) });
  assert.deepEqual(selectNewAlerts(later, { [alerts[0].key]: recent }), []);
});

test('successful publishing does not alert for closed or superseded PRs', async () => {
  const run = { conclusion: 'success', name: 'brew pr-pull', event: 'pull_request_target', head_branch: 'release', head_sha: 'abc' };
  for (const prs of [[], [{ number: 320, head: { sha: 'newer' } }]]) {
    assert.deepEqual(await collectAlerts({ ...fixture({ prs }), context: { repo, payload: { workflow_run: run } } }), []);
  }
});

test('timeouts and cancellations are visible', async () => {
  for (const conclusion of ['timed_out', 'cancelled', 'action_required', 'startup_failure']) {
    const run = { conclusion, name: 'bottle', event: 'push', head_branch: 'main', html_url: 'run-url' };
    assert.equal((await collectAlerts({ ...fixture(), context: { repo, payload: { workflow_run: run } } })).length, 1);
  }
});

test('watchdog reports only old release PRs', async () => {
  const pr = { number: 315, head: { sha: 'abc' }, title: 'release', labels: [{ name: 'pr-pull' }], created_at: old, html_url: 'pr-url' };
  const alerts = await collectAlerts(fixture({ prs: [pr, { ...pr, created_at: recent }, { ...pr, labels: [] }] }));
  assert.equal(alerts.length, 1);
  assert.match(alerts[0].text, /waiting over an hour.*pr-url/);
});

test('missing releases alert after the build grace period', async () => {
  assert.equal((await collectAlerts(fixture({ missing: true }))).length, 2);
  assert.deepEqual(await collectAlerts(fixture({ missing: true, date: recent })), []);
});

test('published bottle checksum mismatches alert', async () => {
  const alerts = await collectAlerts(fixture({ digest: `sha256:${'b'.repeat(64)}` }));
  assert.equal(alerts.length, 2);
  assert.match(alerts[0].text, /checksum does not match/);
});

test('healthy releases do not alert', async () => {
  assert.deepEqual(await collectAlerts(fixture()), []);
});

test('API failures are not mistaken for healthy or missing releases', async () => {
  await assert.rejects(collectAlerts(fixture({ apiError: true })), /API unavailable/);
});

test('validation failure, publish failure, and hourly stalled PR reminders deduplicate', async () => {
  const pr = { number: 315, head: { sha: 'abc' }, title: 'release', labels: [{ name: 'pr-pull' }], created_at: old, html_url: 'pr-url' };
  const input = fixture({ prs: [pr] });
  const run = { conclusion: 'failure', name: 'brew test-bot', event: 'pull_request', head_branch: 'release', head_sha: 'abc', html_url: 'run-url' };
  const first = await collectAlerts({ ...input, context: { repo, payload: { workflow_run: run } } });
  const delivered = { [first[0].key]: old };
  const publish = await collectAlerts({ ...input, context: { repo, payload: { workflow_run: { ...run, name: 'brew pr-pull', event: 'pull_request_target' } } } });
  assert.deepEqual(selectNewAlerts(publish, delivered), []);
  assert.deepEqual(selectNewAlerts(await collectAlerts(input), delivered), []);
  pr.head.sha = 'new-commit';
  assert.equal(selectNewAlerts(await collectAlerts(input), delivered).length, 1);
});

test('failed bottle run and missing-asset watchdog deduplicate', async () => {
  const run = { conclusion: 'failure', name: 'bottle', event: 'push', head_branch: 'main', head_sha: 'abc', html_url: 'run-url' };
  const failure = await collectAlerts({ ...fixture(), context: { repo, payload: { workflow_run: run } } });
  const delivered = { [failure[0].key]: old };
  const remaining = selectNewAlerts(await collectAlerts(fixture({ missing: true })), delivered);
  assert.equal(remaining.length, 1);
  assert.match(remaining[0].key, /wendy-nightly/);
});

test('late failures from outdated or closed PRs do not alert', async () => {
  const run = { conclusion: 'failure', name: 'brew test-bot', event: 'pull_request', head_branch: 'release', head_sha: 'old-commit' };
  for (const prs of [[], [{ number: 315, head: { sha: 'new-commit' } }]]) {
    assert.deepEqual(await collectAlerts({ ...fixture({ prs }), context: { repo, payload: { workflow_run: run } } }), []);
  }
});

test('undelivered incidents remain eligible for retry', () => {
  const alert = { key: 'pr:315:abc', text: 'failure' };
  assert.deepEqual(selectNewAlerts([alert], {}), [alert]);
});
