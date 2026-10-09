# ADR 0005 – MDTO is leidend voor benaming, begrippen en informatiemodel

## Status
Voorgesteld (concept, nog vast te stellen)

## Datum
2026-10-08

## Context

Het ecosysteem gaat over het vernietigen van archiefbescheiden. Toch is het informatiemodel niet opgezet vanuit een archiefmetagegevensstandaard. De analyse *MDTO-analyse architectuur, Stekker API en informatiemodel* (oktober 2026) laat zien:

- Velden in de Stekker API lijken op MDTO-elementen (classificatie, bewaartermijn, waardering, begin- en einddatum), maar zijn ongetypeerde strings met eigen namen. Daardoor zijn ze niet verliesvrij of toetsbaar om te zetten naar MDTO.
- Verplichte MDTO-gegevens ontbreken: `archiefvormer`, `beperkingGebruik`, de trigger en startdatum van de bewaartermijn, en het tijdstip van het event `Vernietigen`.
- De waardering wijkt af van de gesloten MDTO-lijst: `BEWAREN`/`VERNIETIGEN` tegenover `B`/`V`/`N`.
- De eigen archiefbescheiden van de cockpit (vernietigingsdossier, vernietigingslijst, verklaring, auditlog) worden gearchiveerd met een eigen manifest in plaats van met MDTO.
- De auditset (ADR-0003) gebruikt Engelse namen die niet aansluiten op de MDTO-eventtypen.
- `terminologie.md` definieert *informatieobject* en *vernietiging* anders dan MDTO.

Het product is nog in ontwikkeling. Er zijn geen productiestekkers en geen productiedata. Een brekende overgang is nu goedkoop en later duur.

Bronnen: MDTO-metagegevensschema 1.0 (Standaardisatieraad, 7 april 2021), MDTO-XML 1.0.1 (21 februari 2023), MDTO-begrippenlijsten (Nationaal Archief).

## Beslissing

### 1. MDTO is leidend

Voor elk begrip waarvoor MDTO een **klasse, attribuut, gegevensgroep of begrip** definieert, gebruikt het ecosysteem de **MDTO-naam, de MDTO-definitie, de MDTO-structuur en de MDTO-kardinaliteit**. Dit geldt in alle lagen:

- architectuur- en ontwerpdocumenten, inclusief `terminologie.md`;
- het API-informatiemodel, de OpenAPI-specificatie en het begeleidend contract;
- het datamodel en de code van de cockpit (bestaande en nieuwe velden);
- het auditlog (zie §5);
- de vernietigingsverklaring en het archiefpakket;
- de zichtbare labels in de UI.

Referentieversie: **MDTO 1.0 / MDTO-XML 1.0.1**. Overstappen op een nieuwe MDTO-versie gebeurt via een wijziging van deze ADR.

### 2. Eigen begrippen naast MDTO

Begrippen die MDTO niet kent, behouden hun eigen naam. Ze worden wel **in MDTO-termen gedefinieerd**:

| Eigen begrip | Definitie in MDTO-termen |
|---|---|
| Vernietigingskandidaat (ADR-0001) | Projectie van precies één MDTO-*informatieobject* op aggregatieniveau Archief, Serie, Dossier of Archiefstuk, met de MDTO-gegevens die nodig zijn voor beoordeling, besluit en verantwoording (B-M2). |
| Selectie | Bevroren verzameling vernietigingskandidaten. Bij gereedmelding wordt de vernietigingslijst bevroren (event `Bevriezing`). |
| Vernietigingslijst | MDTO-informatieobject (aggregatieniveau `Archiefstuk`) in het vernietigingsdossier. |
| Vernietigingsdossier | MDTO-informatieobject (aggregatieniveau `Dossier`) met `bevatOnderdeel` naar lijst, besluiten, verklaring en auditlog. |
| Uitvoeringsresultaat | Uitkomst van de verwerking van een kandidaat. Alleen `SUCCESS` leidt tot het MDTO-event `Vernietigen`. |
| Batch, vernietigingsuitvoering, taak, taakdefinitie, beoordeling, accordering (als workflowstap) | Procesbegrippen van de cockpit, zonder MDTO-equivalent. |

