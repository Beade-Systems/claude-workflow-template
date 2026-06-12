# Database Rules

## Queries
- Session-Kontext setzen bevor Queries laufen (z.B. SET LOCAL app.user_id)
- Fail-closed: kein globaler Fallback bei fehlendem Kontext

## Audit Logs
- Append-only — kein UPDATE/DELETE auf Audit-Tabellen
- tenant_id / org_id in jeden Audit-Eintrag schreiben

## Migrationen
- Immer in Reihenfolge einspielen
- Rollback-Plan vor jedem Deploy dokumentieren
