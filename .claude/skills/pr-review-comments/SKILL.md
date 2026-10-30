---
name: pr-review-comments
description: Dan's voice for pull request review comments. Use when drafting, posting or rewriting comments on someone's PR.
---

# PR review comments

Each comment says what should change and why, in one to three sentences, in Dan's voice.

## Voice

- Ask rather than order: "Could we…", "I'd…", "We can…". Collaborative "we".
- Lead with the change, then the reason in one clause. The reason is concrete: what breaks, panics, drifts or reads worse.
- Plain, direct and friendly. Politeness comes from the phrasing, never from padding.
- Every sentence is either the change or its reason. That rules out openers and closers ("Thanks for this!", "Tiny nit, feel free to ignore", "Small one:"), blocking status ("none of this is blocking", "happy for that to be a follow-up"), and mechanics the code already shows (imports needed, every call site a rename touches).

## Shape

- Suggestion block when the change is contiguous lines at the comment's anchor. Plain code block when it spans several functions or files.
- Same change at several sites: full comment on the first, then a separate `Ditto, use X.` comment with its own suggestion block on each other site, in place of "Same at L396".
- Line refs (L296) only when the reader must go to that line to act.
- Review summary: one line, e.g. "A few suggestions to make the new code a bit more idiomatic Go.", or empty.

## Examples

Right:

> Could we use a short receiver name here? It's the usual Go convention.

> We know the length, so we can preallocate. `replaced` and `err` at L308 also shadow the ones at L296, so I'd rename them.

> `assert.JSONEq` checks the same content but won't break on key order or whitespace, and gives a clearer diff.

> Ditto, use `assert.JSONEq`.

Too blunt: "Use a short receiver name, it's the Go convention."

Too long: "I'd use `require.NoError` here so a send failure stops the test, rather than also failing the body check. Same at L395. It needs the `github.com/stretchr/testify/require` import."

## Posting

- Draft the comments for Dan to pick from before posting anything.
- Post the picked ones as one review on the PR head commit (`gh api repos/<owner>/<repo>/pulls/<n>/reviews`, event `COMMENT`).
- Small wording fixes to a posted comment: edit it in place.
- Reworking the whole review: snapshot every comment, confirm none has replies, delete them, repost as one review, then check the reposted bodies match the drafts. Do this only when Dan asks, since it clears the "edited" markers at the cost of new notifications. A submitted review's summary cannot be deleted, so settle it before posting.
