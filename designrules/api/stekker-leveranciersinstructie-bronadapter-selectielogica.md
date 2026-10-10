# Leveranciersinstructie bronadapter en selectielogica (Stekker API v2)

Dit document beschrijft welke informatie een leverancier moet aanleveren en implementeren om een Stekker te ontwikkelen voor de eigen applicatie of applicatiefamilie.

De Stekker moet voldoen aan:

- `stekker-openapi-spec.yaml` (v2.0.0)
- `stekker-openapi-contract.md`
- `api-informatiemodel.md`
- `stekker-api-implementatiechecklist.md`
- de begrippenlijsten in `designrules/begrippenlijsten/`

Dit document vult die afspraken aan voor de bronadapter, de selectielogica en de **mapping naar MDTO**. De architectuur schrijft niet voor hoe de leverancier dit intern bouwt, maar wel welk gedrag aantoonbaar geleverd moet worden.

## 1. Doel van de Stekker

De Stekker vormt de technische koppeling tussen de Vernietigingscockpit en de applicatie van de leverancier. De Stekker:

- bepaalt vernietigingskandidaten op basis van brondata, de toepasselijke selectielijst en configuratie;
- levert deze kandidaten, met hun MDTO-metagegevens, via de Stekker API aan de Cockpit;
- voert na vrijgave door de Cockpit de vernietiging technisch uit;
- rapporteert per aangeboden kandidaat het resultaat, en levert bij vernietiging het MDTO-event *Vernietigen* en een MDTO-specificatie.

De Stekker neemt geen normatieve besluiten. De Cockpit beoordeelt, sluit uit, accordeert en verantwoordt.

## 2. Verantwoordelijkheden van de leverancier

De leverancier is verantwoordelijk voor:

- de bronadapter naar de eigen applicatie of gegevensbron;
- de interpretatie van brondata en de **mapping naar het MDTO-profiel** (§5);
- de toepassing van de selectielijst binnen de afgesproken configuratie;
- het bepalen van `vernietigingskandidaatId` en de `identificatie` van elke kandidaat;
- het technisch vernietigen of laten vernietigen van informatieobjecten in de bron, volgens de MDTO-definitie;
- het detecteren van afwijkingen tussen selectie en vernietiging;
- het rapporteren van resultaten en specificaties volgens de Stekker API;
- logging, foutafhandeling, idempotentie en herstartbaarheid binnen de Stekker.

De leverancier mag geen Cockpit-specifieke workflowlogica of normatieve besluitvorming in de Stekker opnemen.

## 3. Bronadapter

De leverancier beschrijft en implementeert hoe de Stekker de bron benadert.

| Onderwerp | Toelichting |
|--------|--------|
| Bronnaam | Naam van de applicatie, module of gegevensbron die de Stekker ontsluit. Wordt gebruikt als `identificatieBron`. |
| Bronbereik | Welke objecttypen, zaken, dossiers, documenten of records binnen scope vallen, en op welk MDTO-aggregatieniveau (Archief, Serie, Dossier, Archiefstuk). |
| Technische toegang | API, database, exportbestand, message queue of andere toegangsvorm. |
| Authenticatie | Hoe de Stekker zich bij de bron authenticeert. |
| Autorisatie | Welke rechten nodig zijn voor lezen, selecteren en vernietigen. |
| Rate limits | Beperkingen in snelheid, volumes of piekbelasting. |
| Beschikbaarheid | Verwachte beschikbaarheid en onderhoudsvensters van de bron. |
| Foutgedrag | Hoe de bron fouten, time-outs en partial failures teruggeeft. |
| Transactiegedrag | Of vernietiging atomair, per object of per batch plaatsvindt. |
| Herstelgedrag | Hoe de Stekker veilig hervat na onderbreking of retry. |
| Vernietigingsmethode | Hoe de bron vernietigt (label uit Cockpit-vernietigingsmethoden) en wat er gebeurt met bestanden, back-ups, replica's, zoekindexen en logbestanden, met de termijn waarbinnen restanten zijn uitgedoofd. |

## 4. Identificaties

