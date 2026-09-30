#!/usr/bin/env bash
# Re-pin this edition's pack entries to the pack's current main HEAD.
#
# .grok-plugin/marketplace.json lists the Grok-native plugin first (a local
# entry), then every plugin of LibreArch-Claude-Code as a remote entry pinned to one
# commit. This script reads the pack's own marketplace at its current main
# HEAD and rebuilds the remote entries from it: every entry moves to the new
# commit, new pack plugins are added, removed ones are dropped, and names,
# descriptions and versions come from the pack. Local entries stay as they
# are. It prints the diff; commit the result.
#
# Usage:
#   scripts/pin-pack.sh          re-pin and print the diff
#   scripts/pin-pack.sh --check  exit 1 when the remote entry names differ
#                                from the pack's current plugin names
#
# Needs git, curl and jq.
set -euo pipefail

PACK="HermeticOrmus/LibreArch-Claude-Code"
# Pack plugins this edition holds out on purpose (space-separated names).
HOLD=""

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MK="$ROOT/.grok-plugin/marketplace.json"
URL="https://github.com/$PACK.git"

check=0
case "${1:-}" in
  --check) check=1 ;;
  "") ;;
  -h|--help) awk 'NR==1{next} /^#/{sub(/^# ?/,""); print; next} {exit}' "${BASH_SOURCE[0]}"; exit 0 ;;
  *) echo "unknown option: $1" >&2; exit 1 ;;
esac

for tool in git curl jq; do
  command -v "$tool" >/dev/null 2>&1 || { echo "error: $tool is required" >&2; exit 1; }
done

sha="$(git ls-remote "$URL" refs/heads/main | cut -f1)"
[[ ${#sha} -eq 40 ]] || { echo "error: could not read the main HEAD of $PACK" >&2; exit 1; }

pack_json="$(curl -fsSL "https://raw.githubusercontent.com/$PACK/$sha/.claude-plugin/marketplace.json")"
hold_json="$(jq -cn --arg h "$HOLD" '$h | split(" ") | map(select(length > 0))')"

if (( check )); then
  want="$(jq -r --argjson hold "$hold_json" '[.plugins[].name | select(IN($hold[]) | not)] | sort | .[]' <<<"$pack_json")"
  have="$(jq -r '[.plugins[] | select(.source | type == "object") | .name] | sort | .[]' "$MK")"
  if [[ "$want" != "$have" ]]; then
    echo "The pack's plugins changed since the last pin ($PACK@${sha:0:7}):"
    diff <(printf '%s\n' "$have") <(printf '%s\n' "$want") | sed -n 's/^> /  gained: /p; s/^< /  lost:   /p' || true
    echo "Run scripts/pin-pack.sh, then commit .grok-plugin/marketplace.json."
    exit 1
  fi
  echo "remote entries match the $(grep -c . <<<"$want") plugins of $PACK@${sha:0:7} (held out: ${HOLD:-none})"
  exit 0
fi

new="$(jq --argjson pack "$pack_json" --argjson hold "$hold_json" --arg url "$URL" --arg sha "$sha" '
  .plugins = ([.plugins[] | select(.source | type == "string")] +
    [$pack.plugins[] | select(.name | IN($hold[]) | not) |
      {name, description}
      + (if .version then {version} else {} end)
      + {source: ({source: "url", url: $url, sha: $sha}
          + (.source | ltrimstr("./") | rtrimstr("/")
             | if . == "" or . == "." then {} else {path: .} end))}])
' "$MK")"

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
printf '%s\n' "$new" > "$tmp"
if diff -u --label a/.grok-plugin/marketplace.json --label b/.grok-plugin/marketplace.json "$MK" "$tmp"; then
  echo "already pinned: $(jq '[.plugins[] | select(.source | type == "object")] | length' "$MK") entries at $PACK@${sha:0:7}"
else
  cp "$tmp" "$MK"
  echo
  echo "re-pinned to $PACK@${sha:0:7}. If the plugin count changed, update the Depth table in README.md."
fi
