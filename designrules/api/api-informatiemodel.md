# API-informatiemodel Stekker API (v2)

## 1. Doel

Dit document beschrijft het informatiemodel van de Stekker API, versie 2.

Het informatiemodel definieert de gegevensobjecten die tussen de Vernietigingscockpit en de Stekker worden uitgewisseld, inclusief de betekenis van deze gegevens en de onderlinge relaties.

Dit document vormt samen met:

- `architectuur.md`
- `architectuur-stekker.md`
- `stekker-openapi-contract.md`
- `designrules/begrippenlijsten/`

de basis voor de OpenAPI-specificatie (`stekker-openapi-spec.yaml`, v2.0.0).

Het informatiemodel beschrijft uitsluitend de uitgewisselde gegevens. Procesgedrag, endpoints, statuscodes en interactiepatronen staan in het begeleidend contract. **Welke velden verplicht zijn, staat uitsluitend in de OpenAPI-specificatie**; dit document en de andere documenten verwijzen daarnaar.

---

# 2. Uitgangspunten

## 2.1 MDTO is leidend

MDTO (Metagegevens voor duurzaam toegankelijke overheidsinformatie, Nationaal Archief) is leidend voor benaming, begrippen en structuur (ADR-0005). Referentieversie: **MDTO 1.0 / MDTO-XML 1.0.1**.

Dat betekent:

- gegevens over informatieobjecten gebruiken de **MDTO-attribuutnamen** als veldnaam (bijvoorbeeld `naam`, `waardering`, `bewaartermijn`, `informatiecategorie`);
- gegevensgroepen volgen de **MDTO-structuur**: `identificatieGegevens`, `verwijzingGegevens`, `begripGegevens`, `termijnGegevens`, `dekkingInTijdGegevens`, `gerelateerdInformatieobjectGegevens`, `eventGegevens`;
- begripvelden krijgen hun waarde uit een **begrippenlijst**: een MDTO-lijst of een eigen lijst uit `designrules/begrippenlijsten/`. De lijst staat in `begripBegrippenlijst`;
- begrippen die MDTO niet kent (selectie, vernietigingskandidaat, vernietigingsuitvoering, batch, uitvoeringsresultaat) houden hun eigen naam en zijn in MDTO-termen gedefinieerd;
- gegevens zonder MDTO-attribuut zijn **cockpituitbreidingen** en als zodanig gemarkeerd.

## 2.2 Verantwoordelijkheden

Binnen het Vernietigingscockpit-ecosysteem geldt een strikte scheiding tussen normatieve en operationele verantwoordelijkheden.

De Vernietigingscockpit is verantwoordelijk voor regie, beoordeling, besluitvorming, workflow, accordering, het vernietigingsdossier, de audittrail, verantwoording en de verklaring van vernietiging.

De Stekker is verantwoordelijk voor selectie, de operationele toepassing van de selectielijst, het berekenen van bewaartermijnen, de technische uitvoering, de communicatie met de Cockpit via de gestandaardiseerde API en het terugkoppelen van resultaten. **De Stekker levert de MDTO-metagegevens van de kandidaten**, zoals die in de bron of door de toepassing van de selectielijst bekend zijn.

De Stekker bepaalt welke kandidaten in aanmerking komen. De Cockpit bepaalt niet welke kandidaten geselecteerd worden, maar faciliteert de beoordeling en besluitvorming hierover.

Cockpit-eigen gegevens, zoals taak, workflowstatus, beoordelingen, accorderingen, uitsluitingen, audittrail, vernietigingsdossier, de verantwoordelijke actor (zorgdrager) en de verklaring van vernietiging, maken geen deel uit van dit informatiemodel.

---

# 3. Terminologie

## 3.1 Vernietigingskandidaat

Een vernietigingskandidaat is het primaire uitwisselobject tussen Cockpit en Stekker (ADR-0001).

