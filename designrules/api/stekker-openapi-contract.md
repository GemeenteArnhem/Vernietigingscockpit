# Begeleidend contract – Stekker API Vernietigingscockpit (v2)

Dit document beschrijft de normatieve afspraken en gedragsregels voor implementaties van de Stekker API, versie 2. Deze afspraken zijn bindend voor alle leveranciers en implementaties. De OpenAPI-specificatie (`stekker-openapi-spec.yaml`, v2.0.0) en dit begeleidend contract vormen samen het contract tussen de Vernietigingscockpit en de stekker.

De Stekker API ondersteunt het selecteren en vernietigen van informatieobjecten. Het uitwisselobject is de **vernietigingskandidaat**: precies één MDTO-informatieobject op aggregatieniveau Archief, Serie, Dossier of Archiefstuk (ADR-0001, ADR-0005). Waar dit contract over het vernietigen van een kandidaat spreekt, gaat het om dat informatieobject met al zijn onderdelen en bestanden.

**MDTO is leidend** voor benaming, begrippen en structuur van de gegevens over informatieobjecten (ADR-0005). Zie `api-informatiemodel.md` en `designrules/begrippenlijsten/`.

Dit contract is opgesteld in lijn met gangbare ontwerpprincipes en publieke standaarden voor overheidssoftware en API's, waaronder:

* MDTO (Nationaal Archief)
* NeRDS-leidraad softwareontwikkeling
* API Design Rules (ADR)
* Common Ground

Daarbij is gekozen voor een resource-georiënteerde, eenvoudige en domeingedreven opzet. De API maakt de processtatus en uitvoeringsresultaten van selectie en vernietiging opvraagbaar via stabiel identificeerbare resources, terwijl de verantwoordelijkheden tussen cockpit, stekker en bronsysteem strikt gescheiden blijven.

## 1. Doel en uitgangspunten

De Stekker API faciliteert:

- het leveren van een bevroren selectie van vernietigingskandidaten, met hun MDTO-metagegevens (selectie);
- het uitvoeren van vernietiging op basis van door de cockpit vrijgegeven kandidaten (vernietiging);
- het terugkoppelen van vernietigingsresultaten per kandidaat, met het MDTO-event *Vernietigen* en een specificatie (resultaatverantwoording).

Daarbij geldt:

- de cockpit voert regie, beoordeling, accordering en verantwoording uit;
- de cockpit bepaalt welke kandidaten na besluitvorming ter vernietiging worden aangeboden;
- de stekker voert selectie en vernietiging operationeel uit;
- de stekker bevat de bron- en domeinspecifieke logica, zoals de toepassing van de selectielijst, bewaartermijnen en technische uitvoeringsregels;
- de stekker rapporteert per kandidaat het resultaat van de uitvoering terug aan de cockpit;
- de cockpit bevat geen selectie- of vernietigingslogica;
- de cockpit verwerkt de teruggekoppelde resultaten in het vernietigingsdossier en gebruikt deze voor verantwoording, controle en de verklaring van vernietiging.

## 2. Algemene principes

De algemene architectuurprincipes, verantwoordelijkheden en scheiding tussen cockpit, stekker en bronsysteem zijn vastgelegd in `architectuur-stekker.md`. Dit begeleidend contract specificeert hoe deze principes via de Stekker API worden toegepast.

De Stekker API volgt een resource-georiënteerd ontwerp conform de API Design Rules. De exacte endpoints, request- en responsemodellen, statuscodes, foutmodellen en **verplichte velden** staan in de OpenAPI-specificatie.

De API volgt daarbij de volgende uitgangspunten:

- de major versie staat in de URI (`/v2`, API-20); elke response bevat de header `API-Version` met het volledige versienummer (API-57);
- selecties en vernietigingen zijn afzonderlijke resources;
- iedere selectie heeft een stabiele `selectieId`, iedere vernietiging een stabiele `vernietigingId`;
- processturing, herstart, audit en dossieropbouw gebruiken altijd deze stabiele identificaties;
- de API is stateless in interactie, maar maakt de processtatus opvraagbaar via resources;
- de stekker beheert de operationele toestand van selecties en vernietigingen;
- de cockpit voert procesregie, batching, herstart en verwerking van resultaten uit.

### 2.1 Scheiding van verantwoordelijkheden

De scheiding van verantwoordelijkheden is normatief vastgelegd in `architectuur-stekker.md`.

Voor dit API-contract betekent dit:

- de cockpit bepaalt welke vrijgegeven kandidaten ter vernietiging worden aangeboden;
- de stekker bepaalt hoe selectie en vernietiging technisch worden uitgevoerd;
- de stekker retourneert status, resultaten en specificaties aan de cockpit;
- de cockpit verwerkt deze in het vernietigingsdossier.

