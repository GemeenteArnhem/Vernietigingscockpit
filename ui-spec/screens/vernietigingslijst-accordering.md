# Screen: Vernietigingslijst (accordering)

## Doel
Beoordelen en accorderen van een vernietigingslijst.

De gebruiker (proceseigenaar of archivaris) neemt een besluit:
- goedkeuren
- terugsturen

---

## Context

- onderdeel van taak-detail
- zichtbaar bij:
  - taak.status == accordering_po
  - taak.status == accordering_archivaris

- vernietigingslijst is read-only
- geen bewerkingen mogelijk

---

## Belangrijk principe

- dit scherm is gericht op besluitvorming
- data is read-only
- acties zijn expliciet en beperkt
- structuur blijft identiek aan vernietigingslijst (beoordeling)

---

## Data source

GET /taken/{id}/kandidaten

---

## Layout

### 1. Contextblok (ContextPanel)

Toont:

- totaal aantal objecten
- aantal uitgesloten
- aantal afwijkingen
- belangrijke signalen

---

### 2. Vernietigingslijst (read-only)

Gebruikt dezelfde structuur als beoordeling, maar zonder edit-functionaliteit.

### Primaire kolommen

- titel
- omvang
- bewaartermijn
- vernietigingsdatum
- status (verwerkingsstatus)
- reden
- toelichting

---

## Gedrag

- geen checkboxes
- geen invoervelden
- alleen lezen en beoordelen

---

### 3. Beslisblok (DecisionPanel)

---

## Inhoud

### Toelichting

- tekstveld
- optioneel bij goedkeuren
- verplicht bij terugsturen

---

### Acties

- knop: "Goedkeuren"
- knop: "Terugsturen"

---

## Validatie

### Goedkeuren

- geen verplichte velden

---

### Terugsturen

- toelichting verplicht

Foutmelding:

"Toelichting is verplicht bij terugsturen"

---

## Acties (API mapping)

POST /taken/{id}/accordering

body:

{
  actie: "goedkeuren" | "terugsturen",
  toelichting: string
}

---

## Rolgedrag

### Proceseigenaar

- kan accorderen in status accordering_po

---

### Archivaris

- kan accorderen in status accordering_archivaris

---

## Workflow gedrag

### Goedkeuren

- accordering_po → accordering_archivaris
- accordering_archivaris → uitvoering

---

### Terugsturen

- status → beoordeling
- vernietigingslijst wordt opnieuw bewerkbaar

---

## Belangrijke regels

- geen wijzigingen aan data in deze fase
- alleen besluitvorming
- vernietigingslijst wordt integraal beoordeeld (geen partiële accordering)
- alle acties worden vastgelegd in audit log

---

## Consistentie met andere schermen

- zelfde kolomstructuur als vernietigingslijst
- zelfde veldnamen
- zelfde visuele opbouw

Verschillen:

- geen selectie
- geen edit velden
- geen inline validatie (alleen besluitvorming)

---

## Audit

Relevante events:

- APPROVAL_GRANTED
- APPROVAL_REJECTED