---
name: pr-description
description: Write or rewrite a pull request title and description in Dan's style — a Conventional Commit title, then a short "why" and one sketch of the change. Use whenever opening a PR, filling in or trimming a PR body, or running gh pr create / gh pr edit --body.
---

# PR description

A PR description says **why** the change exists. The diff already shows what changed.

## Title

Conventional Commit, with the ticket id in brackets at the end:

```text
<type>(<scope>): <imperative, lowercase summary> (<TICKET>)
```

Example: `feat(bacs): add report download status and resume partly stored reports (NEO-2281)`

- Never mention Claude or AI in the title or body.

## Body

Two parts, no headings:

1. **Why.** One or two short paragraphs:
   - First, the problem as it is today, in the domain's own words: what goes wrong, and who or what it hurts.
   - Then, in a sentence, the idea that fixes it.

   Don't list files, functions or refactors.
2. **One sketch.** The smallest view that shows the key point:
   - a `diff` of the call tree or control flow
   - pseudocode
   - a file tree
   - a Mermaid diagram

   Show only the lines that carry the change. Pick one; never more than one.

Leave out:

- what-changed bullet lists
- evidence or test sections
- merge-danger or risk sections
- a ticket line (the ticket is in the title)
- preambles, summaries, and sign-offs

Keep the whole body short enough to read without scrolling. Write in plain English and use the project's glossary terms if it has one.

## Example

````markdown
If bacs-download dies partway through a report, the next run sees the report already exists and skips it. The messages it hadn't saved are lost and nobody notices. There's also no way to tell when a report has been fully dealt with.

Reports now start as `PENDING` and only become `STORED` once every message is saved, so the next run finishes them instead of skipping them.

```diff
 processReport
   createReport
-    already exists -> skip
+    already exists and STORED  -> skip
+    already exists and PENDING -> carry on
   createMessage (each)
+    already exists -> skip
+  markReportStored
```
````

## Applying it

- Write the body to a temp file.
- Open the PR with `gh pr create --title "<title>" --body-file <file>`, or update one with `gh pr edit <n> --body-file <file>`.
- Draft PRs follow the same shape.