| Veld | Betekenis | Eis |
|--------|--------|--------|
| `vernietigingskandidaatId` | Stabiele identificatie van de kandidaat over selectie, beoordeling, vernietiging en resultaatverwerking. | Stabiel binnen het hele proces. |
| `identificatie` | MDTO-identificaties: paren `identificatieKenmerk` + `identificatieBron`. | Minimaal de **technische sleutel** waarmee de Stekker het object in de bron terugvindt en vernietigt. Bij voorkeur ook het voor mensen herkenbare kenmerk (zaaknummer, dossiernummer). |

Voorbeeld:

```json
{
  "vernietigingskandidaatId": "vk-2026-000123",
  "identificatie": [
    { "identificatieKenmerk": "8f7410a8-3b8a-42a8-8c10-7424f589e501", "identificatieBron": "Zaaksysteem sociaal domein (technische sleutel)" },
    { "identificatieKenmerk": "ZAAK-2020-00421", "identificatieBron": "Zaaknummering gemeente Voorbeeld" }
  ]
}
```

Is dezelfde waarde zowel technisch uitvoerbaar als herkenbaar, dan volstaat één identificatie. Bedient de Stekker meerdere bronnen, dan maakt de `identificatieBron` het onderscheid. De Cockpit stuurt de `identificatie` letterlijk terug bij vernietiging; de Stekker moet daaruit de technische sleutel herkennen.

## 5. Selectielogica en mapping naar MDTO

De leverancier beschrijft hoe vernietigingskandidaten worden bepaald en hoe brongegevens naar het MDTO-profiel worden gemapt.

| MDTO-veld | Wat de leverancier beschrijft en implementeert |
|--------|--------|
| `aggregatieniveau` | Welk bronobject welk aggregatieniveau is. Een kandidaat is altijd precies één archief, serie, dossier of archiefstuk; kunstmatige groeperingen zijn niet toegestaan. |
| `naam` / `omschrijving` | Welk bronveld de naam (titel) levert en welk de inhoudsbeschrijving. |
| `classificatie` | Classificatieschema(s) (ZTC, BAC, ordeningsplan) en hoe code en label worden bepaald. |
| `dekkingInTijd` | Welke bronvelden begin- en einddatum leveren, met type uit Cockpit-dekkingInTijdtypen. |
| `informatiecategorie` | De toegepaste vastgestelde selectielijst (naam, identificatie, versie) en hoe de categorie (code en titel) wordt bepaald. Bij ZGW-bronnen: de selectielijstklasse van het resultaattype. |
| `waardering` | Hoe de waardering (B/V/N) volgt uit de selectielijst. Alleen V wordt als kandidaat geleverd. |
| `bewaartermijn` | De trigger (Cockpit-termijntriggers; bij ZGW de afleidingswijze), de startdatum (bij ZGW de brondatum), de looptijd en de berekening van de einddatum. |
| `informatiecategorieAfwijking` | Wanneer en hoe een hotspot, specifieke wetgeving of afwijkende termijn wordt toegepast. |
| `isOnderdeelVan` / `gerelateerdInformatieobject` | Relaties met andere informatieobjecten, met type uit de MDTO-relatietypen. |
| `activiteit` | Het proces of zaaktype. |
| `archiefvormer` | Alleen als die per object afwijkt van de taak in de Cockpit, bijvoorbeeld bij een gemeenschappelijke regeling. |
| Peildatum | Hoe de peildatum wordt toegepast: alleen kandidaten met `termijnEinddatum` ≤ peildatum. |
| Uitzonderingen | Welke bronstatussen of kenmerken selectie uitsluiten. |
| Onzekerheden | Hoe ontbrekende, inconsistente of onvolledige data wordt behandeld. |
| Configuratieversie | Hoe wordt vastgelegd welke configuratie is gebruikt. |

De Stekker mag geen kandidaten leveren waarvan niet betrouwbaar kan worden vastgesteld dat ze vernietigingskandidaat zijn: geen waardering N, geen ontbrekende einddatum, geen onbekend aggregatieniveau. Onzekerheden worden zichtbaar gemaakt via waarschuwingen, fouten of logging.

## 6. Selectieresultaat