Een vernietigingskandidaat is **precies één MDTO-informatieobject** op aggregatieniveau **Archief**, **Serie**, **Dossier** of **Archiefstuk** (ADR-0005, B-M2). Kunstmatige groeperingen, zoals "alle meldingen van 2019 met categorie X" zonder dat dit een serie of dossier is, zijn niet toegestaan.

De kandidaat is de eenheid voor selectie, beoordeling, besluitvorming, vrijgave, uitvoering en resultaatterugkoppeling. De onderliggende informatieobjecten van een archief, serie of dossier worden niet afzonderlijk uitgewisseld. Na vernietiging specificeert de Stekker ze wel in de MDTO-specificatie (§5.5).

## 3.2 Identificatie

Elke kandidaat heeft:

- `vernietigingskandidaatId`: stabiele identificatie van de kandidaat binnen de Stekker, over het hele proces (eigen begrip);
- `identificatie` (MDTO, 1..\*): één of meer paren `identificatieKenmerk` + `identificatieBron`, minimaal de **technische sleutel** waarmee de Stekker het object in de bron terugvindt, en bij voorkeur het **voor mensen herkenbare kenmerk**, zoals een zaaknummer of dossiernummer.

De `identificatieBron` geeft de context waarbinnen het kenmerk uniek is, zoals de bronapplicatie of de nummering van de organisatie. Bedient een Stekker meerdere bronnen, dan onderscheidt de `identificatieBron` die.

De Cockpit stuurt bij vernietiging de `identificatie` **letterlijk** terug zoals geselecteerd. In v1 heette de technische sleutel `bronId` en het herkenbare kenmerk `bronIdNaam`.

---

# 4. Domeinmodel

```text
Selectie
 └── Vernietigingskandidaat [0..*]        = één MDTO-informatieobject
       └── bevatOnderdeel → Informatieobject [0..*]   (alleen in de specificatie)

Selectie
 └── Vernietigingsuitvoering [0..*]

Vernietigingsuitvoering
 ├── Batch [1..*]
 │     └── TeVernietigenKandidaat [1..*]
 └── Uitvoeringsresultaat [0..*]           (precies één per aangeboden kandidaat)
       └── event Vernietigen (bij SUCCESS) + specificatie (MDTO-XML)
```

---

# 5. Objecten

## 5.1 Selectie

Een selectie is een bevroren momentopname van vernietigingskandidaten. Ze bevat alle kandidaten die op de peildatum voldoen aan de toegepaste selectieregels: waardering V en een `bewaartermijn.termijnEinddatum` op of vóór de peildatum. Een selectie verandert niet meer nadat ze gereed (`READY`) is.

| Veld | Omschrijving |
|--------|--------|
| selectieId | Unieke identificatie van de selectie |
| peildatum | Datum waarop de selectieregels zijn toegepast |
| selectietijdstip | Datum en tijd waarop de selectie is uitgevoerd |
| status | `IDLE`, `RUNNING`, `READY`, `FAILED` |
| totaalKandidaten | Aantal vernietigingskandidaten |
| totaalObjecten | Totaal aantal onderliggende informatieobjecten |
| totaalBetrokkenen | Totaal aantal unieke betrokkenen |
| stekkerNaam | Naam van de Stekker |
| stekkerOmschrijving | Beschrijving van de ontsloten bronnen en applicaties |
| stekkerversie | Versie van de Stekker |
| configuratieversie | Gebruikte configuratieversie |
| apiVersie | Versie van de API |
| aantalWaarschuwingen | Aantal waarschuwingen tijdens selectie |
| aantalFouten | Aantal fouten tijdens selectie |

## 5.2 Vernietigingskandidaat (MDTO-profiel)

