#!/usr/bin/env bash
# Set up the second-brain vault.
#
#   ./setup.sh ~/SecondBrain                 copy the vault template
#   ./setup.sh ~/SecondBrain --link-skills   also link the skills into ~/.claude/skills
#   ./setup.sh ~/SecondBrain --link-skills --codex   and into ~/.codex/skills
#   ./setup.sh ~/SecondBrain --force         overwrite template files that already exist
#                                            (an existing skill folder with the same name is
#                                            moved to skills-backup/, never deleted)
#
# Safe to run again: your notes are kept unless you pass --force.
set -euo pipefail

TARGET="" LINK="" CODEX="" FORCE=""
for arg in "$@"; do
  case "$arg" in
    --link-skills) LINK=1 ;;
    --codex) CODEX=1 ;;
    --force|-f) FORCE=1 ;;
    -h|--help) sed -n '2,11p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    -*) echo "Unknown option: $arg" >&2; exit 1 ;;
    *) TARGET="$arg" ;;
  esac
done
[ -n "$TARGET" ] || { echo "Tell me where to put the vault, for example: ./setup.sh ~/SecondBrain" >&2; exit 1; }

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$TARGET"
TARGET="$(cd "$TARGET" && pwd)"
copied=0 kept=0
while IFS= read -r -d '' src; do
  rel="${src#"$HERE/vault/"}"
  dest="$TARGET/$rel"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ -z "$FORCE" ]; then kept=$((kept+1)); continue; fi
  cp "$src" "$dest"; copied=$((copied+1))
done < <(find "$HERE/vault" -type f -print0)
mkdir -p "$TARGET/.brain"
[ -f "$TARGET/.brain/manifest.json" ] || echo '{ "processed": {} }' > "$TARGET/.brain/manifest.json"

link_into() {
  mkdir -p "$1"
  for skill in "$HERE"/skills/*/; do
    name="$(basename "$skill")"
    if [ -e "$1/$name" ] && [ -z "$FORCE" ]; then echo "  kept existing $1/$name"; continue; fi
    if [ -L "$1/$name" ]; then rm "$1/$name"; echo "  replaced the existing link $1/$name"
    elif [ -e "$1/$name" ]; then bak="$1-backup/$name-$(date +%Y%m%d-%H%M%S)"; mkdir -p "$1-backup"; mv "$1/$name" "$bak"; echo "  moved your existing $name to $bak"
    fi
    ln -s "${skill%/}" "$1/$name"; echo "  linked $1/$name"
  done
}
if [ -n "$LINK" ]; then
  echo "Linking skills (links, so 'git pull' in this repo updates them):"
  link_into "$HOME/.claude/skills"
  [ -n "$CODEX" ] && link_into "$HOME/.codex/skills"
fi

cat <<EOF

Second brain is ready in $TARGET
  $copied file(s) copied, $kept existing file(s) kept$([ -z "$FORCE" ] && [ "$kept" -gt 0 ] && echo " (use --force to overwrite)")

Next:
  1. Open the folder as a vault in Obsidian (File, Open vault, Open folder as vault).
  2. Save an article with Obsidian Web Clipper into 0_Inbox/Clippings.
  3. Start Claude Code in $TARGET and say "digest the newest clipping".
EOF
