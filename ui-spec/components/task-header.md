# Component: TaskHeader

## Doel
Toont de kerninformatie van een vernietigingslijst (taak) en de primaire actie.

De header is gericht op:
- status
- eigenaarschap
- actie

---

## Input (vanuit state)

- taak.naam
- taak.status
- taak.recordmanager
- taak.startdatum
- taak.einddatum (optioneel)

- state.primary_action_label
- state.primary_action_enabled

---

## Toont

## Breadcrumb

Toont:

Taken → {taak.naam} → Vernietigingslijst → {status}

Voorbeeld:

Taken → Zorgdomein → Vernietigingslijst → Beoordeling

### Titel

- naam van de vernietigingslijst (taaknaam)

Voorbeeld:

Zorgdomein

---

### Status

- huidige workflow status (label)

Voorbeeld:

Status: Beoordeling

---

### Metadata

- toegewezen recordmanager
- startdatum
- einddatum (indien aanwezig)

---

### Primary action

- maximaal 1 knop
- label afhankelijk van state
- enabled/disabled afhankelijk van state

---

## Voorbeelden labels (primary action)

- "Selectie ophalen"
- "Door naar accordering"
- "Goedkeuren"
- "Vernietigen"
- "Archiveren"

---

## Layout

- titel linksboven (prominent)
- status direct onder of naast titel
- metadata secundair (kleiner, onder titel)
- primary action rechts uitgelijnd

---

## Gedrag

- klik op primary action triggert actie uit state/API
- component bevat geen eigen logica
- status is leidend voor gedrag en zichtbaarheid van actie

---

## UX-regels

- status bepaalt de fase van de vernietigingslijst
- termen zoals "concept" worden niet expliciet getoond
- statuscommunicatie gebeurt uitsluitend via workflow status
- header blijft consistent over alle schermen (beoordeling, accordering, uitvoering, resultaat)

---

## Niet tonen

- aantallen (horen in contextblok)
- validatie details
- workflow navigatie

---

## Belangrijke regels

- header is compact
- gericht op actie, niet op inhoud
- alle beslisinformatie zit elders (contextblok)
- terminologie is consistent: altijd "vernietigingslijst"
- taak.naam is leidend (geen technische naam)
- "Vernietigingslijst" is vaste stap binnen taak
- status is laatste element