#!/usr/bin/env bash
# Showcase CI wrapper: retry only Xcode's known SwiftPM graph crash.
set -uo pipefail
if [[ $# -lt 2 ]]; then
  echo "usage: $0 LOGFILE xcodebuild-args..." >&2
  exit 2
fi
log="$1"
shift
attempt() {
  xcodebuild "$@" 2>&1 | tee "$log"
  return "${PIPESTATUS[0]}"
}
if attempt "$@"; then
  exit 0
fi
if /usr/bin/grep -q 'NSInvalidArgumentException' "$log"; then
  echo 'xcodebuild crashed during SwiftPM package resolution; retrying once' >&2
  attempt "$@"
  exit $?
fi
exit 1
