---
name: ask-brain
description: "Answer a question from the second-brain vault first, citing the notes used, and say plainly when the vault has nothing before looking anywhere else. Use on \"ask my brain\", \"what do my notes say about\", \"have I read anything on\", \"check the wiki\", or any question the user's own notes may already answer."
---

# Ask the brain

Your notes first, the internet second.

## Steps

1. **Read the map.** Open `2_Wiki/INDEX.md` and pick the likely notes.
2. **Search the vault** for the question's key terms (for example with `grep -ril "<term>" 2_Wiki 3_Learning`). Open the best five to ten matches.
3. **Answer from those notes.** Cite each point with the note name as a link, like `[[Keep the model out of the critical path]]`.
4. **Say what is missing.** If the notes do not cover part of the question, say "the brain has nothing on X". Ask before searching the web, then keep web findings separate and cited.
5. **Offer to file it.** If the answer created new knowledge (from the web or from combining notes), offer to save it with `digest` or as a concept note.

## Rules

- Never present a web result as something from the user's notes.
- Keep the user's own conclusions (in `3_Learning/`) separate from what sources say.
- Short answer first, then the supporting notes.
