# claude-workflow-template

Token-effizienter Dev- und Security-Workflow fuer Claude Code.
Vier Sicherheits-Tiers, automatische Git-Hooks, Live-Schutz beim Coden und
MCP-Server (Exa + DeepWiki) fuer aktuelle CVE- und Doc-Checks.

> **Fuer wen?** Anfaenger, die mit Claude Code sicher SaaS- oder WebApps bauen
> wollen — ohne sich erst durch 20 Konfigurationsdateien zu kaempfen.

---

## Was ist drin?

```
CLAUDE.md                  <- Kompakte Regeln fuer Claude
.mcp.json                  <- Exa + DeepWiki MCP-Server
setup-hooks.sh             <- Installiert Git-Hooks ins Projekt
agent-worktree.sh          <- Multi-Agent Worktree-Setup
MULTI-AGENT-GUIDE.md       <- Anleitung: Claude + Codex parallel
hooks/
  pre-commit               <- Tier 1: Python-Review (Haiku, automatisch)
  pre-push                 <- Tier 2: Security + TDD parallel (Sonnet)
.claude/
  settings.json            <- Live-Schutz-Hook + Stop-Reminder
  hooks/
    guard.sh               <- Live-Block: @latest, .env, rm -rf, curl|bash
  commands/
    erklaer-mir.md         <- /erklaer-mir Slash-Command (Lernmodus)
  rules/
    backend.md             <- Rollen-Matrix, Auth-Regeln
    database.md            <- Audit-Logs, Session-Kontext
    frontend.md            <- queryKey-Regeln, kein localStorage
docs/
  DEV_WORKFLOW.md          <- Spickzettel: Wann rufe ich was auf?
  specs/_TEMPLATE.md       <- Vorlage fuer Feature-Specs
  erklaerungen/_TEMPLATE.md <- Vorlage fuer kundentaugliche Erklaerungen
```

---

## Einrichtung

### Voraussetzungen

| Was | Pruefen mit | Wenn fehlt |
|-----|-------------|------------|
| Claude Code | `claude --version` | [Installationsanleitung](https://docs.claude.com/en/docs/claude-code/overview) |
| Node.js (fuer MCP) | `node --version` | Node >= 18 installieren |
| Python 3 (fuer Hooks) | `python3 --version` | Meist vorinstalliert |
| Git | `git --version` | `apt install git` / Git for Windows |
| Exa API-Key (kostenlos) | — | [dashboard.exa.ai/api-keys](https://dashboard.exa.ai/api-keys) |

### Neues Projekt

```bash
# 1. Template klonen
git clone https://github.com/Beade-Systems/claude-workflow-template.git

# 2. Dein Projekt anlegen
mkdir mein-projekt && cd mein-projekt && git init

# 3. Template-Dateien uebernehmen
cp ../claude-workflow-template/CLAUDE.md .
cp ../claude-workflow-template/.mcp.json .
cp ../claude-workflow-template/agent-worktree.sh .
cp -r ../claude-workflow-template/.claude .
cp -r ../claude-workflow-template/docs .

# 4. Git-Hooks installieren
../claude-workflow-template/setup-hooks.sh
chmod +x .claude/hooks/guard.sh

# 5. Exa-Key setzen
# Linux/Mac:
echo 'export EXA_API_KEY="dein-key"' >> ~/.bashrc && source ~/.bashrc
# Windows (PowerShell):
[Environment]::SetEnvironmentVariable("EXA_API_KEY", "dein-key", "User")

# 6. Loslegen
claude
```

### Bestehendes Projekt erweitern

```bash
cd /pfad/zu/deinem/projekt

# Template danebenlegen
git clone https://github.com/Beade-Systems/claude-workflow-template.git /tmp/cwt

# Dateien kopieren
cp /tmp/cwt/.mcp.json .
cp /tmp/cwt/agent-worktree.sh .
cp -r /tmp/cwt/.claude .
cp -r /tmp/cwt/docs .

# CLAUDE.md: wenn vorhanden, manuell mergen statt ueberschreiben
[ -f CLAUDE.md ] && echo "CLAUDE.md existiert — manuell mergen!" || cp /tmp/cwt/CLAUDE.md .

# Git-Hooks installieren
/tmp/cwt/setup-hooks.sh
chmod +x .claude/hooks/guard.sh
```

---

## Verifizieren

```bash
claude
# Dann in Claude Code:
/mcp        # exa und deepwiki sollten "connected" zeigen

# Test des Live-Schutzes:
# Bitte Claude: "Fuehre npm install lodash@latest aus"
# → Hook muss das blockieren
```

---

## Der Workflow

### 3 Goldene Regeln
1. **Vor dem Coden:** `superpowers:brainstorming` — Security + Funktion gleichwertig
2. **Nach DB-Aenderung:** Security-Audit
3. **Vor main:** `/code-review ultra`

### Tier-Uebersicht

| Tier | Ausloeser | Modell | Was passiert | MCP |
|------|-----------|--------|--------------|-----|
| 0 | Neue Dependency | — | CVE- + Doc-Check bevor installiert wird | Exa + DeepWiki |
| 1 | `git commit` (auto) | Haiku | Schnelles Python-Review | — |
| 2 | `git push` (auto) | Sonnet | Security-Scan + TDD parallel | Exa |
| 3 | `/code-review ultra` (manuell) | Opus | Tiefes Security- + Coverage-Audit | Exa + DeepWiki |
| 4 | Frontend-Aenderung (manuell) | Sonnet | UI + State + Guardrails | — |

### Lernmodus

Nach jedem fertigen Feature:
```
/erklaer-mir feature/login (src/auth/*)
```
Claude fuehrt dich durch: Ueberblick → Verstaendnis-Fragen → Kundensimulation → Erklaerung in `docs/erklaerungen/` ablegen.

### Multi-Agent (Claude + Codex parallel)

Siehe [MULTI-AGENT-GUIDE.md](MULTI-AGENT-GUIDE.md) fuer Details.

```bash
# WINDOWS: In Git Bash ausfuehren, nicht PowerShell!
./agent-worktree.sh new claude feature/login
./agent-worktree.sh new codex  feature/api-tests
# Jeder Agent arbeitet isoliert in eigenem Branch
```

---

## Sicherheits-Prinzip

Drei Schutzebenen:
- **Git-Hooks** = Gate beim Commit/Push
- **Live-Hook (guard.sh)** = blockt gefaehrliche Befehle sofort beim Coden
- **MCP (Exa + DeepWiki)** = aktuelles Wissen (CVEs und Docs in Echtzeit)

---

## Token sparen

- `/compact` mitten in einer langen Session
- `/clear` beim Themenwechsel
- 1 Feature = 1 Session
- Teure Tiers (Opus) nur bei echten Meilensteinen

---

## Wenn etwas klemmt

| Problem | Loesung |
|---------|---------|
| `/mcp` zeigt exa nicht | `EXA_API_KEY` gesetzt? Terminal neu starten |
| Hook blockt zu viel | `.claude/hooks/guard.sh` anpassen |
| `permission denied` beim Hook | `chmod +x .claude/hooks/guard.sh` |
| Git-Hook feuert nicht | `setup-hooks.sh` erneut ausfuehren |
| Windows: agent-worktree.sh geht nicht | In Git Bash ausfuehren, nicht PowerShell |