De stekker mag geen normatieve besluiten nemen. De cockpit mag geen selectie- of vernietigingslogica uitvoeren. Het controleren van contractinvarianten, zoals waardering V en einddatum = startdatum + looptijd, is géén selectielogica.

### 2.2 Stateless API, state in resources

Iedere request bevat voldoende informatie om de gevraagde actie of opvraging uit te voeren. De operationele toestand van selectie en vernietiging wordt door de stekker beheerd en via resources beschikbaar gemaakt (alle paden relatief aan `/v2`):

- selecties: `/selecties/{selectieId}`
- vernietigingskandidaten binnen een selectie: `/selecties/{selectieId}/vernietigingskandidaten`
- vernietigingen: `/vernietigingen/{vernietigingId}`
- batches en resultaten van een vernietiging: `/vernietigingen/{vernietigingId}/batches`
- resultaten van een batch: `/vernietigingen/{vernietigingId}/batches/{batchNummer}`
- de specificatie van een vernietigde kandidaat: `/vernietigingen/{vernietigingId}/specificaties/{vernietigingskandidaatId}`

Hierdoor kunnen meerdere selecties en vernietigingen naast elkaar bestaan binnen dezelfde stekker. Dit ondersteunt parallelle vernietiging, herstartbaarheid, reproduceerbaarheid en audit.

Een stekker kan bijvoorbeeld één systeem voor het sociaal domein ontsluiten. Binnen dat systeem kunnen afzonderlijke processen bestaan, zoals handhaving en uitkering. Dezelfde stekker kan dan zowel een vernietigingstaak voor handhavingsdossiers als een taak voor uitkeringsdossiers ondersteunen, afzonderlijk herleidbaar via hun eigen `selectieId` en `vernietigingId`.

### 2.3 Resource-identificatie

`selectieId` en `vernietigingId` zijn blijvende identificaties binnen de context van de stekker. Ze worden gebruikt voor processturing, statusopvraging, het ophalen van kandidaten, het aanbieden en volgen van batches, herstart en herstel, audit en dossieropbouw en de terugkoppeling van resultaten.

Een selectie of vernietiging mag na aanmaak niet stilzwijgend van betekenis veranderen. Nieuwe selectie- of vernietigingsruns krijgen een nieuwe identificatie.

### 2.4 Correlatie met de Cockpit

De stekker moet selectie, vernietiging, batches en uitvoeringsresultaten herleidbaar maken tot de procescontext van de Cockpit. De correlatievelden zijn:

- `selectieId`: de selectie waarop de vernietiging is gebaseerd;
- `vernietigingId`: de uitvoeringsresource bij de stekker;
- `cockpitTaakId`: de taak in de Cockpit waaruit de uitvoering voortkomt;
- `besluitReferentie`: het besluit of de vrijgave op basis waarvan de uitvoering is gestart;
- `vernietigingsdossierId`: het Cockpit-dossier;
- `batchNummer`: technische batch binnen een vernietiging;
- `vernietigingskandidaatId`: stabiele identificatie van de kandidaat over selectie, beoordeling, vernietiging en resultaatverwerking;
- `identificatie`: de MDTO-identificaties van het informatieobject (`identificatieKenmerk` + `identificatieBron`). Minimaal de technische sleutel waarmee de stekker het object in de bron terugvindt, en bij voorkeur het voor mensen herkenbare kenmerk, zoals een zaaknummer.

Deze correlatiegegevens moeten in responses, resultaten en technische logging beschikbaar blijven zolang dat nodig is voor processturing, herstart, audit en dossieropbouw.

### 2.5 MDTO-metagegevens

De stekker levert per kandidaat de MDTO-metagegevens volgens het profiel in `api-informatiemodel.md` §5.2. Daarbij geldt:

- **aggregatieniveau**: uitsluitend Archief, Serie, Dossier of Archiefstuk; een kandidaat is nooit een kunstmatige groepering;
- **waardering**: uit de gesloten MDTO-lijst (B/V/N); in een vernietigingsselectie hoort alleen V;
- **bewaartermijn**: `termijnEinddatum` is altijd gevuld. Trigger, startdatum en looptijd worden geleverd zodra bekend, zodat de einddatum controleerbaar is;
- **informatiecategorie**: de categorie uit de vastgestelde selectielijst, met de selectielijst (naam, identificatie, versie) als begrippenlijst;
- **begrippen**: elke begripwaarde verwijst via `begripBegrippenlijst` naar de lijst waaruit ze komt;
- **archiefvormer**: alleen meegeven als die afwijkt van de archiefvormer van de taak in de Cockpit, bijvoorbeeld bij een gemeenschappelijke regeling.

## 3. Selectie

### 3.1 Definitie

Een selectie is een bevroren momentopname van vernietigingskandidaten:

