// Call only after the rebased release commits have been pushed successfully.
async function closePublishedPr({ github, context }) {
  const published = context.payload.pull_request;
  const params = { ...context.repo, pull_number: published.number };
  const { data: current } = await github.rest.pulls.get(params);
  if (current.head.sha !== published.head.sha) {
    throw new Error(`PR #${published.number} changed during publishing; leaving it and its branch untouched`);
  }
  if (current.state === 'closed') return;
  const { data: closed } = await github.rest.pulls.update({ ...params, state: 'closed' });
  if (closed.state !== 'closed') throw new Error(`Published PR #${published.number} is still open`);
}

module.exports = { closePublishedPr };
