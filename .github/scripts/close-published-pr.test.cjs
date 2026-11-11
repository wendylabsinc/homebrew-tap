const { test } = require('node:test');
const assert = require('node:assert/strict');
const { closePublishedPr } = require('./close-published-pr.cjs');

function fixture({ state = 'open', sha = 'published', updateState = 'closed', error } = {}) {
  const updates = [];
  const context = {
    repo: { owner: 'wendylabsinc', repo: 'homebrew-tap' },
    payload: { pull_request: { number: 320, head: { sha: 'published' } } },
  };
  const github = { rest: { pulls: {
    get: async () => ({ data: { state, head: { sha } } }),
    update: async params => {
      updates.push(params);
      if (error) throw error;
      return { data: { state: updateState } };
    },
  } } };
  return { github, context, updates };
}

test('closes the published PR without requesting another merge', async () => {
  const input = fixture();
  await closePublishedPr(input);
  assert.deepEqual(input.updates, [{ owner: 'wendylabsinc', repo: 'homebrew-tap', pull_number: 320, state: 'closed' }]);
});

test('already closed PRs need no update', async () => {
  const input = fixture({ state: 'closed' });
  await closePublishedPr(input);
  assert.deepEqual(input.updates, []);
});

test('a newer PR revision fails cleanup without closing it', async () => {
  for (const state of ['open', 'closed']) {
    const input = fixture({ state, sha: 'newer' });
    await assert.rejects(closePublishedPr(input), /changed during publishing/);
    assert.deepEqual(input.updates, []);
  }
});

test('failed or ineffective closure fails the publishing job', async () => {
  await assert.rejects(closePublishedPr(fixture({ error: new Error('Forbidden') })), /Forbidden/);
  await assert.rejects(closePublishedPr(fixture({ updateState: 'open' })), /still open/);
});
