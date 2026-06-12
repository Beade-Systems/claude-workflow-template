# Backend Rules

## Rolle x Ressource
Prüfe bei jeder neuen API-Route die Berechtigungen anhand der Projekt-Rollen-Matrix.
- Definiere deine Rollen hier: z.B. Admin, User, ReadOnly, Service
- Validiere tenant_id / org_id immer aus der Session — nie aus dem Request-Body

## Security First
- Auth-Decorator auf jeder geschützten Route
- Input-Validierung an allen API-Grenzen
- Keine sensiblen Daten in Logs
