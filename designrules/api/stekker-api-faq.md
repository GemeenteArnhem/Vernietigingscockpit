# Stekker API FAQ

Deze FAQ beschrijft de hoofdflow tussen Vernietigingscockpit en Stekker in termen van endpoints.

## Hoe start de Cockpit een selectie bij de Stekker?

```http
POST /selecties
```

Optionele body:

```json
{
  "peildatum": "2026-09-25"
}
```

De Stekker retourneert een `selectieId` en een selectie-status.

## Hoe weet de Cockpit dat de selectie klaar is?

```http
GET /selecties/{selectieId}
```

De Cockpit pollt dit endpoint totdat de selectie status `READY` heeft.

`READY` betekent dat de selectie klaar en bevroren is. De set vernietigingskandidaten mag daarna niet meer wijzigen.

## Hoe levert de Stekker, gepagineerd, de geselecteerde vernietigingskandidaten aan bij de Cockpit?

```http
GET /selecties/{selectieId}/objecten?limit=100&offset=0
```

Of met cursor:

```http
GET /selecties/{selectieId}/objecten?limit=100&cursor=abc123
```

Elke kandidaat bevat minimaal:

- `vernietigingskandidaatId`
- `bronId`
- `bronIdNaam`
- `omschrijving`

## Hoe weet de Cockpit dat alles is aangeleverd?

Bij cursor-paginering is alles aangeleverd wanneer `nextCursor` ontbreekt of leeg is.

Bij offset-paginering is alles aangeleverd wanneer:

```text
offset + aantal ontvangen items >= totaal
```

De selectie zelf blijft stabiel: paginering verandert de inhoud van de selectie niet.

## Hoe kan de Cockpit een vernietigingsopdracht starten?

```http
POST /vernietigingen
```

Body:

```json
{
  "selectieId": "sel-2026-001",
  "cockpitTaakId": "taak-2026-042",
  "vernietigingsdossierId": "dossier-2026-042-v1",
  "besluitReferentie": "besluit-archivaris-2026-042"
}
```

De Stekker maakt een `vernietigingId` aan en zet de vernietiging op `IDLE`.

`IDLE` betekent: de vernietiging bestaat, maar technische vernietiging mag nog niet starten. De Cockpit kan nu batches aanleveren.

## Hoe levert de Cockpit, gepagineerd, de beoordeelde vernietigingskandidaten aan bij de Stekker?

De Cockpit levert geen pagina's aan, maar technische vernietigingsbatches. De Cockpit bepaalt zelf de batchindeling.

```http
POST /vernietigingen/{vernietigingId}/batches
```

Body:

```json
{
  "batchNummer": 1,
  "objecten": [
    {
      "vernietigingskandidaatId": "vk-001",
      "bronId": "8f7410a8"
    },
    {
      "vernietigingskandidaatId": "vk-002",
      "bronId": "9ab321ef"
    }
  ]
}
```

Een batch aanbieden is nog geen startsein voor vernietiging.

## Hoe weet de Stekker dat alle batches binnen zijn en dat hij mag beginnen met vernietigen?

De Cockpit geeft de vernietiging expliciet vrij:

```http
POST /vernietigingen/{vernietigingId}/vrijgeven
```

Body:

```json
{
  "aantalBatches": 12,
  "aantalKandidaten": 482
}
```

De Stekker controleert of het aantal ontvangen batches en kandidaten klopt. Als dat klopt, zet de Stekker de vernietiging op `RUNNING` en mag technische vernietiging starten.

Als batches ontbreken of de aantallen niet kloppen, retourneert de Stekker `409 Conflict`.

## Hoe weet de Cockpit de vernietigingsstatus per vernietigingskandidaat?

Per specifieke batch:

```http
GET /vernietigingen/{vernietigingId}/batches/{batchNummer}
```

Of voor alle batchresultaten:

```http
GET /vernietigingen/{vernietigingId}/batches
```

Resultaat:

```json
{
  "batchNummer": 1,
  "resultaten": [
    {
      "vernietigingskandidaatId": "vk-001",
      "bronId": "8f7410a8",
      "resultaat": "SUCCESS"
    },
    {
      "vernietigingskandidaatId": "vk-002",
      "bronId": "9ab321ef",
      "resultaat": "CHANGED"
    }
  ]
}
```

## Hoe weet de Cockpit wanneer de vernietiging begint?

```http
GET /vernietigingen/{vernietigingId}
```

De vernietiging is begonnen wanneer de status `RUNNING` is.

De overgang naar `RUNNING` vindt plaats na een succesvolle:

```http
POST /vernietigingen/{vernietigingId}/vrijgeven
```

## Hoe weet de Cockpit wanneer de vernietiging klaar is?

```http
GET /vernietigingen/{vernietigingId}
```

De vernietiging is klaar wanneer de status een eindstatus is:

| Status | Betekenis |
|--------|--------|
| `COMPLETED` | Alle aangeboden kandidaten zijn succesvol vernietigd. |
| `PARTIAL` | De uitvoering is afgerond, maar minstens een kandidaat heeft een afwijkend resultaat. |
| `FAILED` | De vernietiging als geheel is mislukt of kan niet betrouwbaar worden voortgezet. |

Details per kandidaat blijven beschikbaar via de batchresultaat-endpoints.