- de selectie heeft een `selectieId` en een `selectietijdstip`;
- de selectie bevat de kandidaten die op dat moment als vernietigingskandidaat zijn bepaald: waardering V en `bewaartermijn.termijnEinddatum` op of vóór de peildatum;
- de selectie verandert niet meer nadat deze gereed is (`READY`);
- dezelfde selectie levert bij herhaald opvragen dezelfde kandidaten op, met dezelfde metagegevens.

### 3.2 Starten van een selectie

`POST /selecties` start een nieuwe selectie, met een verplichte `Idempotency-Key` (§4.5).

Bij het starten maakt de stekker een nieuwe selectie-resource aan met een eigen `selectieId`. Een nieuwe selectie overschrijft geen bestaande selectie. Eerdere selecties blijven via hun eigen `selectieId` opvraagbaar zolang dat nodig is voor processturing, herstart, audit en dossieropbouw.

Wordt het verzoek met dezelfde `Idempotency-Key` en dezelfde inhoud herhaald, dan start de stekker géén nieuwe selectie, maar geeft hij de eerder gestarte selectie terug.

### 3.3 Status van een selectie

`GET /selecties/{selectieId}` retourneert de status (`IDLE`, `RUNNING`, `READY`, `FAILED`) en de metagegevens van een selectie. De verplichte velden staan in de OpenAPI-specificatie. De stekker vult waar beschikbaar ook `selectietijdstip`, `totaalKandidaten`, `totaalObjecten`, de versies en de aantallen waarschuwingen en fouten.

### 3.4 Ophalen van vernietigingskandidaten

Vernietigingskandidaten worden opgehaald via:

`GET /selecties/{selectieId}/vernietigingskandidaten`

Daarbij geldt:

- paginering via `offset` en `limit`, of via de opake `cursor` uit `nextCursor`; niet allebei tegelijk (anders `400`);
- de maximale paginagrootte is 500;
- iedere pagina bevat kandidaten uit dezelfde selectie en noemt de gebruikte `selectieId`;
- zolang de selectie niet `READY` is, volgt `409` met foutcode `SELECTIE_NOT_READY`.

De paginering is technisch bedoeld om grote lijsten beheersbaar op te halen. Paginering verandert de inhoud van de selectie niet.

### 3.5 Stabiliteit van de selectie

De stekker moet garanderen dat alle pagina's uit dezelfde bevroren selectie komen. De stekker mag geen kandidaten toevoegen aan of verwijderen uit een selectie nadat deze `READY` is.

Wanneer brongegevens na het maken van de selectie wijzigen, wijzigt de bestaande selectie niet. Afwijkingen tussen selectie en latere vernietiging worden bij de uitvoering gerapporteerd als resultaat per kandidaat.

## 4. Vernietiging

### 4.1 Aanmaken van een vernietigingsuitvoering

`POST /vernietigingen` maakt een nieuwe vernietigingsuitvoering aan, nadat de cockpit een selectie heeft beoordeeld, uitsluitingen heeft verwerkt en de vernietiging normatief is vrijgegeven.

De request bevat:

- de `selectieId` waarop de vernietiging is gebaseerd;
- het `cockpitTaakId`;
- de `besluitReferentie`;
- het `vernietigingsdossierId`, waarmee de uitvoering herleidbaar is tot het Cockpit-dossier.

De stekker maakt een nieuwe vernietiging-resource aan met een eigen `vernietigingId` en zet die op `IDLE`. In deze status mag de Cockpit batches aanleveren. De stekker mag nog niet technisch vernietigen.

### 4.2 Parallelle vernietiging

Een stekker mag meerdere vernietigingen parallel ondersteunen, zolang ze afzonderlijk adresseerbaar, herleidbaar en controleerbaar blijven via hun eigen `vernietigingId`:

- iedere vernietiging verwijst naar de selectie waarop deze is gebaseerd;
- batches horen altijd bij één `vernietigingId`;
- resultaten worden altijd per `vernietigingId`, batch en kandidaat teruggekoppeld;
- fouten of blokkades binnen één vernietiging blokkeren andere vernietigingen niet automatisch.

Komt hetzelfde informatieobject in meerdere vernietigingen voor, dan loopt de verwerking door. Is het object al eerder vernietigd of bestaat het niet meer, dan rapporteert de stekker `NOT_FOUND`. Weet de stekker dat het object door een andere uitvoering is vernietigd, dan vermeldt hij dat in `toelichting`. `NOT_FOUND` is géén bewijs van vernietiging door déze uitvoering.

### 4.3 Batchverwerking

Vernietiging gebeurt in batches. Een batch is een technische groepering van kandidaten binnen één vernietiging, bedoeld om grote aantallen beheersbaar te verwerken en te kunnen herstarten. Een batch is geen afzonderlijk normatief besluit en geen aparte vernietigingstaak.

