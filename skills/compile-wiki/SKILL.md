---
name: compile-wiki
description: "Turn new material in the vault inbox (0_Inbox/Clippings and 1_Raw) into linked concept notes in 2_Wiki, without reprocessing old files or deleting anything. Use on \"compile wiki\", \"update the brain\", or after adding a batch of clippings."
---

# Compile wiki

Raw notes pile up. This turns them into a small number of well-linked concept notes an agent can actually use.

## Steps

1. **Find what is new.** List files in `0_Inbox/Clippings/` and `1_Raw/`. Compare each file's path and size (or a hash) with `.brain/manifest.json`. Only new or changed files are processed. Create the manifest if it does not exist.
2. **Group by idea, not by file.** Read the new files and list the distinct ideas they contain. Several files often feed one idea.
3. **For each idea:**
   - If a concept note exists, add what is new: a sentence, an example, a source link. Keep what was there.
   - If not, create `2_Wiki/Concepts/<Concept name>.md` from `Templates/concept.md`.
   - Every note links its sources (the raw or clipping files) in its frontmatter `sources` list.
4. **Long single sources** (a full transcript, a long article) also get a digest with the `digest` skill.
5. **Update the index.** Add or refresh one line per touched note in `2_Wiki/INDEX.md`.
6. **Update the manifest** with the processed files and today's date.
7. **Report:** files processed, notes created, notes updated, and anything skipped with the reason.

## Rules

- Never delete, move or rewrite raw files or anything under `3_Learning/`.
- One idea per concept note. Merge near-duplicates instead of adding new ones.
- Paraphrase; link to the source instead of copying it.
- If a file is a private document (client work, finances, personal messages), skip it and say so in the report.
- `--dry-run` style request: list what would change, write nothing.

## Manifest format

```json
{ "processed": { "1_Raw/2026-09-20 talk transcript.md": { "size": 48213, "date": "2026-09-23" } } }
```
