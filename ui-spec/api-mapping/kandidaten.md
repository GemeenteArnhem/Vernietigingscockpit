# API Mapping – Kandidaten

## Endpoint
GET /selecties/latest/kandidaten

## Response → UI

response.kandidaten[] → tabel rijen

Velden:
- id → id
- titel → titel
- aantalObjecten → Aantal objecten
- aantalBetrokkenen → Aantal betrokkenen
- status → status badge
- reden → reden

## UI acties → backend

PATCH /kandidaten/{id}

Body:
- uitgesloten (boolean)
- toelichting (string)

## Regels
- data is snapshot
- wijzigingen zijn direct persistente updates in dossier

## Bulk updates

Endpoint:
PATCH /kandidaten/bulk

Body:
{
  kandidaatIds: string[],
  uitgesloten: boolean,
  toelichting: string (optioneel)
}

## Gedrag

- updates worden per kandidaat verwerkt
- response bevat status per kandidaat

## Validatie

- backend valideert:
  - toelichting verplicht bij uitgesloten = true
- fouten worden per kandidaat geretourneerd

## Response mapping

response.results[]:
- id
- status (SUCCESS / FAILED)
- foutmelding (optioneel)

→ UI toont fouten per kandidaat

## Voorleggen

Endpoint:
POST /taken/{id}/beoordeling/voorleggen

Gedrag:
- valideert dat alle kandidaten beoordeeld zijn
- valideert dat elke uitsluiting een reden en toelichting heeft
- berekent de lijst-hash
- voert de transition `beoordeling → accordering_po` uit
- schrijft een audit-event
