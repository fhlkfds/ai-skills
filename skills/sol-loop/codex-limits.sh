#!/usr/bin/env bash
# Prints OK, BLOCKED until <time>, or UNKNOWN for the Codex accounts in TeamClaude.
status=$(curl -sf -m 5 http://127.0.0.1:3456/teamclaude/status) || { echo "UNKNOWN: TeamClaude unreachable"; exit 0; }
jq -r '
  [.accounts[] | select(.provider == "codex" and (.disabled | not))] as $a
  | ($a | map(select(.unavailable == null)) | length) as $free
  | if $free > 0 then "OK: \($free) of \($a | length) Codex accounts free"
    else ($a | map(.quota | [.unified5hReset, .unified7dReset] | map(select(.)) | max) | map(select(.)) | min) as $back
      | "BLOCKED until \(if $back then $back / 1000 | strflocaltime("%a %b %-d %-I:%M %p") else "unknown" end)"
    end
' <<<"$status"
