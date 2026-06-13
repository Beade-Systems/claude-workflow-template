# Erklaerung: [Feature-Name]

> Ziel: So aufgeschrieben, dass du es einem Kunden ohne Technikwissen
> erklaeren kannst.

**Datum:** [JJJJ-MM-TT]
**Branch/Commit:** [z.B. feature/login @ a1b2c3d]

---

## 1. Was macht dieses Feature? (1-2 Saetze, kundentauglich)
[z.B. "Nutzer koennen sich mit E-Mail und Passwort anmelden. Nach 5
falschen Versuchen wird das Konto fuer 15 Minuten gesperrt."]

## 2. Wie funktioniert es? (Schritt fuer Schritt, einfach)
1. [z.B. Nutzer gibt E-Mail + Passwort ein]
2. [Server prueft, ob das Passwort stimmt]
3. [Bei Erfolg: Nutzer bekommt eine sichere Sitzung]
4. [Bei Fehler: Zaehler hoch, ggf. Sperre]

## 3. Warum haben wir es SO gebaut? (Begruendung fuer den Kunden)
[z.B. "Die Sperre nach 5 Versuchen schuetzt vor Hackern, die Passwoerter
durchprobieren."]

## 4. Was passiert, wenn etwas schiefgeht?
- Nutzer macht X falsch: [was sieht er?]
- Technischer Fehler: [was passiert?]

## 5. Wo sind die Daten? (DSGVO)
- Welche Daten: [z.B. E-Mail, verschluesseltes Passwort]
- Wo gespeichert: [z.B. PostgreSQL, Server in DE]
- Wer hat Zugriff: [z.B. nur der angemeldete Nutzer + Admin]

## 6. Bewusste Grenzen (was kann es NICHT)
[z.B. "Noch kein Login ueber Google/Apple."]

---

## Betroffene Dateien (technisch)
- `[pfad/datei.py]` - [was steht da drin]

## Meine offenen Fragen
- [ ] [Was du selbst noch nicht 100% verstanden hast]
