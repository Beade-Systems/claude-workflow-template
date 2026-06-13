# Dev & Security Workflow — Spickzettel

> Vollständige Tier-Architektur und Begründungen: siehe Projekt-Specs

## Wann rufe ich was auf?

| Ich mache...           | Ich rufe auf...               | Modell  |
|------------------------|-------------------------------|---------|
| Neues Feature planen   | `superpowers:brainstorming`   | Sonnet  |
| Architektur klären     | `@spec-refiner`               | Sonnet  |
| Nach DB-Änderung       | Security-Audit / `@rls-auditor` | Opus  |
| Nach Feature fertig    | `@qa-validator`               | Sonnet  |
| Bug suchen             | `ecc:systematic-debugging`    | Sonnet  |
| UI neu bauen           | `@ui-component-architect`     | Sonnet  |
| Store/API geändert     | `@ux-state-validator`         | Sonnet  |
| Modal/Button geändert  | `@ux-guardrail-auditor`       | Sonnet  |
| Vor jedem PR auf main  | `/code-review ultra`          | Opus    |
| Schneller Check        | `/code-review`                | Sonnet  |

## Tiers (automatisch via Git-Hooks)

```
TIER 1 — git commit  → Haiku  → ecc:python-review (staged files only)
TIER 2 — git push    → Sonnet → ecc:security-scan + ecc:tdd-workflow (parallel)
TIER 3 — vor PR      → Opus   → /code-review ultra (manuell)
TIER 4 — Frontend    → Sonnet → @ui-component-architect (manuell)
```

## Ablauf: Neues Feature

```
1. superpowers:brainstorming  ← IMMER zuerst, kein Code ohne Freigabe
2. @spec-refiner              ← Architektur + Rollen + DB klären
3. Code + Tests schreiben (TDD)
4. git commit                 ← Tier 1 automatisch
5. git push                   ← Tier 2 automatisch
6. Security-Audit             ← bei DB-Änderungen
7. @qa-validator              ← am Ende
8. /code-review ultra         ← vor PR
```

## Ablauf: Bug Fix

```
1. ecc:systematic-debugging   ← Root Cause zuerst
2. Fix + Test schreiben
3. git commit                 ← Tier 1 automatisch
4. Security-Bug? → /code-review ultra sofort
```

## Token sparen

| Situation          | Tu das               | Nicht das            |
|--------------------|----------------------|----------------------|
| Kleiner Fix        | Tier 1 reicht        | /code-review ultra   |
| Session wechseln   | /clear               | Session offen lassen |
| Lange Session      | /compact             | Weitermachen         |
| Vor PR→main        | /code-review ultra   | Überspringen         |

## Lernmodus

Nach jedem fertigen Feature:
```
/erklaer-mir feature/login (src/auth/*)
```
Erzeugt eine kundentaugliche Erklaerung in `docs/erklaerungen/`.

## Multi-Agent (optional)

```bash
# In Git Bash (nicht PowerShell):
./agent-worktree.sh new claude feature/login
./agent-worktree.sh new codex  feature/api-tests
./agent-worktree.sh list
./agent-worktree.sh done claude
```

## Goldene Regeln

1. Vor dem Coden → `superpowers:brainstorming`
2. Nach DB-Änderung → Security-Audit
3. Vor main → `/code-review ultra`
4. Session wechseln → `/clear`
