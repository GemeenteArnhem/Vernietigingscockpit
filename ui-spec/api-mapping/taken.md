# API Mapping – Taken overzicht

## Endpoint

GET /taken

## Response

[
  {
    id: string,
    naam: string,
    status: string,
    aantal_objecten: number,
    aantal_fouten: number,
    startdatum: datetime,
    tijd_in_stap: number
  }
]

## Mapping naar UI

- naam → titel TaskCard
- status → status label + progress
- aantal_objecten → metadata
- aantal_fouten → visueel signaal (rood)
- tijd_in_stap → prioriteit + label

## Sortering

- API retourneert taken al gesorteerd op prioriteit
- frontend toont lijst zoals ontvangen

## Filters (query params)

- periode
- status
- zoekterm