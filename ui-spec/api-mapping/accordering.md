# API Mapping – Accordering

## Goedkeuren

POST /taken/{id}/accordering

body:
{
  actie: "goedkeuren",
  toelichting: string (optioneel)
}

---

## Terugsturen

POST /taken/{id}/accordering

body:
{
  actie: "terugsturen",
  toelichting: string (verplicht)
}

---

## Resultaat

- workflow status wordt aangepast
- audit log entry wordt toegevoegd