| Veld | MDTO | Omschrijving |
|--------|--------|--------|
| vernietigingskandidaatId | – (eigen begrip) | Stabiele identificatie van de kandidaat |
| identificatie | identificatie (`identificatieGegevens`, 1..\*) | Technische sleutel en herkenbaar kenmerk, elk met bron (§3.2) |
| naam | naam | Betekenisvolle aanduiding, bijvoorbeeld de titel van het dossier |
| omschrijving | omschrijving (0..\*) | Omschrijving van de inhoud |
| aggregatieniveau | aggregatieniveau (`begripGegevens`) | Archief, Serie, Dossier of Archiefstuk (alleen de MDTO-lijst) |
| classificatie | classificatie (`begripGegevens`, 0..\*) | Classificatie volgens een classificatieschema (ZTC, BAC, ordeningsplan); `begripBegrippenlijst` = het schema |
| dekkingInTijd | dekkingInTijd (`dekkingInTijdGegevens`, 0..\*) | Periode waarop de inhoud betrekking heeft; type uit Cockpit-dekkingInTijdtypen |
| waardering | waardering (`begripGegevens`) | Uit de gesloten MDTO-lijst: B (Blijvend te bewaren), V (Tijdelijk te bewaren), N (Nader te bepalen) |
| bewaartermijn | bewaartermijn (`termijnGegevens`) | `termijnTriggerStartLooptijd` (Cockpit-termijntriggers), `termijnStartdatumLooptijd`, `termijnLooptijd` (ISO 8601-duur) en `termijnEinddatum` (datum waarop vernietiging mag plaatsvinden) |
| informatiecategorie | informatiecategorie (`begripGegevens`) | Categorie uit de vastgestelde selectielijst of hotspotlijst. `begripCode` = codering, `begripLabel` = titel, `begripBegrippenlijst` = de selectielijst met identificatie en versie |
| informatiecategorieAfwijking | – (cockpituitbreiding) | Toelichting en norm als categorie of termijn afwijkt van de standaardselectielijst |
| isOnderdeelVan | isOnderdeelVan (`verwijzingGegevens`, 0..\*) | Direct bovenliggende aggregatie |
| gerelateerdInformatieobject | gerelateerdInformatieobject (0..\*) | Relatie met een ander informatieobject; type uit de MDTO-lijst Relatietypen (informatieobject) |
| archiefvormer | archiefvormer (`verwijzingGegevens`, 0..\*) | Alleen bij een afwijkende archiefvormer; anders geldt die van de taakuitvoering (profiel van de proceseigenaar, ADR-0005, B-M3) |
| activiteit | activiteit (`verwijzingGegevens`) | Bedrijfsactiviteit, zoals het proces of zaaktype |
| aantalObjecten | – (cockpituitbreiding) | Aantal onderliggende informatieobjecten |
| aantalBetrokkenen | – (cockpituitbreiding) | Aantal unieke betrokkenen |
| toelichting | – (cockpituitbreiding) | Toelichting van de Stekker op selectie of afwijkingen |

Een kandidaat bevat **geen** uitvoeringsgegevens (resultaat, foutcode, bronstatus): de selectie is bevroren.

**Controleerbaarheid.** Met trigger, startdatum en looptijd kan de Cockpit zonder interpretatie controleren dat einddatum = startdatum + looptijd, en dat de einddatum op of vóór de peildatum ligt.

**Waardering B of N.** Een Stekker hoort zulke kandidaten niet te leveren; onzekerheden komen in `aantalWaarschuwingen`. Levert hij ze toch, dan sluit de Cockpit ze automatisch uit met reden *Waardering niet V* (ADR-0005, B-M1).

## 5.3 Vernietigingsuitvoering

Een vernietigingsuitvoering is een concrete uitvoeringsactie op basis van één selectie. Een selectie kan tot meerdere uitvoeringen leiden.