Batches worden aangeboden via `POST /vernietigingen/{vernietigingId}/batches`, met:

- `batchNummer`;
- `vernietigingskandidaten`: per kandidaat het `vernietigingskandidaatId` en de `identificatie`, **letterlijk** zoals de stekker die bij de selectie heeft geleverd.

Iedere aangeboden kandidaat moet een vrijgegeven kandidaat uit dezelfde selectie zijn, met dezelfde identificatie; anders weigert de stekker de batch met `400`. De stekker mag niet zelfstandig extra kandidaten of informatieobjecten aan een vernietiging toevoegen.

Het aanbieden van een batch is nog geen startsein voor technische vernietiging. De stekker verzamelt batches zolang de uitvoering `IDLE` is.

### 4.4 Vrijgeven voor uitvoering

Nadat de Cockpit alle batches heeft aangeleverd, geeft de Cockpit de uitvoering expliciet vrij via `POST /vernietigingen/{vernietigingId}/vrijgeven`, met:

- `aantalBatches`: het aantal aangeleverde batches;
- `aantalKandidaten`: het aantal aangeleverde kandidaten.

De stekker controleert bij vrijgave minimaal:

- of de vernietiging bestaat en nog `IDLE` is;
- of het aantal ontvangen batches overeenkomt met `aantalBatches`;
- of het aantal aangeboden kandidaten overeenkomt met `aantalKandidaten`;
- of iedere aangeboden kandidaat herleidbaar is tot de onderliggende selectie;
- of hetzelfde `batchNummer` niet met afwijkende inhoud is aangeleverd.

Slaagt de controle, dan zet de stekker de vernietiging op `RUNNING` en legt hij de **wijze van vernietiging** vast in `vernietigingsmethode` (lijst Cockpit-vernietigingsmethoden) en `vernietigingsmethodeToelichting`. Die toelichting beschrijft ook back-ups, replica's, indexen en logbestanden, en de termijn waarbinnen restanten daarin zijn uitgedoofd. Daarna mag de technische vernietiging starten of worden ingepland.

Slaagt de controle niet, dan retourneert de stekker `409 Conflict` of `400 Bad Request`, afhankelijk van de fout.

### 4.5 Idempotentie

**Idempotency-Key (ADR-0004).** Alle muterende verzoeken (`POST /selecties`, `POST /vernietigingen`, `POST …/batches`, `POST …/vrijgeven`) vereisen de header `Idempotency-Key`, een string van maximaal 200 tekens. De cockpit bepaalt het formaat.

- Zelfde sleutel en zelfde inhoud: de stekker voert niets opnieuw uit en geeft hetzelfde antwoord, in de actuele stand van de resource.
- Zelfde sleutel met andere inhoud: `409 Conflict`, foutcode `IDEMPOTENCY_KEY_REUSED`.
- Ontbrekende sleutel: `400 Bad Request`, foutcode `IDEMPOTENCY_KEY_MISSING`.
- Een sleutel geldt per endpoint en resource.
- De stekker bewaart sleutels minimaal 7 dagen, ook over een herstart heen.

**Batches.** Daarnaast is `POST /vernietigingen/{vernietigingId}/batches` idempotent op de combinatie `vernietigingId` + `batchNummer`:

- dezelfde batch met identieke inhoud levert dezelfde acceptatie of het beschikbare batchresultaat;
- hetzelfde `batchNummer` met afwijkende inhoud levert `409 Conflict`;
- een kandidaat die al in een andere batch van dezelfde vernietiging is aangeleverd, levert `409 Conflict`.

**Uitvoering.** De stekker voert dezelfde batch nooit dubbel uit. Gedeeltelijk verwerkte batches kunnen veilig worden hervat; resultaten blijven herleidbaar per batch en per kandidaat. Een retry mag nooit leiden tot een tweede technische vernietiging van hetzelfde informatieobject zonder dat dit expliciet en herleidbaar als bestaand resultaat wordt verwerkt. Bij hervatting behoudt het event *Vernietigen* het oorspronkelijke tijdstip.

### 4.6 Asynchrone verwerking

Vernietiging wordt asynchroon uitgevoerd. De `POST`-requests leveren aan en bevatten geen definitieve uitvoeringsresultaten. De technische vernietiging start pas na `POST /vernietigingen/{vernietigingId}/vrijgeven`.

De requests worden getriggerd door de cockpit, op basis van:

- een afgeronde beoordeling van de kandidaten;
- de vereiste accordering binnen de workflow;
- de vrijgave door de archivaris en de vernietigingsopdracht van de recordmanager;
- technische batching door de cockpit;
- het expliciet vrijgeven van de uitvoering via `/vrijgeven`;
- eventuele retries of herstarts.

De stekker vernietigt alleen kandidaten die expliciet in een batch zijn aangeboden, en pas nadat de vernietiging is vrijgegeven.

