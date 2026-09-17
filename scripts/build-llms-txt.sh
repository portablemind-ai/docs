#!/usr/bin/env bash
# Rebuild llms.txt (https://llmstxt.org) from the tree: one entry per page,
# title from the first "# " heading, summary from the first "> " line.
# LLMS_BASE_URL overrides where the pages are said to live.
set -euo pipefail
repo=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
base=${LLMS_BASE_URL:-https://raw.githubusercontent.com/portablemind/docs/main}
cd "$repo"

title()   { grep -m1 '^# ' "$1" | sed 's/^# //'; }
summary() { grep -m1 '^> ' "$1" | sed 's/^> //'; }
entry() {
  local f=$1 t s
  t=$(title "$f" || true); s=$(summary "$f" || true)
  printf -- '- [%s](%s/%s)%s\n' "${t:-$f}" "$base" "$f" "${s:+: $s}"
}

{
  echo '# PortableMind'
  echo
  echo '> The AI-native workspace — team memory, agents, files, tasks and conversations — exposed to any AI app as an MCP server. Endpoint: https://www.dsiloed.com/api/v1/mcp'
  echo
  echo '## Connecting'
  for f in mcp/connect.md mcp/recipes.md; do [ -f "$f" ] && entry "$f"; done
  echo
  echo '## MCP tools'
  [ -f mcp/README.md ] && entry mcp/README.md
  for f in $(LC_ALL=C ls mcp/tools/*.md 2>/dev/null); do entry "$f"; done
  echo
  echo '## User guides'
  [ -f guides/README.md ] && entry guides/README.md
  for f in $(LC_ALL=C ls guides/*.md 2>/dev/null | grep -v '/README.md$'); do entry "$f"; done
} > llms.txt
echo "build-llms-txt: $(grep -c '^- \[' llms.txt) entries"