Waarden van eigen enums buiten MDTO (workflowstatussen, selectie- en vernietigingsstatus, uitvoeringsresultaat `SUCCESS`…`CHANGED`, foutcodes) blijven ongewijzigd.

### 3. Uitbreidingen op MDTO

- Waar een MDTO-begrippenlijst **open** is, mogen eigen begrippen worden toegevoegd. Die komen in een eigen, gepubliceerde begrippenlijst met naam, identificatie (URI) en versie, onder `designrules/begrippenlijsten/`.
- **Gesloten** MDTO-lijsten (Waarderingen) worden niet uitgebreid.
- Gegevens zonder MDTO-attribuut (bijvoorbeeld `aantalObjecten`, `aantalBetrokkenen`) zijn **cockpituitbreidingen**:
  - ze krijgen een Nederlandse naam in MDTO-stijl (camelCase);
  - ze worden in het informatiemodel als uitbreiding gemarkeerd;
  - ze gaan in een archiefpakket naar `aanvullendeMetagegevens`.
- Eigen begrippenlijsten bij deze ADR:
  - **Cockpit-eventtypen** (§5);
  - **Cockpit-configuratie-eventtypen** (§5);
  - **Cockpit-vernietigingsmethoden** (§4.3, B-M4);
  - **Cockpit-uitsluitredenen**, met in ieder geval *Waardering niet V* (§9, B-M1).
- Voor `aggregatieniveau` komt er **geen** eigen lijst. Alleen de MDTO-lijst is toegestaan (§9, B-M2).

### 4. Stekker API v2.0.0

De Stekker API gaat **direct** naar **v2.0.0**, met MDTO-namen en -structuren. Er komt geen parallelle v1-ondersteuning; de v1.0.0-spec vervalt. Versie 2.0.0 neemt ook ADR-0004 over: een verplichte `Idempotency-Key` op alle POST-verzoeken.

**4.1 Algemeen**
- Major versie in het pad: `/v2/...`, plus een `API-Version`-header (NL API Design Rules API-20/API-57).
- JSON-sleutels zijn de MDTO-attribuutnamen, letterlijk overgenomen, bijvoorbeeld `begripLabel`, `termijnEinddatum` en `identificatieKenmerk`.
- Herbruikbare schema's met de namen en kardinaliteiten uit MDTO-XML 1.0.1: `begripGegevens`, `verwijzingGegevens`, `identificatieGegevens`, `termijnGegevens`, `dekkingInTijdGegevens`, `eventGegevens` en `gerelateerdInformatieobjectGegevens`.
- Datums volgen de MDTO-types: `date`, of waar MDTO dat toestaat `gYear`/`gYearMonth`. Een looptijd is een ISO 8601-duur (`xs:duration`).
- Het pad `/selecties/{selectieId}/objecten` wordt `/selecties/{selectieId}/vernietigingskandidaten` (ADR-0001).

**4.2 Vernietigingskandidaat: van v1 naar v2**

