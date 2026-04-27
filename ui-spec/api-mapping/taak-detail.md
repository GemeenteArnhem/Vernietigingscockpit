# API Mapping – Taak detail

## Endpoint

GET /taken/{id}

## Response

{
  id,
  naam,
  status,
  aantallen: {
    totaal,
    uitgesloten,
    fouten
  },
  rol
}

---

## Conditional data loading

Afhankelijk van status:

- selectie/beoordeling:
  → GET /selecties/latest/objecten

- accordering:
  → GET /dossier

- uitvoering:
  → GET /vernietigingen/latest

- resultaat:
  → GET /vernietigingen/latest + verklaring

---

## Regels

- UI laadt alleen data die nodig is voor huidige stap
- voorkomt over-fetching

## Extra velden

GET /taken/{id}

response bevat:

- recordmanager
- startdatum

---

## Acties

PATCH /taken/{id}

body:
- recordmanager (wijzigen)

---

## Audit log

GET /taken/{id}/auditlog

response:

[
  {
    timestamp,
    gebruiker,
    actie,
    details
  }
]

## Selectie starten

POST /selecties

body:
{
  taakId
}

---

## Resultaat

- vernietingslijst wordt gegenereerd
- snapshot opgeslagen
- taak status → beoordeling