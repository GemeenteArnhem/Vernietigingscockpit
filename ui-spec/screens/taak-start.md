# Screen: Taak starten

## Doel
Initialiseren van een nieuwe vernietigingstaak.

De gebruiker:
- controleert betrokken stekkers
- start expliciet de selectie

---

## Context

- taak is net aangemaakt
- nog geen kandidaten beschikbaar
- selectie is nog niet uitgevoerd

---

## Layout

### Header

Toont:
- taaknaam
- status: "Niet gestart"
- recordmanager
- startdatum

---

### Stekker overzicht

Toont per stekker:

- naam bron
- type
- status (beschikbaar / fout)
- laatste synchronisatie (optioneel)

---

### Actie

- knop: "Selectie ophalen"

---

## Gedrag

Bij klikken:

- cockpit vraagt stekkers om kandidaten
- snapshot wordt opgeslagen
- audit log entry wordt gemaakt
- status → beoordeling