| v1.0.0 | v2.0.0 (MDTO) | Kardinaliteit v2 |
|---|---|---|
| `vernietigingskandidaatId` | `vernietigingskandidaatId` (eigen begrip, ongewijzigd) | 1 |
| `bronId`, `bronIdNaam` | `identificatie` (`identificatieGegevens`: `identificatieKenmerk` + `identificatieBron`). Eén voorkomen is de technische sleutel van de bron, een ander het voor mensen herkenbare kenmerk. | 1..\* |
| `omschrijving` (titel) | `naam` | 1 |
| — | `omschrijving` (echte beschrijving) | 0..\* |
| — | `aggregatieniveau` (`begripGegevens`; uitsluitend de MDTO-lijst: Archief, Serie, Dossier, Archiefstuk) | 1 |
| `classificatieschema`, `classificatiesleutel`, `classificatieomschrijving` | `classificatie` (`begripGegevens`: `begripLabel`, `begripCode`, `begripBegrippenlijst` = schema) | 0..\* |
| `begindatum`, `einddatum` | `dekkingInTijd` (`dekkingInTijdType`, `dekkingInTijdBegindatum`, `dekkingInTijdEinddatum`) | 0..\* |
| `waardering` (`BEWAREN`/`VERNIETIGEN`) | `waardering` (`begripGegevens`, gesloten MDTO-lijst `B`/`V`/`N`) | 1 |
| `bewaartermijn`, `vernietigingsdatum` | `bewaartermijn` (`termijnTriggerStartLooptijd`, `termijnStartdatumLooptijd`, `termijnLooptijd`, `termijnEinddatum`) | 1 |
| `selectielijst`, `grondslag`, `resultaat` | `informatiecategorie` (`begripGegevens`: code en titel van de categorie; `begripBegrippenlijst` = de selectielijst, met `verwijzingIdentificatie` voor identificatie en versie) | 1 |
| `grondslagAfwijkend` | cockpituitbreiding `informatiecategorieAfwijking` (toelichting + verwijzing naar de afwijkende norm). De toegepaste categorie staat in `informatiecategorie`. | 0..1 |
| `relatieType`, `relatieId` | `isOnderdeelVan` (`verwijzingGegevens`) en/of `gerelateerdInformatieobject` (`gerelateerdInformatieobjectVerwijzing` + `gerelateerdInformatieobjectTypeRelatie`) | 0..\* |
| — | `archiefvormer` (`verwijzingGegevens`). Optioneel in de API; ontbreekt hij, dan geldt de archiefvormer die op de taakuitvoering is vastgepind (B-M3). | 0..\* |
| — | `activiteit` (`verwijzingGegevens`, bijv. zaaktype of proces) | 0..1 |
| `aantalObjecten`, `aantalBetrokkenen` | cockpituitbreiding, namen ongewijzigd | 0..1 |
| `toelichting` | cockpituitbreiding `toelichting` (selectie- of afwijkingstoelichting van de stekker) | 0..1 |
| `statusVernietigingskandidaat`, `uitvoeringsresultaat`, `foutcode`, `foutmelding`, `bronstatus` | **vervallen**: een bevroren selectie bevat geen uitvoeringsgegevens. Deze gegevens horen bij het uitvoeringsresultaat. | — |

**4.3 Overige schema's**
- `VernietigingBatch`: `objecten` wordt `vernietigingskandidaten`. Elk item is een `TeVernietigenKandidaat` met `vernietigingskandidaatId` + `identificatie` (1..\*), letterlijk zoals geselecteerd. Vervangt `TeVernietigenObject` met `bronId`, `relatieType` en `relatieId`.
- `Uitvoeringsresultaat`:
  - `vernietigingskandidaatId`, `identificatie`, `batchNummer`, `resultaat`, `foutcode`, `foutmelding`, `bronstatus`, `logReference` en `correlatieId` blijven;
  - nieuw is `event` (`eventGegevens`), dat bij `SUCCESS` verplicht is met `eventType` = `Vernietigen` (MDTO EventTypeLijst), `eventTijd` (tijdstip van vernietiging) en `eventResultaat`;
  - `eventVerantwoordelijkeActor` vult de cockpit in het dossier (de zorgdrager), niet de stekker;
  - optioneel `bronEventReferentie`: legt de stekker het event `Vernietigen` ook in de bron vast, dan verwijst hij hiernaar (B-M7);
  - specificatie (B-M2): voor elke kandidaat met `SUCCESS` levert de stekker via `GET /vernietigingen/{vernietigingId}/specificaties/{vernietigingskandidaatId}` een MDTO-XML-document. Daarin staat het vernietigde informatieobject met het event `Vernietigen` en, bij Archief, Serie en Dossier, een `bevatOnderdeel` per direct onderliggend informatieobject.