## 5. Resultaten via API

### 5.1 Polling als primair mechanisme

De API is polling-gebaseerd. De cockpit haalt status, resultaten en specificaties actief op via:

- `GET /vernietigingen/{vernietigingId}`
- `GET /vernietigingen/{vernietigingId}/batches`
- `GET /vernietigingen/{vernietigingId}/batches/{batchNummer}`
- `GET /vernietigingen/{vernietigingId}/specificaties/{vernietigingskandidaatId}`

### 5.2 Resultaten als bron voor uitvoeringsterugkoppeling

De stekker rapporteert resultaten per batch en per kandidaat. Deze resultaten vormen de technische terugkoppeling aan de cockpit. De cockpit verwerkt ze in het vernietigingsdossier en gebruikt ze voor controle, verantwoording en de verklaring van vernietiging.

De stekker moet resultaten en specificaties beschikbaar houden zolang dat nodig is voor processturing, herstart, audit en dossieropbouw, en minimaal tot de cockpit de uitvoering heeft afgerond.

### 5.3 Specificatie van de vernietiging

Voor iedere kandidaat met resultaat `SUCCESS` levert de stekker via `GET /vernietigingen/{vernietigingId}/specificaties/{vernietigingskandidaatId}` een MDTO-XML-document (MDTO-XML 1.0.1, `application/xml`). Dit is de specificatie van de vernietigde archiefbescheiden in de zin van art. 8 Archiefbesluit 1995 (ADR-0005, B-M2). Het document bevat:

- het vernietigde informatieobject met `identificatie`, `naam`, `aggregatieniveau`, `waardering`, `bewaartermijn`, `informatiecategorie`, `archiefvormer` en `beperkingGebruik`;
- een `event` met `eventType` *Vernietigen*, de `eventTijd` en een `eventResultaat` met de vernietigingsmethode;
- bij Archief, Serie en Dossier: een `bevatOnderdeel` (naam en identificatie) per direct onderliggend informatieobject.

Het document moet valideren tegen de MDTO-XSD 1.0.1. Zonder `SUCCESS` volgt `409` (`SPECIFICATIE_NIET_BESCHIKBAAR`); voor een kandidaat die niet in de vernietiging is aangeboden `404`. De cockpit neemt het document op als bestand, met checksum, in het vernietigingsdossier.

## 6. Status vernietiging

`GET /vernietigingen/{vernietigingId}` geeft de status van één specifieke vernietiging, met de aantallen ontvangen, aangekondigde en verwerkte batches (`ontvangenBatches`, `totaalBatches`, `verwerkteBatches`), de aantallen per resultaat en vanaf `RUNNING` de vernietigingsmethode.

### 6.1 Status betekenis

| Status | Betekenis |
|---|---|
| `IDLE` | De vernietiging is aangemaakt en batches kunnen worden aangeleverd; technische vernietiging is nog niet vrijgegeven. |
| `RUNNING` | De vernietiging is via `/vrijgeven` vrijgegeven en wordt verwerkt of staat gepland voor verwerking. |
| `COMPLETED` | Alle aangeboden kandidaten zijn vernietigd (`SUCCESS`). |
| `PARTIAL` | De vernietiging is afgerond, maar één of meer kandidaten hebben een ander eindresultaat dan `SUCCESS`, zoals `FAILED`, `SKIPPED`, `NOT_FOUND` of `CHANGED`. |
| `FAILED` | De vernietiging als geheel is mislukt of kan niet betrouwbaar worden voortgezet. |

De status heeft altijd betrekking op één `vernietigingId`. Parallelle vernietigingen hebben ieder hun eigen status.

### 6.2 Statusovergangen

Selecties:

```text
IDLE -> RUNNING -> READY
IDLE -> RUNNING -> FAILED
```

Een selectie met status `READY` is bevroren.

Vernietigingen:

```text
IDLE -> RUNNING -> COMPLETED
IDLE -> RUNNING -> PARTIAL
IDLE -> RUNNING -> FAILED
```

Een vernietiging blijft `IDLE` zolang de Cockpit batches aanlevert. De overgang naar `RUNNING` vindt uitsluitend plaats na een succesvolle `POST /vernietigingen/{vernietigingId}/vrijgeven`.

Een stekker mag statusovergangen niet gebruiken om resultaten te verbergen. Ook bij `PARTIAL` en waar mogelijk bij `FAILED` blijven beschikbare resultaten via de resultaten-endpoints opvraagbaar.

## 7. Resultaten per kandidaat

De stekker rapporteert per aangeboden kandidaat **precies één eindresultaat**:

