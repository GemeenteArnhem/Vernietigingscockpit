# API Mapping – Uitvoering

## Start vernietiging

POST /vernietigingen

body:
{
  taakId
}

---

## Status ophalen

GET /vernietigingen/latest

Response:

{
  status: RUNNING | COMPLETED | PARTIAL | FAILED,
  totaal,
  successen,
  fouten
}

---

## Resultaten per object

GET /vernietigingen/latest/batches

GET /vernietigingen/latest/batches/{batchNummer}

---

## Mapping naar UI

- status → voortgang + labels
- resultaten → result table
- fouten → foutmelding per object