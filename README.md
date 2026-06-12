# claude-workflow-template

Token-effizienter Dev + Security Workflow für Claude Code Projekte.

## Was ist drin?

```
CLAUDE.md                  <- Kompakte Instruktionen für Claude (54 Zeilen)
setup-hooks.sh             <- Installiert Git-Hooks in ein bestehendes Projekt
hooks/
  pre-commit               <- Tier 1: Python-Review (Haiku, automatisch)
  pre-push                 <- Tier 2: Security + TDD parallel (Sonnet, automatisch)
.claude/
  settings.json            <- Stop-Hook Reminder nach jeder Claude-Antwort
  rules/
    backend.md             <- Rollen-Matrix, Auth-Regeln
    database.md            <- Audit-Logs, Session-Kontext
    frontend.md            <- queryKey-Regeln, kein localStorage
docs/
  DEV_WORKFLOW.md          <- Spickzettel: Wann rufe ich was auf?
```

## Neues Projekt einrichten

```bash
# 1. Template klonen
git clone https://github.com/Beade-Systems/claude-workflow-template.git

# 2. Hooks installieren (aus dem Projekt-Root aufrufen)
/pfad/zu/claude-workflow-template/setup-hooks.sh

# 3. Konfigurationsdateien kopieren
cp /pfad/zu/claude-workflow-template/CLAUDE.md .
cp -r /pfad/zu/claude-workflow-template/.claude .
cp -r /pfad/zu/claude-workflow-template/docs .
```

## Tier-Übersicht

| Tier | Auslöser | Modell | Skills |
|------|----------|--------|--------|
| 1 | git commit (auto) | Haiku | ecc:python-review |
| 2 | git push (auto) | Sonnet | ecc:security-scan + ecc:tdd-workflow |
| 3 | /code-review ultra (manuell) | Opus | Security + Coverage Audit |
| 4 | Frontend-Änderungen (manuell) | Sonnet | UI + State + Guardrails |

## 3 Goldene Regeln

1. Vor dem Coden: superpowers:brainstorming (Ziel: Security + Funktion)
2. Nach DB-Änderung: Security-Audit
3. Vor main: /code-review ultra

## Token sparen

- /compact mitten in langer Session
- /clear beim Thema wechseln
- 1 Feature = 1 Session
