# Stekker API implementatiechecklist

Deze checklist beschrijft wanneer een Stekker-implementatie voldoende aansluit op het Stekker API-contract om door de Vernietigingscockpit gebruikt te kunnen worden.

De checklist is aanvullend op:

- `stekker-openapi-spec.yaml`
- `stekker-openapi-contract.md`
- `api-informatiemodel.md`

## 1. Minimale endpoints

Een implementatie ondersteunt minimaal:

| Endpoint | Doel |
|--------|--------|
| `POST /selecties` | Starten van een nieuwe selectie |
| `GET /selecties/{selectieId}` | Opvragen van selectie-status en selectie-metadata |
| `GET /selecties/{selectieId}/objecten` | Pagineren door vernietigingskandidaten |
| `POST /vernietigingen` | Starten van een vernietigingsuitvoering |
| `GET /vernietigingen/{vernietigingId}` | Opvragen van vernietigingsstatus |
| `POST /vernietigingen/{vernietigingId}/batches` | Aanbieden van een technische batch |
| `POST /vernietigingen/{vernietigingId}/vrijgeven` | Vrijgeven van alle aangeleverde batches voor technische vernietiging |
| `GET /vernietigingen/{vernietigingId}/batches` | Opvragen van batchresultaten |
| `GET /vernietigingen/{vernietigingId}/batches/{batchNummer}` | Opvragen van een specifiek batchresultaat |

## 2. Verplichte identificaties

De implementatie gebruikt stabiele identificaties voor:

| Identificatie | Vereist bij |
|--------|--------|
| `selectieId` | Selectie, kandidatenpagina, vernietiging |
| `vernietigingskandidaatId` | Vernietigingskandidaat, batchobject, uitvoeringsresultaat |
| `bronId` | Vernietigingskandidaat, batchobject en uitvoeringsresultaat |
| `bronIdNaam` | Vernietigingskandidaat, voor herkenbaarheid in de Cockpit |
| `vernietigingId` | Vernietigingsuitvoering en batchresources |
| `batchNummer` | Batchaanlevering en batchresultaat |
| `cockpitTaakId` | Start van vernietigingsuitvoering |
| `besluitReferentie` | Start van vernietigingsuitvoering |

## 3. Selectie

Een correcte selectie voldoet aan:

- de selectie krijgt een stabiele `selectieId`;
- de selectie krijgt status `RUNNING`, `READY` of `FAILED`;
- bij `READY` is de selectie bevroren;
- elke pagina van `/selecties/{selectieId}/objecten` komt uit dezelfde bevroren selectie;
- elke vernietigingskandidaat heeft minimaal `vernietigingskandidaatId`, `bronId` en `omschrijving`;
- selectie-metadata bevat waar beschikbaar peildatum, selectietijdstip, stekkerversie, configuratieversie, apiVersie, aantallen, waarschuwingen en fouten.

## 4. Vernietiging

Een correcte vernietigingsuitvoering voldoet aan:

- `POST /vernietigingen` accepteert minimaal `selectieId`, `cockpitTaakId` en `besluitReferentie`;
- de stekker retourneert een stabiele `vernietigingId`;
- de uitvoering verwijst naar exact een selectie;
- de stekker vernietigt alleen informatieobjecten die expliciet in batches zijn aangeboden;
- elk batchobject bevat minimaal `vernietigingskandidaatId` en `bronId`;
- aangeboden batchobjecten moeten herleidbaar zijn tot vrijgegeven kandidaten uit de onderliggende selectie;
- de stekker voegt niet zelfstandig extra informatieobjecten toe aan een vernietiging;
- de stekker start technische vernietiging pas na `POST /vernietigingen/{vernietigingId}/vrijgeven`;
- bij vrijgave controleert de stekker minimaal `aantalBatches` en `aantalKandidaten`.

## 5. Idempotentie en retries

De implementatie voldoet aan:

- `POST /vernietigingen/{vernietigingId}/batches` is idempotent op `vernietigingId + batchNummer`;
- herhaalde aanlevering van dezelfde batch met identieke payload leidt niet tot dubbele technische vernietiging;
- herhaalde aanlevering van dezelfde batch met afwijkende payload levert `409 Conflict` op;
- gedeeltelijk verwerkte batches kunnen veilig worden hervat of leveren herleidbare resultaten op;
- retries blijven zichtbaar in technische logging.

## 6. Resultaten

Een uitvoeringsresultaat voldoet aan:

- per aangeboden combinatie van `vernietigingskandidaatId` en `bronId` komt precies een eindresultaat beschikbaar;
- elk resultaat bevat minimaal `vernietigingskandidaatId`, `bronId` en `resultaat`;
- toegestane resultaatwaarden zijn `SUCCESS`, `FAILED`, `SKIPPED`, `NOT_FOUND` en `CHANGED`;
- `NOT_FOUND` en `CHANGED` zijn objectresultaten, geen HTTP-fouten;
- foutresultaten bevatten waar mogelijk `foutcode`, `foutmelding`, `bronstatus`, `logReference` of `correlatieId`.

## 7. Foutafhandeling

De implementatie gebruikt HTTP-fouten voor request- en resourceniveau:

| Status | Verwachting |
|--------|--------|
| `400` | Ongeldige of onvolledige request |
| `401` | Authenticatie ontbreekt of is ongeldig |
| `403` | Client is niet geautoriseerd |
| `404` | Selectie, vernietiging of batch bestaat niet |
| `409` | Ongeldige state transition of idempotentieconflict |
| `500` | Onverwachte technische fout |

Elke foutresponse gebruikt het standaard foutmodel met minimaal `code` en `message`.

## 8. Security

De implementatie voldoet minimaal aan:

- HTTPS;
- OAuth2 client credentials of een overeengekomen gelijkwaardig mechanisme;
- scopes voor selectie lezen/schrijven en vernietiging lezen/schrijven;
- autorisatiefouten worden gelogd;
- tokens, credentials en secrets worden niet gelogd.

## 9. Observability

De implementatie legt minimaal vast:

- `selectieId`;
- `vernietigingId`;
- `batchNummer`;
- `vernietigingskandidaatId`;
- `bronId`;
- resultaat of foutcode;
- `correlatieId` of `logReference`;
- tijdstip van request of verwerking.

## 10. Acceptatiescenario's

Een Stekker is acceptabel voor integratie wanneer minimaal de volgende scenario's slagen:

1. Selectie starten en status ophalen tot `READY`.
2. Vernietigingskandidaten gepagineerd ophalen en dezelfde selectie stabiel terugkrijgen.
3. Vernietiging starten met `selectieId`, `cockpitTaakId` en `besluitReferentie`.
4. Batch met vrijgegeven kandidaten aanbieden en resultaten ophalen.
5. Vernietiging vrijgeven met `aantalBatches` en `aantalKandidaten`, waarna status `RUNNING` wordt.
6. Vrijgave met ontbrekende of afwijkende batches afwijzen met `409 Conflict`.
7. Dezelfde batch opnieuw aanbieden met identieke payload zonder dubbele uitvoering.
8. Dezelfde batch opnieuw aanbieden met afwijkende payload en `409 Conflict` ontvangen.
9. Een niet-bestaande selectie, vernietiging of batch opvragen en `404` ontvangen.
10. Een object dat niet meer in de bron bestaat terugkrijgen als objectresultaat `NOT_FOUND`.
11. Een object dat sinds selectie gewijzigd is terugkrijgen als objectresultaat `CHANGED`.
12. Autorisatie met ontbrekende of onjuiste scope afwijzen met `401` of `403`.
