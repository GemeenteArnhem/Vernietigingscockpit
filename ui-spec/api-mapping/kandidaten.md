# API Mapping – Kandidaten

## Endpoint
GET /selecties/latest/objecten

## Response → UI

response.objecten[] → tabel rijen

Velden:
- id → id
- titel → titel
- status → status badge
- reden → reden

## UI acties → backend

PATCH /objecten/{id}

Body:
- uitgesloten (boolean)
- toelichting (string)

## Regels
- data is snapshot
- wijzigingen zijn direct persistente updates in dossier

## Bulk updates

Endpoint:
PATCH /objecten/bulk

Body:
{
  objectIds: string[],
  uitgesloten: boolean,
  toelichting: string (optioneel)
}

## Gedrag

- updates worden per object verwerkt
- response bevat status per object

## Validatie

- backend valideert:
  - toelichting verplicht bij uitgesloten = true
- fouten worden per object geretourneerd

## Response mapping

response.results[]:
- id
- status (SUCCESS / FAILED)
- foutmelding (optioneel)

→ UI toont fouten per object