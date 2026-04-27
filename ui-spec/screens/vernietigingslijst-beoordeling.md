# Screen: Vernietigingslijst (beoordeling)

## Doel
Beoordelen en voorbereiden van een vernietigingslijst door de recordmanager.

De gebruiker kan:
- objecten uitsluiten
- reden en toelichting vastleggen

---

## Context

- onderdeel van taak-detail
- zichtbaar bij:
  - taak.status == beoordeling

- vernietigingslijst is een snapshot (verandert niet tijdens beoordeling)
- data komt uit taakcontext (niet direct uit stekker)

---

## Belangrijk principe

- editability wordt volledig bepaald door state.is_editable
- dit scherm bevat geen eigen logica over workflow of rechten
- UI werkt altijd op de vernietigingslijst binnen de taak

---

## Data source

GET /taken/{id}/kandidaten

---

## Layout

### 1. Filters

Velden:

- zoekveld (titel)
- status filter
- reden filter

Gedrag:

- filters werken direct
- filters beïnvloeden alleen zicht, niet data

---

## Tabel

### Primaire kolommen (altijd zichtbaar)

- selectie (checkbox)
- titel
- omvang
- bewaartermijn
- vernietigingsdatum
- status (verwerkingsstatus)
- reden
- toelichting

---

### Secundaire metadata (via expand)

Velden:

- id
- bron_id
- code
- periode (startdatum - einddatum)
- selectielijst
- grondslag
- bron_systeem

---

## Kolomgedrag

### titel
- primaire scan-kolom
- eventueel met subtitel (onderwerp)

---

### periode
- formaat: "MM-YYYY — MM-YYYY"

---

### vernietigingsdatum
- formaat: "MM-YYYY"

---

### status

Toont:

- SUCCESS
- FAILED
- SKIPPED
- NOT_FOUND

Visueel:

- StatusBadge component

---

### reden

- dropdown / select
- verplicht indien uitgesloten == true

---

### toelichting

- inline tekstveld
- verplicht indien uitgesloten == true
- toont validatie direct onder veld
- groeit mee met inhoud (auto-expand)

---

### omvang

- aantal onderliggende objecten
- numeriek
- rechts uitgelijnd

---

## Interactie

### Uitsluiten

- checkbox → uitgesloten = true
- reden verplicht
- toelichting verplicht

---

### Inline editing

- reden: select
- toelichting: tekstveld

---

### Bulk selectie (optioneel)

- selectie via checkboxes
- bulk acties mogelijk (bijv. uitsluiten)

---

### Expand

Per rij:

- toont secundaire metadata

---

## Validatie

### Objectniveau

Indien:

uitgesloten == true

Dan verplicht:

- reden
- toelichting

---

### Foutmelding (inline)

- direct onder veld
- gekoppeld aan input

Voorbeeld:

"Toelichting is verplicht bij uitsluiten"

---

## Belangrijke UX-regels

- maximaal ~8 kolommen zichtbaar
- geen horizontale scroll als default
- primaire kolommen blijven altijd zichtbaar
- secundaire info alleen via expand

---

## Relatie met workflow

- alleen editable bij status == beoordeling
- bij accordering → volledig read-only

---

## Actie (via TaskHeader)

- "Door naar accordering"

Voorwaarden:

- alle objecten beoordeeld
- geen validatiefouten

---

## Audit

Relevante events:

- OBJECT_EXCLUDED
- OBJECT_INCLUDED
- OBJECT_UPDATED

Deze worden zichtbaar in audit log