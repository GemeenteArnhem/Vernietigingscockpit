# Screen: Taken

## Doel
Overzicht van alle vernietigingstaken (vernietigingslijsten).

De gebruiker kan:
- taken bekijken
- prioriteit zien
- een taak openen

---

## Belangrijk principe

- lijst is gesorteerd op prioriteit (niet chronologisch)
- taken die actie vereisen staan bovenaan
- gebruiker hoeft niet te zoeken → systeem stuurt

---

## Data source

GET /taken

---

## Layout

### Lijstweergave

Toont een lijst van TaskCards.

---

## TaskCard

### Toont

- naam van de vernietigingslijst
- status (workflow stap)
- aantal objecten
- aantal fouten (indien > 0)
- startdatum
- tijd in huidige stap

---

## Status labels

- Init
- Beoordeling
- Accordering
- Uitvoering
- Resultaat
- Archief

---

## Visuele signalen

### Actie vereist

- taken met status:
  - beoordeling
  - accordering_po
  - accordering_archivaris

→ visueel benadrukt (bijv. accent kleur)

---

### Fouten

- aantal_fouten > 0
→ visueel signaal (bijv. rood label of badge)

---

### In uitvoering

- status == uitvoering
→ subtiele voortgangsindicatie

---

### Afgerond

- status == resultaat of archief
→ minder prominent weergegeven

---

## Sortering (vanuit API)

Prioriteit:

1. actie vereist (beoordeling, accordering)
2. taken met fouten
3. uitvoering
4. geplande taken
5. afgeronde taken

Binnen groep:

- sorteer op tijd_in_stap (aflopend)

---

## Interactie

### Klik op taak

- opent taak-detail scherm

---

## Filtering (optioneel)

- status
- periode
- zoek op naam

---

## Gedrag

- lijst wordt geladen bij openen scherm
- geen client-side herordening
- UI volgt volgorde van API

---

## Belangrijke regels

- terminologie is consistent: "vernietigingslijst"
- status bepaalt visuele prioriteit
- geen dubbele informatie tonen
- lijst is scanbaar (geen overvolle cards)

---

## Relatie met andere schermen

- klik → opent taak-detail
- status bepaalt welk scherm daar zichtbaar is
- lijst reflecteert realtime status van taken

---

## Audit

- geen directe audit interactie
- audit zichtbaar binnen taak-detail