- `Vernietigingsuitvoering`:
  - `aantalBatches` wordt `verwerkteBatches`, omdat de naam nu twee betekenissen heeft;
  - `scope` (vrije tekst) vervalt;
  - nieuw is `vernietigingsmethode` (`begripGegevens`, lijst Cockpit-vernietigingsmethoden), verplicht vanaf `RUNNING`;
  - nieuw is `vernietigingsmethodeToelichting`, met de behandeling van back-ups, replica's, indexen en logbestanden en de termijn waarbinnen restanten zijn uitgedoofd (B-M4).
- Alle schema's: de verplichte velden worden **alleen in de OpenAPI-spec** vastgelegd. Informatiemodel, contract en leveranciersinstructie verwijzen ernaar.

### 5. Auditlog volgt MDTO-eventtypen

ADR-0003 wordt als volgt gewijzigd:

- `audit_event` en `configuratie_event` krijgen in plaats van `actie` de kolommen `event_type` (= `begripLabel`) en `event_type_begrippenlijst` (naam + versie van de lijst).
- Waar MDTO een eventtype kent, wordt dat gebruikt (*MDTO EventTypeLijst*). Anders komt het type uit *Cockpit-eventtypen* of *Cockpit-configuratie-eventtypen*.
- Het niveau blijft zichtbaar via `entiteit_type`, de besluitnemer via `rol`.
- De hashketen en de databasebescherming uit ADR-0003 blijven ongewijzigd. De hash dekt ook de nieuwe kolommen.

| ADR-0003 | `event_type` (begripLabel) | Begrippenlijst | `entiteit_type` / toelichting |
|---|---|---|---|
| TASK_CREATED | Creatie | MDTO EventTypeLijst | taakinstantie (= vernietigingsdossier) |
| SELECTION_REQUESTED | Selectie aangevraagd | Cockpit-eventtypen | taakinstantie |
| SELECTION_RETRY_REQUESTED | Selectie opnieuw aangevraagd | Cockpit-eventtypen | taakinstantie |
| SELECTION_COMPLETED | Import | MDTO EventTypeLijst | taakinstantie; details per selectie: stekker, versies, aantallen |
| OBJECT_INCLUDED | Kandidaat opgenomen | Cockpit-eventtypen | vernietigingskandidaat |
| OBJECT_EXCLUDED | Kandidaat uitgesloten | Cockpit-eventtypen | vernietigingskandidaat (met reden) |
| REVIEW_SUBMITTED | Voorgelegd | Cockpit-eventtypen | taakinstantie |
| APPROVAL_GRANTED (kandidaat en taak) | Accordering | MDTO EventTypeLijst | kandidaat of taakinstantie; `rol` = proceseigenaar of archivaris |
| APPROVAL_REJECTED (kandidaat en taak) | Retour | Cockpit-eventtypen | kandidaat of taakinstantie; `rol` |
| DESTRUCTION_APPROVED_BY_ARCHIVIST | Accordering, direct gevolgd door Bevriezing | MDTO EventTypeLijst (beide) | taakinstantie; `rol` = archivaris; Bevriezing (systeem) met `lijstHash` |
| DESTRUCTION_ORDERED_BY_RM | Vernietigingsopdracht | Cockpit-eventtypen | taakinstantie |
| EXECUTION_STARTED | Uitvoering gestart | Cockpit-eventtypen | taakinstantie |
| BATCH_STARTED | Batch aangeboden | Cockpit-eventtypen | batch |
| BATCH_COMPLETED | Batch verwerkt | Cockpit-eventtypen | batch |
| OBJECT_PROCESSED (SUCCESS) | Vernietigen | MDTO EventTypeLijst | vernietigingskandidaat; details: `eventTijd` van de stekker |
| OBJECT_FAILED | Niet vernietigd | Cockpit-eventtypen | vernietigingskandidaat; details: resultaat (`FAILED`/`SKIPPED`/`NOT_FOUND`/`CHANGED`) |
| EXECUTION_FAILED | Uitvoering mislukt | Cockpit-eventtypen | taakinstantie |
| EXECUTION_RETRY_REQUESTED | Uitvoering opnieuw aangevraagd | Cockpit-eventtypen | taakinstantie |
| EXECUTION_COMPLETED | Uitvoering afgerond | Cockpit-eventtypen | taakinstantie |
| CERTIFICATE_GENERATED | Creatie | MDTO EventTypeLijst | verklaring (id + versie) |
| ARCHIVING_REQUESTED | Archivering aangevraagd | Cockpit-eventtypen | taakinstantie |
| ARCHIVING_FAILED | Archivering mislukt | Cockpit-eventtypen | taakinstantie |
| TASK_COMPLETED | Export | MDTO EventTypeLijst | taakinstantie; dossier uitgevoerd naar het archiefsysteem. Uitdrukkelijk **geen** Overbrenging: het zorgdragerschap gaat niet over. |
| TASK_DELETED | Logisch verwijderd | Cockpit-eventtypen | taakinstantie; uitdrukkelijk **geen** Vernietigen |

