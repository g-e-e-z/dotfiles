#!/usr/bin/env bash
set -euo pipefail

TICKET=$(task $1 export | jq ".[].link" | tr -d '"')
if [ -z "$TICKET" ]; then
  echo "No ticket associated with task $1."
  exit
fi

LINK="https://capeanalytics.atlassian.net/browse/"$TICKET
open $LINK
