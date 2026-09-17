#!/usr/bin/env bash
# Publish one slice of this docs repo from a source repo's CI job.
#
#   scripts/publish-slice.sh <source_dir> <dest_subdir> "<commit message>"
#
# - every SUBDIRECTORY of <source_dir> replaces the same-named subdirectory
#   under <dest_subdir> (rsync --delete: pages for removed tools disappear)
# - top-level FILES of <source_dir> are copied over; hand-written files that
#   exist only in the destination (connect.md, recipes.md) are left alone
# - llms.txt is rebuilt from the tree
# - commits and pushes ONLY if something changed, so a no-op regeneration
#   leaves no commit behind
#
# Called by model_api's publish_mcp_docs (slice → mcp/) and
# harmoniq-frontend's publish_user_docs (slice → guides/).
set -euo pipefail

src=$(cd "$1" && pwd)
dest_sub=$2
msg=$3
repo=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
dest="$repo/$dest_sub"
mkdir -p "$dest"

for dir in "$src"/*/; do
  [ -d "$dir" ] || continue
  name=$(basename "$dir")
  mkdir -p "$dest/$name"
  rsync -a --delete "$dir" "$dest/$name/"
done
find "$src" -maxdepth 1 -type f -exec cp {} "$dest"/ \;

"$repo/scripts/build-llms-txt.sh"

cd "$repo"
git add -A
if git diff --cached --quiet; then
  echo "publish-slice: nothing changed under $dest_sub — no commit."
  exit 0
fi
git -c user.name="${GIT_AUTHOR_NAME:-docs-publisher}" \
    -c user.email="${GIT_AUTHOR_EMAIL:-docs-publisher@portablemind.ai}" \
    commit -q -m "$msg"
git push -q origin "HEAD:${DOCS_BRANCH:-main}"
echo "publish-slice: pushed — $msg"
