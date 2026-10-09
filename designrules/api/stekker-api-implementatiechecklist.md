# Stekker API implementatiechecklist (v2)

Deze checklist beschrijft wanneer een Stekker-implementatie voldoende aansluit op het Stekker API-contract (v2.0.0) om door de Vernietigingscockpit gebruikt te kunnen worden.

De checklist is aanvullend op:

- `stekker-openapi-spec.yaml` (bron van waarheid voor de verplichte velden)
- `stekker-openapi-contract.md`
- `api-informatiemodel.md`
- `designrules/begrippenlijsten/`

## 1. Minimale endpoints

Alle paden onder `/v2`; `API-Version` in elke response.

| Endpoint | Doel |
|--------|--------|
| `POST /selecties` | Starten van een nieuwe selectie |
| `GET /selecties/{selectieId}` | Opvragen van selectiestatus en -metagegevens |
| `GET /selecties/{selectieId}/vernietigingskandidaten` | Pagineren door vernietigingskandidaten |
| `POST /vernietigingen` | Starten van een vernietigingsuitvoering |
| `GET /vernietigingen/{vernietigingId}` | Opvragen van vernietigingsstatus |
| `POST /vernietigingen/{vernietigingId}/batches` | Aanbieden van een technische batch |
| `POST /vernietigingen/{vernietigingId}/vrijgeven` | Vrijgeven van alle aangeleverde batches voor technische vernietiging |
| `GET /vernietigingen/{vernietigingId}/batches` | Opvragen van batchresultaten |
| `GET /vernietigingen/{vernietigingId}/batches/{batchNummer}` | Opvragen van één batchresultaat |
| `GET /vernietigingen/{vernietigingId}/specificaties/{vernietigingskandidaatId}` | MDTO-XML-specificatie van een vernietigde kandidaat |

## 2. Identificaties

| Identificatie | Vereist bij |
|--------|--------|
| `selectieId` | Selectie, kandidatenpagina, vernietiging |
| `vernietigingskandidaatId` | Vernietigingskandidaat, batch, uitvoeringsresultaat, specificatie |
| `identificatie` (MDTO: `identificatieKenmerk` + `identificatieBron`) | Kandidaat, batch en resultaat. Minimaal de technische sleutel; bij voorkeur ook het voor mensen herkenbare kenmerk |
| `vernietigingId` | Vernietigingsuitvoering en batchresources |
| `batchNummer` | Batchaanlevering en batchresultaat |
| `cockpitTaakId`, `besluitReferentie` | Start van vernietigingsuitvoering |

## 3. Selectie en MDTO-metagegevens

- de selectie krijgt een stabiele `selectieId` en status `RUNNING`, `READY` of `FAILED`;
- bij `READY` is de selectie bevroren, en elke pagina komt uit dezelfde bevroren selectie;
- elke kandidaat is precies één MDTO-informatieobject met `aggregatieniveau` Archief, Serie, Dossier of Archiefstuk; geen kunstmatige groeperingen;
- elke kandidaat heeft de in de spec verplichte velden: `vernietigingskandidaatId`, `identificatie`, `naam`, `aggregatieniveau`, `waardering`, `bewaartermijn` (met `termijnEinddatum`) en `informatiecategorie`;
- alleen kandidaten met waardering V (`Tijdelijk te bewaren`) en `termijnEinddatum` ≤ peildatum; twijfelgevallen tellen in `aantalWaarschuwingen`;
- de bewaartermijn levert trigger (Cockpit-termijntriggers), startdatum en looptijd (ISO 8601-duur) zodra bekend, en einddatum = startdatum + looptijd;
- `informatiecategorie` verwijst naar de vastgestelde selectielijst, met identificatie en versie;
- elke begripwaarde verwijst via `begripBegrippenlijst` naar de lijst waaruit ze komt;
- de selectie bevat waar beschikbaar peildatum, selectietijdstip, stekkerversie, configuratieversie, apiVersie, aantallen, waarschuwingen en fouten.

## 4. Vernietiging

- `POST /vernietigingen` accepteert `selectieId`, `cockpitTaakId`, `besluitReferentie` en `vernietigingsdossierId`, en retourneert een stabiele `vernietigingId`;
- de uitvoering verwijst naar precies één selectie;
- de stekker vernietigt alleen kandidaten die expliciet in batches zijn aangeboden, en voegt niets zelfstandig toe;
- elke batch bevat `vernietigingskandidaten` met `vernietigingskandidaatId` en `identificatie`; een afwijkende identificatie leidt tot `400`;
- de stekker start technische vernietiging pas na `POST …/vrijgeven` en controleert daarbij `aantalBatches` en `aantalKandidaten`;
- vanaf `RUNNING` meldt de uitvoering `vernietigingsmethode` (Cockpit-vernietigingsmethoden) en `vernietigingsmethodeToelichting`, met de behandeling van back-ups, replica's en indexen;
- vernietiging voldoet aan de MDTO-definitie: blijvend ontoegankelijk, inclusief onderdelen en bestanden. Een soft delete of prullenbak telt niet.

## 5. Idempotentie en retries