| Resultaat | Betekenis |
|---|---|
| `SUCCESS` | Het informatieobject is vernietigd in de zin van MDTO: blijvend ontoegankelijk gemaakt, met al zijn onderdelen en bestanden. Het resultaat bevat het event *Vernietigen* met `eventTijd`. |
| `FAILED` | De vernietiging is geprobeerd, maar mislukt. |
| `SKIPPED` | De vernietiging is niet uitgevoerd. |
| `NOT_FOUND` | Het informatieobject is niet gevonden of bestaat niet meer. Dit is géén bewijs van vernietiging door deze uitvoering. |
| `CHANGED` | Het informatieobject is sinds de selectie gewijzigd en is daarom niet vernietigd. |

Een soft delete, prullenbak, archiveringsvlag of andere herstelbare verwijdering is géén vernietiging en mag niet als `SUCCESS` worden gemeld.

### 7.1 Betekenis van `CHANGED`

`CHANGED` betekent dat het informatieobject niet is vernietigd, omdat het tijdens de uitvoering niet meer overeenkomt met de selectie of de vernietigingsopdracht. Bijvoorbeeld wanneer:

- het informatieobject of zijn status na selectie inhoudelijk is gewijzigd;
- de waardering, informatiecategorie of bewaartermijn opnieuw moet worden bepaald;
- identificerende kenmerken niet meer overeenkomen met de vrijgegeven selectie.

De stekker mag het object dan niet stilzwijgend vernietigen. Hij rapporteert `CHANGED`, zodat de cockpit het verschil tussen selectie, besluit en uitvoering zichtbaar maakt in het vernietigingsdossier.

### 7.2 Inhoud van een resultaat

Een resultaat bevat minimaal de velden die de OpenAPI-specificatie verplicht stelt (`vernietigingskandidaatId`, `identificatie`, `resultaat`), en verder:

- `batchNummer`, indien het resultaat buiten de batchcontext wordt ontsloten;
- bij `SUCCESS`: `event` (*Vernietigen*, `eventTijd`, `eventResultaat`) en, als de stekker het event ook in de bron vastlegt, `bronEventReferentie` (ADR-0005, B-M7);
- bij een ander resultaat: `foutcode` en `foutmelding` of `toelichting`;
- eventueel een `bronstatus`;
- eventueel een `logReference` of `correlatieId`.

### 7.3 Geen blokkade van het volledige proces

Een fout of afwijking bij één kandidaat blokkeert niet automatisch de verwerking van andere kandidaten binnen dezelfde vernietiging. De stekker verwerkt de overige kandidaten zoveel mogelijk door en rapporteert afwijkingen per kandidaat.

## 8. Fouten en logging

### 8.0 Fouten via HTTP versus resultaten per kandidaat

HTTP-fouten worden gebruikt wanneer de request als geheel niet kan worden geaccepteerd of verwerkt. Resultaten per kandidaat worden gebruikt wanneer de request geldig is, maar de uitvoering voor een specifieke kandidaat niet succesvol is.

De standaard foutpayload bevat `code` en `message`, en optioneel `details`, `correlatieId` en `logReference`.

| Status | Betekenis |
|---|---|
| `400` | De request is syntactisch of inhoudelijk ongeldig, of de `Idempotency-Key` ontbreekt. |
| `401` | Authenticatie ontbreekt of is ongeldig. |
| `403` | De client is geauthenticeerd, maar niet geautoriseerd voor deze actie. |
| `404` | De gevraagde selectie, vernietiging, batch of kandidaat bestaat niet of is niet beschikbaar voor deze client. |
| `409` | De request conflicteert met de actuele status of met een eerdere aanlevering. |
| `500` | Onverwachte technische fout bij de stekker. |

Vaste foutcodes binnen v2:

| Foutcode | Status | Betekenis |
|---|---|---|
| `VALIDATION_ERROR` | 400 | Ongeldige of onvolledige request |
| `IDEMPOTENCY_KEY_MISSING` | 400 | `Idempotency-Key` ontbreekt op een muterend verzoek |
| `IDEMPOTENCY_KEY_REUSED` | 409 | Dezelfde `Idempotency-Key` met een andere inhoud |
| `SELECTIE_NOT_READY` | 409 | Kandidaten opvragen of vernietiging starten bij een selectie die niet `READY` is |
| `SPECIFICATIE_NIET_BESCHIKBAAR` | 409 | Specificatie gevraagd voor een kandidaat zonder `SUCCESS` |

Voorbeelden:

- een batch voor een onbekende `vernietigingId` levert `404` op;
- een batch met hetzelfde `batchNummer` maar een afwijkende inhoud levert `409` op;
- een geldig aangeboden kandidaat die in de bron niet meer bestaat, levert geen HTTP-fout op, maar resultaat `NOT_FOUND`;
- een geldig aangeboden kandidaat die sinds selectie gewijzigd is, levert geen HTTP-fout op, maar resultaat `CHANGED`.

### 8.1 Selectie

