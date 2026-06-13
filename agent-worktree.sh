#!/bin/bash
# agent-worktree.sh - isolierte Git-Worktrees pro KI-Agent
#
# Jeder Agent (Claude Code, Codex, ...) arbeitet in einem EIGENEN
# Verzeichnis mit EIGENEM Branch. Kein gemeinsamer Arbeitsbereich.
#
# WINDOWS: In Git Bash ausfuehren, nicht PowerShell!
#
# Verwendung:
#   ./agent-worktree.sh new claude feature/login
#   ./agent-worktree.sh new codex  feature/api-tests
#   ./agent-worktree.sh list
#   ./agent-worktree.sh done claude

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
REPO_NAME="$(basename "$REPO_ROOT")"
WT_BASE="$(dirname "$REPO_ROOT")/${REPO_NAME}-worktrees"

cmd="${1:-help}"

case "$cmd" in
  new)
    AGENT="${2:?Agent-Name fehlt (z.B. claude, codex)}"
    BRANCH="${3:?Branch-Name fehlt (z.B. feature/login)}"
    WT_PATH="$WT_BASE/$AGENT"

    mkdir -p "$WT_BASE"
    BASE_BRANCH="$(git symbolic-ref --short HEAD)"
    git worktree add -b "$BRANCH" "$WT_PATH" "$BASE_BRANCH"

    echo ""
    echo "Worktree fuer '$AGENT' angelegt:"
    echo "  Pfad:   $WT_PATH"
    echo "  Branch: $BRANCH (von $BASE_BRANCH)"
    echo ""
    echo "Naechster Schritt:"
    echo "  cd \"$WT_PATH\" && claude     # bzw. codex"
    ;;

  list)
    echo "Aktive Worktrees:"
    git worktree list
    ;;

  done)
    AGENT="${2:?Agent-Name fehlt}"
    WT_PATH="$WT_BASE/$AGENT"
    echo "Entferne Worktree '$AGENT' ($WT_PATH)..."
    git worktree remove "$WT_PATH"
    echo "Entfernt. Branch bleibt erhalten - bei Bedarf mergen oder loeschen."
    ;;

  *)
    echo "Verwendung:"
    echo "  $0 new <agent> <branch>   # Worktree anlegen"
    echo "  $0 list                   # Alle Worktrees zeigen"
    echo "  $0 done <agent>           # Worktree entfernen"
    ;;
esac
