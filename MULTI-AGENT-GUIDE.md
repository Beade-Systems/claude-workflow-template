# Multi-Agent-Setup: Claude Code + Codex ohne Kollisionen

Mehrere KI-Agenten am selben Projekt — ohne dass sie sich gegenseitig
den Code ueberschreiben. Der Trick: **Git Worktrees**. Jeder Agent bekommt
ein eigenes Verzeichnis mit eigenem Branch, alle teilen sich aber dieselbe
Git-Historie.

```
mein-projekt/                  <- Haupt-Repo (hier mergst du am Ende)
mein-projekt-worktrees/
  ├── claude/   (Branch: feature/login)     <- Claude Code arbeitet hier
  └── codex/    (Branch: feature/api-tests)  <- Codex arbeitet hier
```

---

## Warum Worktrees?

Wenn zwei Agenten im **gleichen** Ordner arbeiten, bearbeiten sie womoeglich
gleichzeitig dieselbe Datei — Chaos, Merge-Konflikte, ueberschriebene Arbeit.

Mit Worktrees ist jeder Agent physisch in einem eigenen Ordner. Erst beim
Mergen kommen die Branches zusammen — kontrolliert und sichtbar.

---

## Einrichtung

```bash
# WINDOWS: In Git Bash ausfuehren, nicht PowerShell!

# 1. Je einen Worktree pro Agent anlegen
./agent-worktree.sh new claude feature/login
./agent-worktree.sh new codex  feature/api-tests

# 2. Uebersicht pruefen
./agent-worktree.sh list
```

---

## In VS Code arbeiten

**Option A — zwei VS-Code-Fenster (am einfachsten)**
1. Fenster 1: Ordner `../mein-projekt-worktrees/claude` oeffnen — dort Claude Code starten
2. Fenster 2: Ordner `../mein-projekt-worktrees/codex` oeffnen — dort Codex starten

**Option B — ein Fenster, Multi-Root-Workspace**
1. `File > Add Folder to Workspace` — beide Worktree-Ordner hinzufuegen
2. Pro Ordner ein eigenes Terminal/Agent-Panel

---

## Wer macht was?

| Agent | Staerke | Gib ihm |
|-------|---------|---------|
| **Claude Code** | Tief, lokal, interaktiv | Architektur, komplexe Features, Security |
| **Codex** | Parallel, async, Cloud-Sandboxes | Viele kleine Tasks (Tests, Bugfixes) |

---

## Zusammenfuehren (Merge)

```bash
cd /pfad/zu/deinem/projekt
git checkout main
git merge feature/login        # Claudes Arbeit
git merge feature/api-tests    # Codex' Arbeit

# Worktree aufraeumen
./agent-worktree.sh done claude
./agent-worktree.sh done codex
```

> **Wichtig:** Vor dem Merge in `main` → `/code-review ultra` laufen lassen.

---

## Die 4 Anfaengerfehler

1. **Zwei Agenten im selben Ordner** — genau das verhindert dieses Setup.
2. **Beide am selben Feature** — teile Aufgaben so auf, dass sie verschiedene Dateien betreffen.
3. **Lange laufen lassen, dann erst schauen** — kurze Aufgaben, frueh mergen.
4. **Merge ohne Review** — jeder Agent-Branch durchlaeuft `/code-review ultra` vor main.