Configuratie-events (*Cockpit-configuratie-eventtypen*):

| ADR-0003 | `event_type` |
|---|---|
| MASTER_DATA_IMPORTED | Stamgegevens geïmporteerd |
| TASK_DEFINITION_CREATED | Taakdefinitie aangemaakt |
| TASK_DEFINITION_DELETED | Taakdefinitie verwijderd |
| USER_LINKED | Gebruiker gekoppeld |
| CONNECTOR_CREATED | Stekker aangemaakt |
| CONNECTOR_UPDATED | Stekker gewijzigd |
| CONNECTOR_DEACTIVATED | Stekker gedeactiveerd |
| CONNECTOR_ACTIVATED | Stekker geactiveerd |
| CONNECTOR_DELETED | Stekker verwijderd |

De UI toont `event_type` zonder vertaling. Daarmee vervalt de weergavetabel uit ADR-0003 (Gevolgen).

### 6. Datamodel en code

- Kolom- en veldnamen voor MDTO-gegevens volgen het MDTO-pad:
  - in de database snake_case, bijvoorbeeld `naam`, `waardering_begrip_code`, `termijn_einddatum`, `termijn_trigger_start_looptijd`, `informatiecategorie_begrip_code`;
  - in TypeScript camelCase, gelijk aan de API.
- Gegevensgroepen die vaker kunnen voorkomen (`identificatie`, `classificatie`, `dekkingInTijd`, `gerelateerdInformatieobject`) worden als JSONB opgeslagen, met MDTO-sleutels.
- Waarden waarop gezocht of gesorteerd wordt, staan daarnaast in eigen kolommen: `termijn_einddatum`, `informatiecategorie_begrip_code`, `waardering_begrip_code` en het eerste identificatiekenmerk.
- **Bestaande** velden worden hernoemd. Er komt geen alias- of compatibiliteitslaag.

### 7. Verklaring en archiefpakket

- Het archiefpakket wordt **MDTO-XML 1.0.1**: informatieobjecten voor dossier, vernietigingslijst, besluiten, verklaring en auditlog, en bestanden met `omvang`, `bestandsformaat` (PRONOM), `checksum` (algoritme, waarde, datum) en `isRepresentatieVan`. Het eigen `manifest.json` vervalt (besluit 2026-10-09).
- Indeling van het pakket (één MDTO-document per object, naast het bestand):

  | Pad | Inhoud |
  |---|---|
  | `dossier.mdto.xml` | informatieobject Dossier, waardering B, `bevatOnderdeel` naar de vier onderdelen; als laatste geschreven. Zijn SHA-256 is de referentie naar het pakket (`archivering.dossier_sha256`). |
  | `verklaring.mdto.xml`, `vernietigingslijst.mdto.xml`, `besluitvorming.mdto.xml`, `auditlog.mdto.xml` | informatieobjecten Archiefstuk (`isOnderdeelVan` het dossier, `heeftRepresentatie` naar het bestand). Besluitvorming heeft geen bestand; de besluiten staan als events (Voorgelegd, Accordering, Retour, Bevriezing, Vernietigingsopdracht). |
  | `verklaring.pdf`, `bijlage.csv`, `auditlog.json` + `<bestand>.mdto.xml` | de bestanden met hun MDTO-bestandsbeschrijving (PDF/A-2b fmt/477, CSV x-fmt/18, JSON fmt/817; SHA-256). |
  | `kandidaten/<id>.mdto.xml` | per aangeboden kandidaat het informatieobject met het event Vernietigen (of "Niet vernietigd" met de uitkomst) (B-M6). |
  | `specificaties/<id>.xml` | per vernietigde kandidaat de specificatie van de stekker (B-M2), gecontroleerd op de SHA-256 bij ontvangst. |

  De SHA-256 van elk bestand in `kandidaten/` en `specificaties/` staat in de CSV-bijlage (`mdtoXmlSha256`, `specificatieSha256`); de CSV zelf heeft een bestandsbeschrijving met checksum. `<id>` is het cockpit-id van de kandidaat, omdat het `vernietigingskandidaatId` alleen binnen een selectie uniek is.
