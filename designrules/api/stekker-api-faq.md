# Stekker API FAQ (v2)

Deze FAQ beschrijft de hoofdflow tussen Vernietigingscockpit en Stekker in termen van endpoints. Alle paden zijn relatief aan `https://<stekker>/v2`. Elke `POST` heeft een verplichte header `Idempotency-Key` (ADR-0004). Velden over informatieobjecten volgen MDTO (ADR-0005).

## Hoe start de Cockpit een selectie bij de Stekker?

```http
POST /selecties
Idempotency-Key: selectie-3f6c1e0a-5d2b-4c1e-9a77-0c0b1a2d3e4f
```

Optionele body:

```json
{
  "peildatum": "2026-09-25"
}
```

De Stekker retourneert een `selectieId` en een selectiestatus. Herhaalt de Cockpit het verzoek met dezelfde sleutel, bijvoorbeeld na een time-out, dan krijgt hij dezelfde selectie terug en start er geen tweede.

## Hoe weet de Cockpit dat de selectie klaar is?

```http
GET /selecties/{selectieId}
```

De Cockpit pollt dit endpoint totdat de selectie status `READY` heeft. `READY` betekent dat de selectie klaar en bevroren is: de set vernietigingskandidaten wijzigt daarna niet meer.

## Hoe levert de Stekker, gepagineerd, de geselecteerde vernietigingskandidaten aan bij de Cockpit?

```http
GET /selecties/{selectieId}/vernietigingskandidaten?limit=100&offset=0
```

Of met cursor:

```http
GET /selecties/{selectieId}/vernietigingskandidaten?limit=100&cursor=abc123
```

Elke kandidaat is één MDTO-informatieobject (Archief, Serie, Dossier of Archiefstuk). Een ingekort voorbeeld:

```json
{
  "vernietigingskandidaatId": "vk-001",
  "identificatie": [
    { "identificatieKenmerk": "8f7410a8", "identificatieBron": "Zaaksysteem sociaal domein (technische sleutel)" },
    { "identificatieKenmerk": "ZAAK-2020-00421", "identificatieBron": "Zaaknummering gemeente Voorbeeld" }
  ],
  "naam": "Handhaving bijstand ZAAK-2020-00421",
  "aggregatieniveau": { "begripLabel": "Dossier", "begripBegrippenlijst": { "verwijzingNaam": "Begrippenlijst Aggregatieniveaus MDTO" } },
  "waardering": { "begripLabel": "Tijdelijk te bewaren", "begripCode": "V", "begripBegrippenlijst": { "verwijzingNaam": "Begrippenlijst Waarderingen MDTO" } },
  "bewaartermijn": {
    "termijnTriggerStartLooptijd": { "begripLabel": "Afgehandeld", "begripCode": "afgehandeld", "begripBegrippenlijst": { "verwijzingNaam": "Cockpit-termijntriggers" } },
    "termijnStartdatumLooptijd": "2020-12-14",
    "termijnLooptijd": "P5Y",
    "termijnEinddatum": "2025-12-14"
  },
  "informatiecategorie": {
    "begripLabel": "Handhaving",
    "begripCode": "11.1.2",
    "begripBegrippenlijst": { "verwijzingNaam": "Selectielijst gemeenten en intergemeentelijke organen 2020" }
  }
}
```

Welke velden verplicht zijn, staat in de OpenAPI-specificatie.

## Hoe weet de Cockpit dat alles is aangeleverd?

Bij cursor-paginering is alles aangeleverd wanneer `nextCursor` ontbreekt. Bij offset-paginering is alles aangeleverd wanneer:

```text
offset + aantal ontvangen items >= totaal
```

Paginering verandert de inhoud van de selectie niet.

## Wat doet de Cockpit met een kandidaat met waardering B of N?

Een Stekker hoort die niet te leveren. Gebeurt het toch, dan sluit de Cockpit de kandidaat automatisch uit met reden *Waardering niet V* en toont hij een waarschuwing (ADR-0005, B-M1).

## Hoe kan de Cockpit een vernietigingsopdracht starten?

```http
POST /vernietigingen
Idempotency-Key: vernietiging-7c1d…
```

Body:

```json
{
  "selectieId": "sel-2026-001",
  "cockpitTaakId": "taak-2026-042",
  "vernietigingsdossierId": "dossier-2026-042",
  "besluitReferentie": "besluit-archivaris-2026-042"
}
```

