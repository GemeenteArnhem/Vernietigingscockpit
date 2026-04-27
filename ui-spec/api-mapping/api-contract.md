# API Contract – Vernietigingscockpit

## Doel
Definieert alle API endpoints voor de applicatie.

Deze contracten sluiten aan op:
- task-state-machine
- task-detail-state
- audit-event-model

---

## Belangrijk principe

- API is state-driven
- UI stuurt via acties, niet via directe data manipulatie
- backend beheert workflow transitions
- alle data is taak-gebaseerd (geen globale endpoints)

---

# 1. Taken

## Overzicht

GET /taken

Response:

[
  {
    id,
    naam,
    status,
    recordmanager,
    startdatum,
    einddatum
  }
]

---

## Detail

GET /taken/{id}

Response:

{
  id,
  naam,
  status,
  recordmanager,
  startdatum,
  einddatum,
  aantallen: {
    totaal,
    uitgesloten,
    fouten
  }
}

---

## Recordmanager wijzigen

PATCH /taken/{id}

body:
{
  recordmanager
}

---

# 2. Selectie

## Start selectie (snapshot maken)

POST /taken/{id}/selectie

Response:

{
  status: "beoordeling"
}

---

## Vernietigingslijst ophalen

GET /taken/{id}/kandidaten

Response:

[
  {
    id,                       // technisch ID binnen vernietigingslijst
    bron_id,                  // identificatie van informatieobject
    bron_systeem,             // naam van bronsysteem

    titel: string,
    code: string,

    startdatum: date,
    einddatum: date,

    omvang: integer,

    selectielijst: integer,
    grondslag: string,

    bewaartermijn: integer,
    vernietigingsdatum: date,

    // beoordeling
    uitgesloten: boolean,
    reden: string,
    toelichting: string,

    // verwerking
    verwerkingsstatus: string,
    foutmelding: string
  }
]

---

## Vernietigingslijst bijwerken

PATCH /taken/{id}/kandidaten

body:

[
  {
    id,
    uitgesloten,
    reden,
    toelichting
  }
]

---

# 3. Accordering

POST /taken/{id}/accordering

body:

{
  actie: "goedkeuren" | "terugsturen",
  toelichting: string (verplicht bij terugsturen)
}

---

## Response

{
  status // nieuwe workflow status
}

---

# 4. Uitvoering

## Start vernietiging

POST /taken/{id}/uitvoering

Response:

{
  status: "uitvoering"
}

---

## Status per bron

GET /taken/{id}/uitvoering

Response:

{
  status: RUNNING | COMPLETED | FAILED,
  stekkers: [
    {
      bron_systeem,
      totaal,
      verwerkt,
      status
    }
  ]
}

---

## Resultaten per object

GET /taken/{id}/resultaten

Response:

[
  {
    id,
    titel,
    omvang,
    bewaartermijn,
    vernietigingsdatum,
    verwerkingsstatus,
    foutmelding
  }
]

---

# 5. Resultaat

## Vernietigingsverklaring

GET /taken/{id}/verklaring

Response:

{
  datum,
  tekst,
  verantwoordelijken: []
}

---

## Export

GET /taken/{id}/export

---

# 6. Audit log

GET /taken/{id}/auditlog

Response:

[
  {
    id,
    timestamp,
    actor,
    actie,
    details
  }
]

---

# Regels

- backend beheert status transitions
- UI mag geen status direct wijzigen
- elke actie genereert audit event
- responses zijn consistent met state model
- alle endpoints zijn taak-gebaseerd

---

# Fouten

- 400 → validatiefout
- 403 → geen rechten
- 409 → verkeerde state (bijv. actie niet toegestaan)
- 500 → systeemfout