- Alle informatieobjecten in het dossier krijgen `beperkingGebruik` *Openbaarheidsbeperking* met als nadere beschrijving dat het dossier persoonsgegevens bevat.
- De verklaring en de CSV-bijlage gebruiken MDTO-namen in kolomkoppen en teksten.
- De verklaring vermeldt per stekker de wijze van vernietiging (methode en toelichting) en per vernietigde kandidaat het tijdstip (`eventTijd`). Waar van toepassing verwijst ze naar de specificatie van de onderliggende informatieobjecten. Alleen `SUCCESS` telt als vernietigd; de andere uitkomsten worden apart gespecificeerd.
- Waardering, bijlage en dossiervernietiging: zie §9 (B-M5, B-M6, B-M8).

### 8. UI

Zichtbare labels voor MDTO-gegevens volgen het MDTO-label. Voorbeelden: *Waardering: Tijdelijk te bewaren*, *Informatiecategorie*, *Bewaartermijn*, *Archiefvormer*, *Naam*. De labels worden vastgelegd in `ui-spec/content/labels.md`.

De indeling en vormgeving van de schermen veranderen niet door deze ADR. Wijzigingen daarin worden apart voorgelegd.

### 9. Besluiten uit de MDTO-analyse (B-M1 t/m B-M8, 2026-10-08)