Elke kandidaat bevat minimaal de velden die de OpenAPI-specificatie verplicht stelt:

- `vernietigingskandidaatId`
- `identificatie`
- `naam`
- `aggregatieniveau`
- `waardering`
- `bewaartermijn` (met `termijnEinddatum`; trigger, startdatum en looptijd zodra bekend)
- `informatiecategorie`

Aanvullende MDTO-gegevens worden geleverd wanneer beschikbaar, zoals classificatie, dekking in tijd, relaties, activiteit en de cockpituitbreidingen `aantalObjecten`, `aantalBetrokkenen` en `toelichting`. `aantalObjecten` telt alleen de **direct** onderliggende informatieobjecten, niet de dieper liggende niveaus; een archiefstuk heeft 0 (ADR-0007, DR-04).

De selectie is bevroren zodra de status `READY` is. Dezelfde selectie levert bij herhaald ophalen dezelfde kandidaten op.

## 7. Vernietiging

De Cockpit biedt na beoordeling en accordering alleen vrijgegeven kandidaten aan. Een batch bevat per kandidaat het `vernietigingskandidaatId` en de `identificatie`.

De Stekker controleert dat:

- de kandidaat hoort bij de onderliggende selectie;
- de `identificatie` letterlijk overeenkomt met die uit de selectie;
- het object nog bestaat;
- het object niet zodanig is gewijzigd dat vernietiging niet meer betrouwbaar is.

De Stekker voegt geen extra objecten toe en vernietigt alleen wat expliciet is aangeboden. Bij een archief, serie of dossier vernietigt de Stekker het informatieobject met al zijn onderdelen en bestanden.

Technische vernietiging start pas nadat de Cockpit de vernietiging vrijgeeft via `POST /vernietigingen/{vernietigingId}/vrijgeven`, met `aantalBatches` en `aantalKandidaten`. De Stekker controleert de aantallen; bij ontbrekende of afwijkende batches volgt `409 Conflict` en start de vernietiging niet. Bij een geslaagde vrijgave legt de Stekker `vernietigingsmethode` en `vernietigingsmethodeToelichting` vast.

Vernietiging betekent volgens MDTO: *het blijvend ontoegankelijk maken van informatie, waardoor deze niet meer vindbaar, beschikbaar, leesbaar, interpreteerbaar en betrouwbaar is*. Een soft delete, prullenbak of archiveringsvlag voldoet niet.

## 8. Resultaten, event en specificatie

De Stekker meldt per kandidaat precies één resultaat:

| Resultaat | Betekenis |
|--------|--------|
| `SUCCESS` | Het informatieobject is vernietigd. Het resultaat bevat het `event` *Vernietigen* met `eventTijd`. |
| `FAILED` | De vernietiging is geprobeerd maar mislukt. |
| `SKIPPED` | De vernietiging is niet uitgevoerd. |
| `NOT_FOUND` | Het object bestaat niet meer of kan niet worden gevonden. Dit is geen bewijs van vernietiging door deze uitvoering. |
| `CHANGED` | Het object is sinds selectie gewijzigd en is daarom niet vernietigd. |

`NOT_FOUND` en `CHANGED` zijn resultaten, geen HTTP-fouten.

Voor elke kandidaat met `SUCCESS` levert de Stekker via `GET /vernietigingen/{vernietigingId}/specificaties/{vernietigingskandidaatId}` een **MDTO-XML-document** dat valideert tegen de MDTO-XSD 1.0.1. Het bevat:

- het informatieobject, met `identificatie`, `naam`, `aggregatieniveau`, `waardering`, `bewaartermijn`, `informatiecategorie`, `archiefvormer` en `beperkingGebruik`;
- het event *Vernietigen*;
- bij Archief, Serie en Dossier: een `bevatOnderdeel` (naam en identificatie) per direct onderliggend informatieobject.

Kan de bron het, dan legt de Stekker het event *Vernietigen* ook in de bron vast, bijvoorbeeld als metadata-grafsteen of archiefstatus, en geeft hij een `bronEventReferentie` terug. Dat is optioneel.

## 9. Idempotentie en herstartbaarheid

