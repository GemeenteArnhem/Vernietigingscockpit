# API Mapping – Uitvoering

## Start vernietiging

POST /taken/{id}/vernietigingsopdracht

Gedrag:
- valideert taak.status == vrijgegeven
- valideert dat de gebruiker recordmanager is voor deze taak
- controleert de lijst-hash van de archivarisvrijgave
- zet de workflowstatus naar uitvoering
- zet worker-jobs klaar voor technische vernietiging via de stekkers

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