| ID | Besluit |
|---|---|
| **B-M1** Waardering B of N in een vernietigingsselectie | De cockpit importeert de kandidaat, **sluit hem automatisch uit** met uitsluitreden *Waardering niet V* (lijst Cockpit-uitsluitredenen) en toont een waarschuwing. De recordmanager kan zo'n kandidaat niet opnemen. Er wordt niets stil weggelaten. De uitsluiting wordt gelogd als *Kandidaat uitgesloten* met actor systeem. |
| **B-M2** Kunstmatige groeperingen | **Niet toegestaan.** Een kandidaat is altijd een MDTO-aggregatie: Archief, Serie, Dossier of Archiefstuk. Er komt geen eigen aggregatieniveau. Bij Archief, Serie en Dossier levert de stekker bij `SUCCESS` een specificatie van de vernietigde onderliggende informatieobjecten (zie §4.3). Daarmee voldoet de verklaring aan de specificatie-eis van art. 8 Archiefbesluit. Dit wijzigt ADR-0001: "dezelfde selectiekenmerken" wordt "één MDTO-aggregatie". |
| **B-M3** Archiefvormer | Staat op het **profiel van de proceseigenaar** (MDTO `verwijzingGegevens`: naam, optioneel identificatie zoals OIN of TOOI) en komt mee in de stamgegevens-import (gewijzigd 2026-10-09; eerder: op de taakdefinitie). Een taakdefinitie vraagt een proceseigenaar met archiefvormer. Bij het aanmaken van een taakuitvoering wordt de archiefvormer **vastgepind** op de taak; latere profielwijzigingen werken alleen door in nieuwe uitvoeringen. De import kan de archiefvormer niet wissen bij een proceseigenaar van een actieve taakdefinitie. Een stekker mag per kandidaat een afwijkende `archiefvormer` meegeven, bijvoorbeeld bij een gemeenschappelijke regeling; die gaat dan voor. |
| **B-M4** Wijze van vernietiging | **Per vernietigingsuitvoering**: methode als begrip plus een toelichting over restanten (§4.3). Het tijdstip wordt per kandidaat vastgelegd via `event.eventTijd`. |
| **B-M5** Waardering van het cockpitdossier | Het vernietigingsdossier en al zijn onderdelen (vernietigingslijst, besluiten, verklaring, auditlog, bijlagen) krijgen vast de waardering **B – Blijvend te bewaren**. Er komt geen termijn. Dit is geen configuratie per organisatie. |
| **B-M6** Bijlage in het archiefpakket | **MDTO-XML per kandidaat** (informatieobject met identificatie, waardering, bewaartermijn, informatiecategorie en event `Vernietigen` of het resultaat) **plus een CSV** met MDTO-kolomnamen voor menselijke raadpleging. Beide zijn bestanden met checksum in het pakket. |
| **B-M7** Event in de bron (US-036) | **Optioneel.** Kan de bron het (bijv. een metadata-grafsteen of archiefstatus), dan legt de stekker het event `Vernietigen` daar vast en geeft hij `bronEventReferentie` terug. Dat is geen acceptatie-eis. |
| **B-M8** Vernietiging van cockpitdossiers | Een **eigen ADR** (ADR-0006). Uitgangspunt: het blijvend te bewaren dossier (B-M5) staat na archivering in het archiefsysteem. De cockpitkopie is dan een werkkopie die gecontroleerd kan worden verwijderd. Dat gebeurt automatisch, na geslaagde en opnieuw geverifieerde archivering en een instelbare termijn (standaard 12 maanden). Er blijft een grafsteenrecord achter (dossier-id, laatste audithash, archiveringsreferentie, dossier-hash: SHA-256 van `dossier.mdto.xml`), zodat verificatie mogelijk blijft. |

Gevolgen van B-M5 die in ADR-0006 en het privacybeleid moeten landen:
- Kandidaatgegevens in het dossier (naam, identificaties) blijven in het archiefsysteem permanent bewaard.
- `beperkingGebruik` van de dossieronderdelen moet daarom expliciet worden ingevuld (openbaarheidsbeperking voor persoonsgegevens). Een organisatie kan dat niet uitzetten.
- Het archiefpakket bevat geen ruwe stekkerpayload (`bron`-JSON), alleen de MDTO-gegevens.

## Overwegingen

- **Standaardisatie.** MDTO is de door de Standaardisatieraad geaccordeerde standaard van het Nationaal Archief voor duurzaam toegankelijke overheidsinformatie en volgt TMLO op. Archiefsystemen en e-depots verwachten MDTO. Met eigen namen ontstaat bij elke koppeling een vertaalslag die informatie kan verliezen.
- **Controleerbaarheid zonder interpretatie** (`architectuur-cockpit.md` §3). Een gecodeerd begrip met een begrippenlijst en een volledige termijn (trigger, startdatum, looptijd, einddatum) maakt controle mogelijk. Vrije strings maken dat niet.
- **Scheiding normatief en operationeel blijft intact.** De stekker past de selectielijst toe en levert het resultaat in MDTO-termen. De cockpit legt vast, beoordeelt en controleert contractinvarianten.
- **Eén taal.** Hetzelfde woord betekent in documentatie, API, database, auditlog, verklaring en UI hetzelfde. ADR-0003 koos Engels "omdat de spec Engelstalig is"; met MDTO als norm is die reden vervallen.
- **Moment.** Er zijn nog geen productiestekkers of -data. Een directe major is nu goedkoper dan een overgangsperiode met twee contracten.

## Alternatieven

