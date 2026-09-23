---
name: weekly-review
description: "Write a weekly review in the second-brain vault from the past seven days of learning notes, digests and (if present) work logs: what happened, patterns, wins, where things got stuck, stop/start/continue, and one bet for next week. Use on \"weekly review\", \"what did I do this week\", \"review my week\", or on the user's weekly schedule."
---

# Weekly review

Seven days of notes become one page you can act on.

## Inputs (last 7 days only)

- `3_Learning/*.md` daily notes.
- New or updated notes in `2_Wiki/Digests/` and `2_Wiki/Concepts/`.
- If the vault sits next to an AI Work OS workspace: its `memory/daily-logs/` and `memory/TODO.md`.
- Last week's review in `3_Learning/Weekly/`, to check whether last week's bet happened.

## Steps

1. Read the inputs. Note dates, so every point in the review can point back to a day or a note.
2. Write `3_Learning/Weekly/YYYY-Www.md` from `Templates/weekly.md`:
   - **What happened:** five to eight bullets, each with a link to the note or log it came from.
   - **Patterns:** things that happened more than once (a repeated blocker, a repeated win, a recurring topic in digests).
   - **Wins:** with evidence.
   - **Where I got stuck:** with the cause if known.
   - **Stop / Start / Continue:** one line each, drawn from the patterns.
   - **One bet for next week:** a single outcome, small enough to finish.
   - **Last week's bet:** done, partly done or not done, and why.
3. Add a line to `2_Wiki/INDEX.md` only if the review produced a new decision or concept note.

## Honesty

- Only what the notes show. Do not invent feelings, results or productivity numbers.
- If a week has little in it, write a short review. A thin week is information too.
