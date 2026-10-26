---
name: jira-ticket
description: Write or rewrite Jira tickets (stories, tasks, sub-tasks, bugs) in plain, concise English. Use whenever creating or editing a Jira issue description or comment, including "write a ticket for", "update the ticket", "trim the jira", or any editJiraIssue / createJiraIssue / addCommentToJiraIssue call.
---

# Jira tickets

A ticket is read by someone who does not know the design. Write for them.

## Rules

1. **Plain words.** Name the thing: "holding account (`PENDING_ALLOCATION`)", not "parks the pool". If a word only makes sense with the design in your head, replace it.
2. **Behaviour, not process.** Say what the system does now. Branch names, "stacked on", commit hygiene and review notes belong in the PR.
3. **One fact per line.** What changed, then what it affects. No clause chains.
4. **Concrete.** One real number or example beats a description: "30.00 collected, 30.00 held".
5. **No padding.** Cut "now", "ensures", "robust", "leverages", "seamlessly". If a sentence changes nothing for the reader, delete it.
6. **No invented shorthand.** Do not coin terms ("unwinds by the split"). Use the words the code, glossary or user uses.
7. **No decoration.** No emoji, no marketing tone, no restating the title.
8. **Say what is not done.** Out of scope and known gaps are stated plainly, once.

## Shape

Keep only the sections that carry content. Most tickets need only these:

- **Why**: the problem or need, 1-3 sentences.
- **What changes**: bullets of observable behaviour.
- **Done when**: testable criteria, one per line.
- **Out of scope**: only if someone might assume it is included.
- **Links**: PRs and related tickets, each with a plain description of what it contains.

Bugs: what happens, what should happen, how to reproduce.
Sub-tasks: one or two sentences and a done condition.

## Before posting

Read it as someone from another squad. If any line needs the design to understand, rewrite it. Show the user the rewrite before it replaces an existing description.
