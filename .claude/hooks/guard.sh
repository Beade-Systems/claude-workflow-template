#!/bin/bash
# .claude/hooks/guard.sh
# Merged PreToolUse-Hook: Live-Schutz beim Coden.
# Kombiniert safety-check + dependency-guard in einer Datei.
# Exit 2 = blockiert + Hinweis an Claude. Exit 0 = erlaubt.

INPUT=$(cat)

parse() {
  echo "$INPUT" | python3 -c "
import json,sys
d=json.load(sys.stdin)
v=d
for k in '$1'.split('.'):
    v=v.get(k,{}) if isinstance(v,dict) else ''
print(v if isinstance(v,str) else '')
" 2>/dev/null
}

TOOL=$(parse tool_name)
CMD=$(parse tool_input.command)
FILE=$(parse tool_input.file_path)

block() { echo "BLOCKED: $1" >&2; exit 2; }

# -- Bash-Befehle pruefen --
if [ "$TOOL" = "Bash" ] && [ -n "$CMD" ]; then

  # Destruktive Befehle
  echo "$CMD" | grep -qE 'rm\s+(-[a-zA-Z]*r[a-zA-Z]*f|-[a-zA-Z]*f[a-zA-Z]*r)\s+(/|\$HOME|~)' \
    && block "rm -rf auf / oder Home-Verzeichnis"
  echo "$CMD" | grep -qE '\bmkfs|\bdd\s+.*of=/dev/' \
    && block "Festplatten-/Filesystem-Befehl"
  echo "$CMD" | grep -qE 'chmod\s+(-R\s+)?777' \
    && block "chmod 777 - unsichere Berechtigungen"

  # Git-Gefahren
  echo "$CMD" | grep -qE 'git\s+push\s+.*(--force|-f)\b.*\b(main|master)\b' \
    && block "Force-Push auf main/master"
  echo "$CMD" | grep -qE 'git\s+(reset\s+--hard|clean\s+-[a-z]*f)' \
    && block "Destruktiver Git-Befehl (reset --hard / clean -f)"

  # Secrets auslesen
  echo "$CMD" | grep -qE '(cat|less|more|head|tail|grep|strings)\s+.*\.env' \
    && block "Direkter Zugriff auf .env-Datei"
  echo "$CMD" | grep -qE '(cat|less|grep)\s+.*(id_rsa|id_ed25519|\.pem|\.key)\b' \
    && block "Zugriff auf private Schluessel"

  # Remote-Code-Execution
  echo "$CMD" | grep -qE '(curl|wget)\s+[^|]*\|\s*(bash|sh|zsh)' \
    && block "curl|bash - Remote-Code-Ausfuehrung"

  # Datenbank-Destruktion
  echo "$CMD" | grep -qiE '(drop\s+(database|table)|truncate\s+table)' \
    && block "Destruktiver DB-Befehl - manuell bestaetigen"

  # Dependency-Install ohne Pin
  echo "$CMD" | grep -qE '(npm\s+i(nstall)?|pnpm\s+add|yarn\s+add|pip\s+install)\s+[^@<>=]*@(latest|next)\b' \
    && block "Install mit @latest/@next. Erst Exa CVE-Check + exakte Version pinnen."

  # Dependency-Install: Erinnerung an CVE-Check
  echo "$CMD" | grep -qE '(npm\s+i(nstall)?|pnpm\s+add|yarn\s+add|pip\s+install)\s+[a-z@]' \
    && echo "HINWEIS: Vor diesem Install Exa-CVE-Check durchgefuehrt? (siehe CLAUDE.md MCP-Pflicht)" >&2
fi

# -- Datei-Zugriffe pruefen (Read/Edit/Write) --
if [ -n "$FILE" ]; then
  case "$FILE" in
    *.env|*.env.*|*id_rsa*|*id_ed25519*|*.pem|*.key|*credentials*|*secrets*)
      block "Secret-Datei: $FILE" ;;
  esac
fi

exit 0
