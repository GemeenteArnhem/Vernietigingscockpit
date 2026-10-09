# Component: ResultTable

## Doel
Toont de resultaten van de vernietiging per object.

Geeft inzicht in:
- wat er daadwerkelijk is gebeurd
- welke fouten zijn opgetreden

---

## Context

- zichtbaar tijdens:
  - uitvoering
  - resultaat

- read-only
- geen bewerkingen mogelijk

---

## Belangrijk principe

- zelfde structuur als vernietigingslijst
- maar zonder edit-functionaliteit
- toont werkelijkheid (geen intentie)

---

## Input (vanuit API)

GET /taken/{id}/resultaten

---

## Tabel

### Primaire kolommen (aligned met kandidaten)

- naam
- omvang
- bewaartermijn
- einddatum bewaartermijn
- status (verwerkingsstatus)
- reden
- foutmelding

## Kolomgedrag

### naam
- identiek aan vernietigingskandidaat
- primaire scan-kolom
- GEEN subtitel of metadata onder de titel

---

### omvang
- aantal onderliggende objecten
- numeriek
- rechts uitgelijnd

---

### bewaartermijn
- in jaren
- compact weergegeven

---

### einddatum bewaartermijn
- formaat: "MM-YYYY"

---

### status

Toont:

- SUCCESS
- FAILED
- SKIPPED
- NOT_FOUND

Visueel:

- zelfde badge-stijl als kandidaten

---

### foutmelding

- alleen gevuld bij FAILED
- vervangt “toelichting” uit kandidaten
- korte, begrijpelijke tekst

---

## Secundaire metadata (zelfde structuur als kandidaten)

Beschikbaar via expand:

- id
- identificatie (kenmerk + bron)
- classificatie
- dekking in tijd (begindatum – einddatum)
- informatiecategorie (met selectielijst)
- waardering
- stekker_naam

---

## Gedrag

- volledig read-only
- geen selectie
- geen bulk acties

---

## Filtering (optioneel)

- filter op status (SUCCESS / FAILED / etc.)
- helpt bij analyse van fouten

---

## Sortering

### Standaard sortering

- kolom: einddatum bewaartermijn
- volgorde: oplopend (oud → nieuw)
- formaat: YYYY-MM

---

### Interactie

- alle kolommen zijn sorteerbaar
- klik op kolomheader:
  - eerste klik → oplopend
  - tweede klik → aflopend
  - derde klik → reset

---

### Visueel

- sorteer indicator (pijl)
- actieve kolom duidelijk gemarkeerd

---

## Relatie met andere componenten

- ContextPanel → toont totalen
- StekkerStatus → toont voortgang per bron
- ResultTable → toont detail per object

---

## Belangrijke regels

- structuur gelijk houden aan vernietigingslijst
- geen nieuwe kolommen introduceren zonder noodzaak
- geen bewerkvelden toevoegen

---

## Audit

Relevante events:

- object verwerkt
- object mislukt
- batch afgerond

Deze worden zichtbaar in audit log