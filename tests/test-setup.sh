#!/usr/bin/env bash
# Tests for setup.sh and the vault template. Uses a throwaway HOME so your real skills are untouched.
set -uo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP=$(mktemp -d); pass=0; fail=0
ok() { if eval "$1"; then pass=$((pass+1)); else fail=$((fail+1)); echo "FAIL: $2"; fi; }

HOME="$TMP/home" bash "$HERE/setup.sh" "$TMP/brain" --link-skills --codex >/dev/null
ok '[ -f "$TMP/brain/AGENTS.md" ] && [ -f "$TMP/brain/2_Wiki/INDEX.md" ]' "vault rules and index copied"
ok '[ -d "$TMP/brain/0_Inbox/Clippings" ] && [ -d "$TMP/brain/3_Learning/Weekly" ]' "inbox and weekly folders exist"
ok '[ -f "$TMP/brain/.brain/manifest.json" ]' "manifest created"
ok '[ -L "$TMP/home/.claude/skills/digest" ] && [ -L "$TMP/home/.codex/skills/ask-brain" ]' "skills linked for Claude and Codex"

echo "my note" > "$TMP/brain/2_Wiki/INDEX.md"
HOME="$TMP/home" bash "$HERE/setup.sh" "$TMP/brain" >/dev/null
ok 'grep -q "my note" "$TMP/brain/2_Wiki/INDEX.md"' "second run keeps your notes"

for f in "$HERE"/skills/*/SKILL.md; do
  ok 'python3 "$HERE/tests/check-frontmatter.py" "$f"' "frontmatter parses in $f"
done

# Every [[link]] in the example wiki points at a note that exists
missing=""
while IFS= read -r link; do
  [ -n "$(find "$HERE/vault" -name "$link.md" -print -quit)" ] || missing="$missing [$link]"
done < <(grep -rhoE '\[\[[^]|]+' "$HERE/vault/2_Wiki" | sed 's/^\[\[//' | sort -u)
ok '[ -z "$missing" ]' "wiki links resolve:$missing"


# --force keeps a user's own skill folder: moved to skills-backup, never deleted
rm -rf "$TMP/home/.claude/skills/digest"; mkdir -p "$TMP/home/.claude/skills/digest"; echo mine > "$TMP/home/.claude/skills/digest/SKILL.md"
HOME="$TMP/home" bash "$HERE/setup.sh" "$TMP/extra" --link-skills --force >/dev/null
ok 'ls "$TMP"/home/.claude/skills-backup/digest-*/SKILL.md >/dev/null 2>&1 && [ -L "$TMP/home/.claude/skills/digest" ]' "--force backs up an existing skill folder"
ok '! ls -d "$TMP"/home/.claude/skills/*.bak* >/dev/null 2>&1' "no backup copies left inside the skills folder"
rm -rf "$TMP"
echo "setup: $pass passed, $fail failed"
[ "$fail" -eq 0 ]