- elke `POST` vereist `Idempotency-Key`; zonder sleutel volgt `400 IDEMPOTENCY_KEY_MISSING`;
- zelfde sleutel en zelfde inhoud: niets opnieuw uitgevoerd, zelfde antwoord (ook voor `POST /selecties`);
- zelfde sleutel met andere inhoud: `409 IDEMPOTENCY_KEY_REUSED`;
- sleutels blijven minimaal 7 dagen geldig, ook na een herstart;
- `POST …/batches` is daarnaast idempotent op `vernietigingId + batchNummer`; hetzelfde batchnummer met een afwijkende inhoud levert `409`;
- gedeeltelijk verwerkte batches worden veilig hervat, en het event *Vernietigen* behoudt dan het oorspronkelijke tijdstip;
- retries blijven zichtbaar in technische logging.

## 6. Resultaten en specificatie

- per aangeboden kandidaat precies één eindresultaat, met `vernietigingskandidaatId`, `identificatie` en `resultaat`;
- toegestane resultaatwaarden: `SUCCESS`, `FAILED`, `SKIPPED`, `NOT_FOUND`, `CHANGED`; `NOT_FOUND` en `CHANGED` zijn resultaten, geen HTTP-fouten;
- bij `SUCCESS` een `event` met `eventType` *Vernietigen* en `eventTijd`;
- bij een ander resultaat waar mogelijk `foutcode`, `foutmelding`, `bronstatus`, `logReference` of `correlatieId`;
- voor elke kandidaat met `SUCCESS` een specificatie in MDTO-XML die valideert tegen de MDTO-XSD 1.0.1, met `bevatOnderdeel` per direct onderliggend informatieobject bij Archief, Serie en Dossier; anders `409`.

## 7. Foutafhandeling

| Status | Verwachting |
|--------|--------|
| `400` | Ongeldige of onvolledige request, of een ontbrekende `Idempotency-Key` |
| `401` | Authenticatie ontbreekt of is ongeldig |
| `403` | Client is niet geautoriseerd |
| `404` | Selectie, vernietiging, batch of kandidaat bestaat niet |
| `409` | Ongeldige statusovergang, idempotentieconflict, selectie niet gereed of specificatie niet beschikbaar |
| `500` | Onverwachte technische fout |

Elke foutresponse gebruikt het standaard foutmodel met minimaal `code` en `message`, en de vaste foutcodes uit het contract (§8.0).

## 8. Security

- HTTPS;
- OAuth2 client credentials of een overeengekomen gelijkwaardig mechanisme;
- scopes `selectie.read`, `selectie.write`, `vernietiging.read` en `vernietiging.write`;
- autorisatiefouten worden gelogd;
- tokens, credentials en secrets worden niet gelogd.

## 9. Observability

De implementatie legt minimaal vast: `selectieId`, `vernietigingId`, `batchNummer`, `vernietigingskandidaatId`, de technische sleutel uit de `identificatie`, het resultaat of de foutcode, `correlatieId` of `logReference`, en het tijdstip van request of verwerking.

## 10. Acceptatiescenario's

Een Stekker is acceptabel voor integratie wanneer minimaal de volgende scenario's slagen:

1. Selectie starten en status ophalen tot `READY`.
2. Dezelfde selectiestart herhalen met dezelfde `Idempotency-Key` levert dezelfde `selectieId`; met andere inhoud volgt `409 IDEMPOTENCY_KEY_REUSED`.
3. Een `POST` zonder `Idempotency-Key` wordt afgewezen met `400 IDEMPOTENCY_KEY_MISSING`.
4. Vernietigingskandidaten gepagineerd ophalen en dezelfde selectie stabiel terugkrijgen; elke kandidaat voldoet aan het MDTO-profiel (verplichte velden, aggregatieniveau, waardering V, einddatum = startdatum + looptijd).
5. Vernietiging starten met `selectieId`, `cockpitTaakId` en `besluitReferentie`.
6. Een batch met vrijgegeven kandidaten aanbieden; een kandidaat met een afwijkende `identificatie` wordt afgewezen met `400`.
7. Vernietiging vrijgeven met `aantalBatches` en `aantalKandidaten`, waarna status `RUNNING` wordt, met vernietigingsmethode en toelichting.
8. Vrijgave met ontbrekende of afwijkende batches afwijzen met `409 Conflict`.
9. Dezelfde batch opnieuw aanbieden met identieke inhoud, zonder dubbele uitvoering.
10. Dezelfde batch opnieuw aanbieden met afwijkende inhoud en `409 Conflict` ontvangen.
11. Een niet-bestaande selectie, vernietiging of batch opvragen en `404` ontvangen.
12. Een object dat niet meer in de bron bestaat, terugkrijgen als `NOT_FOUND`.
13. Een object dat sinds selectie gewijzigd is, terugkrijgen als `CHANGED`.
14. Bij `SUCCESS` het event *Vernietigen* met tijdstip ontvangen, en een specificatie ophalen die valideert tegen de MDTO-XSD 1.0.1.
15. Een specificatie opvragen voor een kandidaat zonder `SUCCESS` en `409` ontvangen.
16. Autorisatie met een ontbrekende of onjuiste scope afwijzen met `401` of `403`.

De teststekker (`Vernietigingscockpit-stekker-test`) dekt deze scenario's in zijn contract- en sequencetests en kan als referentie dienen.
