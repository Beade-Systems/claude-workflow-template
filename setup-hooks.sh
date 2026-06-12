#!/bin/sh
# Installiert Git-Hooks aus dem template in das aktuelle Projekt
# Aufruf: ./setup-hooks.sh  (aus dem Projekt-Root)

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
HOOKS_DIR=".git/hooks"

if [ ! -d "$HOOKS_DIR" ]; then
  echo "Fehler: Kein .git/ gefunden. Bitte aus dem Projekt-Root aufrufen."
  exit 1
fi

cp "$SCRIPT_DIR/hooks/pre-commit" "$HOOKS_DIR/pre-commit"
cp "$SCRIPT_DIR/hooks/pre-push"   "$HOOKS_DIR/pre-push"
chmod +x "$HOOKS_DIR/pre-commit"
chmod +x "$HOOKS_DIR/pre-push"

echo "Git-Hooks installiert:"
echo "  .git/hooks/pre-commit  (Tier 1 — Haiku)"
echo "  .git/hooks/pre-push    (Tier 2 — Sonnet, parallel)"
echo ""
echo "Naechste Schritte:"
echo "  1. CLAUDE.md ins Projekt-Root kopieren"
echo "  2. .claude/ Ordner ins Projekt-Root kopieren"
echo "  3. docs/DEV_WORKFLOW.md ins Projekt kopieren"
