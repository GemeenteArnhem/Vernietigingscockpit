# State: Audit Event Model

## Doel
Definieert hoe audit events worden opgeslagen en weergegeven.

Dit model is de bron van waarheid voor:
- audit log
- compliance
- reconstructie van acties

---

## Belangrijk principe

- elk relevant systeem- en gebruikersactie wordt vastgelegd
- events zijn onveranderbaar
- events zijn chronologisch

---

## Event structuur

event:

- id (uniek)
- timestamp (datetime)
- actor:
  - type: user | system
  - id
  - naam
- actie (string, gestandaardiseerd)
- entiteit:
  - type (bijv. taak, object, batch)
  - id
- details (optioneel, JSON)

---

## Standaard acties (enige geldige set)

### Taak

- TASK_CREATED
- TASK_STARTED
- TASK_COMPLETED

---

### Selectie

- SELECTION_REQUESTED
- SELECTION_COMPLETED

---

### Kandidaten

- OBJECT_EXCLUDED
- OBJECT_INCLUDED
- OBJECT_UPDATED

---

### Accordering

- APPROVAL_GRANTED
- APPROVAL_REJECTED

---

### Uitvoering

- EXECUTION_STARTED
- BATCH_STARTED
- BATCH_COMPLETED
- OBJECT_PROCESSED
- OBJECT_FAILED

---

### Resultaat

- EXECUTION_COMPLETED
- CERTIFICATE_GENERATED

---

## Details veld (voorbeeld)

Voor OBJECT_EXCLUDED:

{
  "objectId": "123",
  "reden": "Niet vernietigen",
  "toelichting": "..."
}

---

Voor APPROVAL_REJECTED:

{
  "reden": "Onvoldoende onderbouwing"
}

---

Voor OBJECT_FAILED:

{
  "objectId": "123",
  "foutmelding": "Niet gevonden"
}

---

## Regels

- events worden nooit aangepast of verwijderd
- events zijn append-only
- volgorde is leidend voor reconstructie

---

## Relatie met UI

- AuditLog component toont deze events
- UI mag events niet interpreteren, alleen weergeven

---

## Relatie met systeem

- elke UI-actie → minimaal één audit event
- backend is verantwoordelijk voor registratie

---

## UX-principes

- transparantie
- herleidbaarheid
- vertrouwen

---

## Samenvatting

Dit model zorgt ervoor dat:

- elke stap in het proces traceerbaar is
- audit log volledig en betrouwbaar is
- systeem voldoet aan compliance eisen