| Veld | Omschrijving |
|--------|--------|
| vernietigingId | Unieke identificatie van de uitvoering |
| selectieId | Onderliggende selectie |
| cockpitTaakId | Cockpit-taak waaruit de uitvoering voortkomt |
| vernietigingsdossierId | Vernietigingsdossier in de Cockpit |
| besluitReferentie | Besluit of vrijgave op basis waarvan de uitvoering is gestart |
| status | `IDLE`, `RUNNING`, `COMPLETED`, `PARTIAL`, `FAILED` |
| starttijd, eindtijd | Begin en einde van de uitvoering |
| totaalKandidaten, totaalObjecten | Aangeboden kandidaten en onderliggende objecten |
| totaalBatches | Bij vrijgave aangekondigd aantal batches |
| ontvangenBatches | Door de Stekker ontvangen batches |
| verwerkteBatches | Verwerkte batches (in v1: `aantalBatches`) |
| succesvolVernietigd, mislukt, overgeslagen, gewijzigd, nietGevonden | Aantallen per resultaat |
| stekkerNaam, stekkerOmschrijving, stekkerversie, configuratieversie | Context van de uitvoering |
| vernietigingsmethode | Wijze van vernietiging (`begripGegevens`, lijst Cockpit-vernietigingsmethoden). Verplicht vanaf `RUNNING` (Archiefbesluit 1995 art. 8, ADR-0005 B-M4) |
| vernietigingsmethodeToelichting | Behandeling van back-ups, replica's, indexen en logbestanden, en de termijn waarbinnen restanten zijn uitgedoofd |
| aantalWaarschuwingen, aantalFouten | Waarschuwingen en fouten tijdens uitvoering |

Een uitvoering wordt aangemaakt voordat technische vernietiging start. De Cockpit levert eerst batches aan en geeft de uitvoering daarna expliciet vrij met het aantal aangeleverde batches en kandidaten. Pas na die vrijgave mag de Stekker vernietigen.

## 5.4 Batch en te vernietigen kandidaat

Een batch is een technische groepering binnen één uitvoering; geen apart besluit.

| Veld | Omschrijving |
|--------|--------|
| batchNummer | Nummer van de batch (≥ 1) |
| vernietigingskandidaten | Lijst `TeVernietigenKandidaat`: per kandidaat `vernietigingskandidaatId` + `identificatie`, letterlijk zoals geselecteerd |

## 5.5 Uitvoeringsresultaat

Precies één eindresultaat per aangeboden kandidaat.

| Veld | MDTO | Omschrijving |
|--------|--------|--------|
| vernietigingskandidaatId | – | De kandidaat |
| identificatie | identificatie | Zoals aangeboden |
| batchNummer | – | Batch waarin de kandidaat is aangeboden |
| resultaat | – | `SUCCESS`, `FAILED`, `SKIPPED`, `NOT_FOUND`, `CHANGED` |
| event | event (`eventGegevens`) | Bij `SUCCESS` verplicht: `eventType` *Vernietigen* (MDTO EventTypeLijst), `eventTijd` (tijdstip van vernietiging) en `eventResultaat`. `eventVerantwoordelijkeActor` vult de Cockpit (de zorgdrager) |
| bronEventReferentie | – (cockpituitbreiding) | Optioneel: verwijzing naar het event *Vernietigen* dat de Stekker ook in de bron heeft vastgelegd (ADR-0005, B-M7) |
| foutcode, foutmelding | – | Bij een ander resultaat dan `SUCCESS` |
| bronstatus | – | Geconstateerde afwijking of wijziging in de bron |
| logReference, correlatieId | – | Technische herleidbaarheid |
| toelichting | – | Aanvullende toelichting |

| Resultaat | Betekenis | Vernietigd? |
|--------|--------|--------|
| `SUCCESS` | Het informatieobject (met al zijn onderdelen en bestanden) is vernietigd: blijvend ontoegankelijk gemaakt | Ja |
| `FAILED` | Vernietiging geprobeerd, maar mislukt | Nee |
| `SKIPPED` | Vernietiging niet uitgevoerd | Nee |
| `NOT_FOUND` | Het object is niet gevonden. Dat is géén bewijs van vernietiging door dit proces | Nee |
| `CHANGED` | Het object is gewijzigd sinds selectie en daarom niet vernietigd | Nee |