De Stekker maakt een `vernietigingId` aan en zet de vernietiging op `IDLE`. De vernietiging bestaat dan, maar technische vernietiging mag nog niet starten. De Cockpit kan nu batches aanleveren.

## Hoe levert de Cockpit de vrijgegeven vernietigingskandidaten aan bij de Stekker?

In technische batches. De Cockpit bepaalt zelf de indeling. Per kandidaat stuurt hij de `identificatie` **letterlijk** terug zoals geselecteerd.

```http
POST /vernietigingen/{vernietigingId}/batches
Idempotency-Key: vernietiging-7c1d…-batch-1
```

```json
{
  "batchNummer": 1,
  "vernietigingskandidaten": [
    {
      "vernietigingskandidaatId": "vk-001",
      "identificatie": [
        { "identificatieKenmerk": "8f7410a8", "identificatieBron": "Zaaksysteem sociaal domein (technische sleutel)" },
        { "identificatieKenmerk": "ZAAK-2020-00421", "identificatieBron": "Zaaknummering gemeente Voorbeeld" }
      ]
    }
  ]
}
```

Een batch aanbieden is nog geen startsein voor vernietiging.

## Hoe weet de Stekker dat alle batches binnen zijn en dat hij mag beginnen met vernietigen?

De Cockpit geeft de vernietiging expliciet vrij:

```http
POST /vernietigingen/{vernietigingId}/vrijgeven
Idempotency-Key: vernietiging-7c1d…-vrijgeven
```

```json
{
  "aantalBatches": 12,
  "aantalKandidaten": 482
}
```

De Stekker controleert of de aantallen ontvangen batches en kandidaten kloppen. Zo ja, dan zet hij de vernietiging op `RUNNING`, legt hij de vernietigingsmethode vast en mag de technische vernietiging starten. Ontbreken er batches of kloppen de aantallen niet, dan volgt `409 Conflict`.

## Hoe weet de Cockpit de vernietigingsstatus per vernietigingskandidaat?

```http
GET /vernietigingen/{vernietigingId}/batches/{batchNummer}
GET /vernietigingen/{vernietigingId}/batches
```

```json
{
  "batchNummer": 1,
  "resultaten": [
    {
      "vernietigingskandidaatId": "vk-001",
      "identificatie": [ { "identificatieKenmerk": "8f7410a8", "identificatieBron": "Zaaksysteem sociaal domein (technische sleutel)" } ],
      "resultaat": "SUCCESS",
      "event": {
        "eventType": { "begripLabel": "Vernietigen", "begripBegrippenlijst": { "verwijzingNaam": "Begrippenlijst Eventtypen MDTO" } },
        "eventTijd": "2026-10-08T14:03:12Z",
        "eventResultaat": "Vernietigd; methode: Verwijderd via bronfunctie."
      }
    },
    {
      "vernietigingskandidaatId": "vk-002",
      "identificatie": [ { "identificatieKenmerk": "9ab321ef", "identificatieBron": "Zaaksysteem sociaal domein (technische sleutel)" } ],
      "resultaat": "CHANGED",
      "foutcode": "CHANGED",
      "foutmelding": "Zaak is na selectie heropend."
    }
  ]
}
```

## Waar haalt de Cockpit de specificatie van een vernietigde kandidaat?

```http
GET /vernietigingen/{vernietigingId}/specificaties/{vernietigingskandidaatId}
```

De Stekker levert een MDTO-XML-document (`application/xml`) met het vernietigde informatieobject, het event *Vernietigen* en, bij een archief, serie of dossier, een `bevatOnderdeel` per onderliggend informatieobject. Alleen voor kandidaten met `SUCCESS`; anders `409`.

## Hoe weet de Cockpit wanneer de vernietiging begint en klaar is?

```http
GET /vernietigingen/{vernietigingId}
```

De vernietiging is begonnen bij status `RUNNING`, na een succesvolle vrijgave. Ze is klaar bij een eindstatus:

| Status | Betekenis |
|--------|--------|
| `COMPLETED` | Alle aangeboden kandidaten zijn vernietigd. |
| `PARTIAL` | De uitvoering is afgerond, maar minstens één kandidaat heeft een ander resultaat dan `SUCCESS`. |
| `FAILED` | De vernietiging als geheel is mislukt of kan niet betrouwbaar worden voortgezet. |

Details per kandidaat blijven beschikbaar via de batchresultaat-endpoints.
