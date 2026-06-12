# Frontend Rules

## State
- queryKey muss immer tenant_id / org_id enthalten (verhindert Cache-Leak beim Mandantenwechsel)
- Rollen/Permissions nie in localStorage — immer frisch vom API laden

## Stores
1. Session Store: Login-Daten, aktive tenant_id
2. Server Store (React Query): API-Cache
3. AppState Store: temporäre UI-Zustände
4. Tweaks Store: persistente lokale Einstellungen (localStorage)