- elke `POST` vereist een `Idempotency-Key`. Zelfde sleutel en zelfde inhoud: zelfde antwoord, niets opnieuw uitgevoerd. Andere inhoud: `409 IDEMPOTENCY_KEY_REUSED`. Geen sleutel: `400 IDEMPOTENCY_KEY_MISSING`;
- sleutels worden minimaal 7 dagen bewaard, ook na een herstart;
- batchverwerking is daarnaast idempotent op `vernietigingId + batchNummer`; hetzelfde batchnummer met een afwijkende inhoud levert `409 Conflict`;
- een identieke batch opnieuw aanbieden leidt niet tot dubbele vernietiging;
- gedeeltelijke verwerking kan veilig worden hervat, en het event *Vernietigen* behoudt dan het oorspronkelijke tijdstip;
- eerdere resultaten en specificaties blijven opvraagbaar;
- retries en herstelacties worden technisch gelogd.

## 10. Logging en observability

De Stekker legt minimaal vast: het tijdstip van request en verwerking, `selectieId`, `vernietigingId`, `batchNummer`, `vernietigingskandidaatId`, de technische sleutel uit de `identificatie`, het resultaat of de foutcode, technische foutdetails waar relevant, en `correlatieId` of `logReference`.

Logging ondersteunt foutanalyse en beheer. De formele verantwoording vindt plaats in het vernietigingsdossier van de Cockpit.

## 11. Foutafhandeling

HTTP-fouten worden gebruikt voor fouten op request- of resourceniveau; resultaten per kandidaat voor geldige requests waarvan de uitvoering voor een kandidaat niet slaagt.

| Status | Gebruik |
|--------|--------|
| `400` | Ongeldige of onvolledige request, of een ontbrekende `Idempotency-Key`. |
| `401` | Authenticatie ontbreekt of is ongeldig. |
| `403` | Client is niet geautoriseerd. |
| `404` | Selectie, vernietiging, batch of kandidaat bestaat niet. |
| `409` | Ongeldige statusovergang, idempotentieconflict, selectie niet gereed of specificatie niet beschikbaar. |
| `500` | Onverwachte technische fout. |

Elke foutresponse gebruikt het standaard foutmodel uit de OpenAPI-specificatie.

## 12. Opleveringen door leverancier

De leverancier levert minimaal op:

1. Een werkende Stekker-implementatie die voldoet aan de OpenAPI-specificatie v2.0.0.
2. Een beschrijving van de bronadapter (§3), inclusief de vernietigingsmethode en de behandeling van restanten.
3. Een beschrijving van de selectielogica en de **mapping naar het MDTO-profiel** (§5).
4. Een beschrijving van de identificaties (`vernietigingskandidaatId`, `identificatie` met bronnen).
5. Een beschrijving van het vernietigingsgedrag in de bron, inclusief onderdelen en bestanden van aggregaties.
6. Een overzicht van foutcodes en foutcategorieën.
7. Een beschrijving van logging, monitoring en correlatie.
8. Testresultaten voor de acceptatiescenario's uit `stekker-api-implementatiechecklist.md`, inclusief de XSD-validatie van de specificatie.
9. Een configuratievoorbeeld voor test en acceptatie.
10. Een beheerinstructie voor credentials, rate limits, retries en herstart.

## 13. Acceptatie

Een Stekker wordt pas geaccepteerd wanneer:

- de OpenAPI-specificatie zonder fouten valideert en alle verplichte endpoints werken;
- elke kandidaat voldoet aan het MDTO-profiel en de selectie reproduceerbaar en bevroren is na `READY`;
- vernietiging alleen gebeurt voor expliciet aangeboden kandidaten en voldoet aan de MDTO-definitie;
- idempotentie aantoonbaar werkt, ook voor `POST /selecties`;
- resultaten volledig en herleidbaar zijn, met het event *Vernietigen* bij `SUCCESS`;
- de specificaties valideren tegen de MDTO-XSD 1.0.1;
- de foutafhandeling voldoet aan het contract en de logging voldoende is voor foutanalyse;
- de acceptatiescenario's uit de implementatiechecklist slagen.