**Specificatie.** Voor elke kandidaat met `SUCCESS` levert de Stekker een MDTO-XML-document (MDTO-XML 1.0.1). Daarin staan het vernietigde informatieobject (met identificatie, naam, aggregatieniveau, waardering, bewaartermijn, informatiecategorie, archiefvormer en beperkingGebruik), het event *Vernietigen* en, bij Archief, Serie en Dossier, een `bevatOnderdeel` per direct onderliggend informatieobject. Zo is de specificatie van de vernietigde archiefbescheiden (Archiefbesluit art. 8) ook bij aggregaties volledig.

---

# 6. Relaties

```text
Selectie [1] ── Vernietigingskandidaat [0..*]
Vernietigingskandidaat [1] ── bevatOnderdeel Informatieobject [0..*]   (alleen in de specificatie)
Selectie [1] ── Vernietigingsuitvoering [0..*]
Vernietigingsuitvoering [1] ── Batch [1..*] ── TeVernietigenKandidaat [1..*]
Vernietigingsuitvoering [1] ── Uitvoeringsresultaat [0..*]   (precies één per aangeboden kandidaat)
```

---

# 7. Begrippenlijsten

| Veld | Begrippenlijst | Type |
|--------|--------|--------|
| aggregatieniveau | MDTO Aggregatieniveaus (alleen Archief, Serie, Dossier, Archiefstuk) | Open, hier beperkt |
| waardering | MDTO Waarderingen | Gesloten |
| classificatie | Het classificatieschema van de bron | – |
| informatiecategorie | De vastgestelde selectielijst of hotspotlijst | – |
| dekkingInTijd.dekkingInTijdType | Cockpit-dekkingInTijdtypen | Open |
| bewaartermijn.termijnTriggerStartLooptijd | Cockpit-termijntriggers (ZGW-afleidingswijzen) | Open |
| gerelateerdInformatieobjectTypeRelatie | MDTO Relatietypen (informatieobject) | Open |
| event.eventType | MDTO EventTypeLijst (`Vernietigen`) | Open |
| vernietigingsmethode | Cockpit-vernietigingsmethoden | Open |

---

# 8. Gebruik in de OpenAPI-specificatie

De objecten worden vertaald naar OpenAPI-schema's in `stekker-openapi-spec.yaml` (v2.0.0). **De verplichte velden staan uitsluitend daar.** Ze vormen de basis voor requests, responses, validatieregels en contracttesten.

Ontbrekende optionele velden mogen niet leiden tot een andere interpretatie van status, resultaat of verantwoordelijkheid.

# 9. Wijzigingen ten opzichte van v1

| v1 | v2 |
|--------|--------|
| `bronId`, `bronIdNaam` | `identificatie[]` (kenmerk + bron) |
| `omschrijving` (titel) | `naam`; `omschrijving` is de inhoudsbeschrijving |
| `classificatieschema/-sleutel/-omschrijving` | `classificatie[]` (`begripGegevens`) |
| `selectielijst`, `grondslag`, `resultaat` | `informatiecategorie` (`begripGegevens`, selectielijst als begrippenlijst) |
| `grondslagAfwijkend` | `informatiecategorieAfwijking` |
| `waardering` `BEWAREN`/`VERNIETIGEN` | `waardering` B/V/N (`begripGegevens`) |
| `bewaartermijn` (string), `vernietigingsdatum` | `bewaartermijn` (`termijnGegevens`) |
| `begindatum`, `einddatum` | `dekkingInTijd[]` |
| `relatieType`, `relatieId` | `isOnderdeelVan[]`, `gerelateerdInformatieobject[]` |
| uitvoeringsvelden in de kandidaat | vervallen (alleen in `Uitvoeringsresultaat`) |
| batch `objecten` met `bronId` | batch `vernietigingskandidaten` met `identificatie` |
| `aantalBatches` (uitvoering) | `verwerkteBatches` |
| `scope` (start vernietiging) | vervallen |
| – | `aggregatieniveau`, `archiefvormer`, `activiteit`, `event`, `bronEventReferentie`, `vernietigingsmethode`(`Toelichting`), specificatie-endpoint |