Bij selectie retourneert de stekker alleen kandidaten die als vernietigingskandidaat zijn bepaald. Bij fouten of onzekerheden tijdens selectie geldt:

- de fout wordt gelogd in de logging van de stekker;
- de selectie meldt in `aantalWaarschuwingen` en `aantalFouten` dat er waarschuwingen of fouten zijn opgetreden;
- de stekker retourneert geen kandidaten waarvan niet betrouwbaar kan worden vastgesteld dat ze vernietigingskandidaat zijn, zoals een waardering N, een ontbrekende bewaartermijn of een onbekend aggregatieniveau;
- de stekker mag onzekerheden of uitzonderingen niet stilzwijgend negeren.

Wanneer detailinformatie over selectiefouten nog niet via de API wordt ontsloten, moet de stekker minimaal een verwijzing naar de relevante logging of monitoring kunnen geven. Verdere ontsluiting is een aandachtspunt voor doorontwikkeling.

### 8.2 Vernietiging

Bij vernietiging rapporteert de stekker fouten per kandidaat, met `vernietigingskandidaatId`, `identificatie`, `resultaat`, `foutcode`, `foutmelding` of toelichting, en eventueel `logReference` of `correlatieId`.

Foutcodes moeten stabiel zijn binnen een major versie, begrijpelijk zijn voor implementaties, geschikt zijn voor rapportage en dossieropbouw, en waar mogelijk verwijzen naar een vastgelegde referentielijst. Voorbeelden van foutcategorieën:

| Foutcategorie | Betekenis |
|---|---|
| `NOT_FOUND` | Het informatieobject is niet gevonden of bestaat niet meer. |
| `CHANGED` | Het informatieobject is gewijzigd sinds selectie en is niet vernietigd. |
| `VALIDATION_ERROR` | De aangeleverde gegevens zijn ongeldig of onvolledig. |
| `AUTHORIZATION_ERROR` | De stekker of bron staat de vernietiging niet toe. |
| `SOURCE_UNAVAILABLE` | Het bronsysteem is tijdelijk niet beschikbaar. |
| `TECHNICAL_ERROR` | Er is een technische fout opgetreden tijdens verwerking. |
| `UNKNOWN_ERROR` | De fout kan niet specifieker worden geclassificeerd. |

### 8.3 Logging en herleidbaarheid

De stekker legt logging vast die voldoende is voor beheer, foutanalyse, audit en reproduceerbaarheid. De logging bevat minimaal:

- tijdstip van request of verwerking;
- `selectieId` of `vernietigingId`;
- `batchNummer` en `vernietigingskandidaatId`, indien van toepassing;
- de technische sleutel uit de `identificatie`, indien van toepassing;
- resultaat of foutcode, en technische foutdetails indien van toepassing;
- `correlatieId` of `logReference`.

De logging van de stekker is ondersteunend aan de technische uitvoering. De cockpit verwerkt de formele resultaten en specificaties in het vernietigingsdossier. Logging is geen vervanging voor het terugkoppelen van resultaten via de API.

## 9. Performance en schaalbaarheid

De stekker moet geschikt zijn voor verwerking van grote aantallen kandidaten en informatieobjecten:

- grote datasets gefaseerd verwerken;
- paginering bij selectie en batchverwerking bij vernietiging ondersteunen;
- asynchrone verwerking ondersteunen waar dat nodig is;
- interne optimalisaties (caching, scheduling, throttling, wachtrijen) zijn toegestaan, zonder verlies van herleidbaarheid, reproduceerbaarheid of controle.

### 9.1 Impact op productiegebruik

Selectie en vernietiging mogen het normale productiegebruik van het bronsysteem niet onaanvaardbaar verstoren. De stekker houdt rekening met de belasting van het bronsysteem, piekbelasting tijdens kantoor- of productietijden, de beschikbare capaciteit van bron-API's en databases, rate limits, spreiding van verwerking in tijd en veilige hervatting na onderbreking. Waar nodig ondersteunt hij throttling, scheduling buiten piekuren, beperking van de batchgrootte en pauzeren en hervatten.

### 9.2 Parallelle verwerking

Parallelle selectie of vernietiging is toegestaan, zolang processen elkaar niet oncontroleerbaar beïnvloeden:

- parallelle processen zijn herkenbaar via hun eigen `selectieId` of `vernietigingId`;
- ze overschrijven elkaars status, resultaten of logging niet;
- fouten in één proces blokkeren andere processen niet automatisch;
- parallelle verwerking leidt nooit tot dubbele vernietiging of onduidelijke resultaten.

### 9.3 Assessment en acceptatie