- **Alleen een mapping** (eigen namen behouden, MDTO-mapping documenteren). Verworpen: MDTO is dan niet leidend en de vertaalslag blijft in elke laag terugkomen.
- **v1.x met parallelle MDTO-velden, schoon in v2.0.** Verworpen: dit levert twee contracten tegelijk op, terwijl er geen bestaande stekkers in productie zijn.
- **Auditlog ongewijzigd laten en de MDTO-eventgeschiedenis afleiden.** Verworpen: dan blijven er twee namensets naast elkaar bestaan, met een mappingtabel die onderhouden moet worden.
- **Ook eigen enumwaarden vernederlandsen** (`SUCCESS` → `GESLAAGD` enz.). Niet gekozen: buiten MDTO is er geen norm die dat vraagt, en het vergroot de wijziging zonder winst.

## Gevolgen

**Architectuur en documenten** (bijwerken in de architectuurrepo):
- `architectuur/terminologie.md`: MDTO-definities voor informatieobject, bestand, waardering, bewaartermijn, informatiecategorie, archiefvormer, event en aggregatieniveau. *Vernietiging* volgt de MDTO-definitie van *Vernietigen*: blijvend ontoegankelijk maken.
- `architectuur/architectuur.md` §11.2: MDTO als kader.
- `architectuur/architectuur-cockpit.md`, `architectuur/architectuur-stekker.md`, `architectuur/architectuur-techniek.md` en `architectuur/sequence-diagrammen.md`.
- `designrules/api/*`: informatiemodel, OpenAPI-spec v2.0.0, contract, leveranciersinstructie, checklist en FAQ.
- `ui-spec/state/audit-event-model.md`, `ui-spec/state/task-state-machine.md` (audit-sectie), `ui-spec/content/labels.md` en `ui-spec/api-mapping/*`.
- `security/compliance‑mapping.md`: MDTO, Archiefbesluit art. 8, selectielijst.
- Nieuw: `designrules/begrippenlijsten/` met Cockpit-eventtypen, Cockpit-configuratie-eventtypen, Cockpit-vernietigingsmethoden en Cockpit-uitsluitredenen.
- ADR-0001 blijft gelden voor de kandidaat als uitwisseleenheid. De definitie wordt door deze ADR aangescherpt: een kandidaat is precies één MDTO-aggregatie (B-M2). ADR-0003 §1 wordt door §5 van deze ADR gewijzigd. ADR-0004 wordt opgenomen in spec v2.0.0.

**Implementaties:**
- Cockpit:
  - de stekkerclient wordt opnieuw gegenereerd tegen v2.0.0 (`packages/stekker-client`);
  - `packages/api-contract`, de Prisma-migraties (hernoemen), de import, de beoordelings- en accorderingsweergave, de verklaring en de CSV, het archiefpakket (MDTO-XML) en de UI-labels gaan mee.
- Teststekker: moet naar v2.0.0.
- Auditlog: de hashinput verandert. Bestaande audit- en configuratie-events kunnen niet worden herschreven, omdat dat de keten breekt. De migratie vereist daarom, net als bij ADR-0003, **lege** `audit_event`- en `configuratie_event`-tabellen. Lokale, E2E- en acceptatieomgevingen moeten opnieuw worden opgebouwd; voor acceptatie gebeurt dat na akkoord.

**Beheer en governance:**
- De eigen begrippenlijsten worden beheerd en geversioneerd als onderdeel van de architectuur. Een nieuw eventtype komt er alleen via een wijziging van deze lijsten of van deze ADR.
- Een volgende MDTO-versie wordt beoordeeld via een wijziging van deze ADR.

**Risico's en aandachtspunten:**
- Verbositeit: MDTO-structuren (`begripGegevens` met begrippenlijst) maken payloads groter. Dat is acceptabel bij paginering tot 500 kandidaten.
- Leveranciers moeten de bewaartermijn volledig aanleveren (trigger en startdatum). Dat moet als eis in de leveranciersinstructie en de checklist komen.
- MDTO-labels zijn voor eindgebruikers soms vakjargon (*Dekking in tijd*). Een helptekst mag; het label zelf blijft het MDTO-label.
