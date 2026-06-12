# CLAUDE.md
> Vollständiger Workflow: `docs/DEV_WORKFLOW.md`

## Kernregeln
1. **Denk zuerst** — Annahmen benennen, bei Unklarheit fragen, einfachste Lösung bevorzugen.
2. **Minimal** — Kein Code über das Gefragte hinaus. Keine spekulativen Abstraktionen.
3. **Chirurgisch** — Nur anfassen was nötig ist. Fremden Code nicht "verbessern".
4. **Verifizierbar** — Jede Aufgabe in testbare Kriterien übersetzen, dann erfüllen.

## Workflow

### Neues Feature
1. `superpowers:brainstorming` — ZUERST. Fragt aus: Funktion, Rollen, Security, Datenmodell. Kein Code ohne Freigabe.
2. `@spec-refiner` — Architektur klären (falls vorhanden).
3. Code + Tests (TDD). `git commit` → Tier 1 auto. `git push` → Tier 2 auto.
4. Security-Audit nach Bedarf (siehe DEV_WORKFLOW.md).
5. `/code-review ultra` (Opus) vor PR auf `main`/`develop`.

### Bug Fix
1. `ecc:systematic-debugging` — Root Cause zuerst. Dann Fix + Test.
2. Security-Bug → `/code-review ultra` sofort.

### Frontend
`@ui-component-architect` → `@ux-state-validator` → `@ux-guardrail-auditor`

## 3 Goldene Regeln
- **Vor dem Coden:** `superpowers:brainstorming` — Ziel: Security + Funktion gleichwertig
- **Nach DB-Änderung:** Security-Audit — immer
- **Vor main:** `/code-review ultra` — letzter Schutz

## Modelle
Haiku = Tier 1 (Commit) | Sonnet = Tier 2 + Frontend | Opus = Tier 3 PR-Audit