Bij implementatie moet aantoonbaar worden gemaakt dat de stekker voldoet aan de afgesproken eisen voor performance, schaalbaarheid en productie-impact. Dat kan met een technisch assessment, een performance- of loadtest, een ketentest met de cockpit, afspraken over batchgrootte en verwerkingssnelheid, afspraken over verwerking binnen of buiten productietijden, en monitoring tijdens verwerking. De uitkomsten worden vastgelegd voordat de stekker in productie wordt gebruikt.

### 9.4 Monitoring

De stekker geeft inzicht in lopende selecties en vernietigingen, verwerkte batches, aantallen verwerkte kandidaten, foutaantallen en foutcategorieën, de gemiddelde verwerkingstijd, wachtrijen of vertragingen, en beperkingen vanuit het bronsysteem. Monitoring is bedoeld voor beheer; de formele resultaten gaan via de API naar de cockpit.

## 10. Security

### 10.1 API-beveiliging

De Stekker API is beveiligd voor systeem-naar-systeemcommunicatie:

- communicatie verloopt via HTTPS;
- authenticatie en autorisatie zijn verplicht;
- de API ondersteunt OAuth2 (bij voorkeur Client Credentials) of een gelijkwaardig mechanisme;
- credentials, tokens en secrets worden veilig beheerd en niet gelogd;
- requests zijn herleidbaar tot een geautoriseerde client.

### 10.2 Autorisatie

Toegang is gebaseerd op scopes (`selectie.read`, `selectie.write`, `vernietiging.read`, `vernietiging.write`; de specificatie valt onder `vernietiging.read`), volgens least privilege. Onbevoegde requests worden geweigerd en gelogd. Autorisatie mag niet afhankelijk zijn van impliciete aannames in de client.

## 11. Versies en compatibiliteit

De Stekker API moet kunnen evolueren zonder bestaande processen onnodig te breken:

- de major versie staat in de URI (`/v2`), het volledige versienummer in de header `API-Version`;
- uitbreidingen zijn bij voorkeur additief; nieuwe velden zijn optioneel, tenzij een nieuwe major versie wordt geïntroduceerd;
- bestaande verplichte velden en endpoints worden binnen een major versie niet verwijderd of van betekenis veranderd;
- foutcodes en de gebruikte begrippenlijstversies blijven stabiel binnen een major versie;
- historische processen blijven reproduceerbaar;
- versie-informatie wordt vastgelegd in logging, resultaten en het vernietigingsdossier.

### 11.1 Ondersteuning van bestaande versies

Uitgangspunt: de actuele versie wordt ondersteund, en maximaal twee eerdere ondersteunde versies blijven beschikbaar, tenzij anders overeengekomen. Uitfaseren gebeurt alleen met een expliciet migratiepad.

**Overgang v1 → v2.** v2.0.0 is een brekende versie (ADR-0005), ingevoerd tijdens de ontwikkelfase, toen er nog geen stekkers in productie waren. v1 wordt daarom niet parallel ondersteund. De wijzigingen staan in `api-informatiemodel.md` §9.

### 11.2 Major, minor en patch

| Versietype | Betekenis |
|---|---|
| Major | Bevat mogelijk breaking changes. |
| Minor | Bevat backward compatible uitbreidingen. |
| Patch | Bevat backward compatible correcties of verduidelijkingen. |

### 11.3 Optioneel als uitgangspunt

Nieuwe velden en uitbreidingen zijn standaard optioneel. Bestaande clients hoeven nieuwe velden niet direct te verwerken, en ontbrekende optionele velden mogen niet leiden tot foutieve interpretatie. Een nieuwe waarde in een **gesloten** lijst (`SelectieStatus`, `VernietigingStatus`, `UitvoeringsresultaatWaarde`, MDTO-waardering) is brekend.

## 12. Toekomstige uitbreidbaarheid

Mogelijke toekomstige uitbreidingen, additief binnen v2:

- eventnotificaties (bijvoorbeeld webhooks) naast polling;
- uitgebreidere foutdetails bij selectie;
- referentielijsten voor foutcodes;
- aanvullende monitoring- en beheerinformatie;
- verwerkingssoort *overbrenging* (waardering B, MDTO-event *Overbrenging*), naast vernietiging;
- foutafhandeling volgens `application/problem+json` (RFC 9457), in een volgende major versie.

Deze uitbreidingen doen niet af aan de kernprincipes: stabiel identificeerbare resources, gescheiden normatieve besluitvorming, resultaten per kandidaat, MDTO als leidend kader en backward compatibility binnen een major versie.

## 13. Samenvattend principe

> De stekker bepaalt vernietigingskandidaten, levert hun MDTO-metagegevens en voert vernietiging technisch uit.
> De cockpit stuurt, beoordeelt, besluit en verantwoordt het proces.
> De stekker rapporteert per kandidaat het resultaat, met het event *Vernietigen* en een MDTO-specificatie.
> De API blijft betrouwbaar en herleidbaar door selecties en vernietigingen als stabiel identificeerbare resources aan te bieden.
