# Component: DecisionPanel

## Doel
Faciliteert het nemen van een besluit tijdens accordering.

De gebruiker kan:
- goedkeuren
- terugsturen

---

## Context

- alleen zichtbaar tijdens:
  - accordering_po
  - accordering_archivaris

- vernietingslijst is read-only
- focus ligt volledig op besluitvorming

---

## Belangrijk principe

- beslissingen zijn expliciet
- elke beslissing wordt vastgelegd (audit)
- geen impliciete acties

---

## Input (vanuit state)

- kan_goedkeuren (boolean)
- kan_terugsturen (boolean)

- toelichting (string)

---

## Inhoud

### 1. Toelichting veld

- tekstveld
- optioneel bij goedkeuren
- verplicht bij terugsturen

---

### 2. Acties

- knop: "Goedkeuren"
- knop: "Terugsturen"

---

## Gedrag

### Goedkeuren

- direct uitvoeren (of met confirmatie)
- zet taak naar volgende workflow stap

---

### Terugsturen

- vereist toelichting
- zet taak terug naar beoordeling

---

## Validatie

### Bij goedkeuren

- geen verplichte velden

---

### Bij terugsturen

- toelichting verplicht

Foutmelding:

"Toelichting is verplicht bij terugsturen"

---

## State gedrag

- knoppen enabled/disabled op basis van state
- component bevat geen eigen businesslogica

---

## Audit

De volgende events worden vastgelegd:

- accordering goedgekeurd
- accordering teruggestuurd
- toelichting toegevoegd

---

## UX-principes

- duidelijk onderscheid tussen acties
- geen ambiguïteit
- fouten voorkomen (validatie vooraf)

---

## Niet doen

- geen bewerkingen aan data
- geen workflow logica in component
- geen automatische beslissingen

---

## Optioneel (aanbevolen)

Confirmatie bij goedkeuren:

"Je staat op het punt deze taak goed te keuren. Doorgaan?"

Doel:
- extra zekerheid bij kritische actie