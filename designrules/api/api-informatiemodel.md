# API-informatiemodel Stekker API

## 1. Doel

Dit document beschrijft het informatiemodel van de Stekker API.

Het informatiemodel definieert de gegevensobjecten die tussen de Vernietigingscockpit en de Stekker worden uitgewisseld, inclusief de betekenis van deze gegevens en de onderlinge relaties.

Dit document vormt samen met:

- architectuur.md
- architectuur-stekker.md
- stekker-api-contract.md

de basis voor de OpenAPI-specificatie.

Het informatiemodel beschrijft uitsluitend de uitgewisselde gegevens. Procesgedrag, endpoints, statuscodes en interactiepatronen zijn beschreven in het API-contract.

---

# 2. Uitgangspunten

Binnen het Vernietigingscockpit ecosysteem geldt een strikte scheiding tussen normatieve en operationele verantwoordelijkheden.

De Vernietigingscockpit is verantwoordelijk voor:

- regie;
- beoordeling;
- besluitvorming;
- workflow;
- accordering;
- vernietigingsdossier;
- audittrail;
- verantwoording;
- verklaring van vernietiging.

De Stekker is verantwoordelijk voor:

- selectie;
- operationele interpretatie van selectieregels;
- berekening van bewaartermijnen;
- technische uitvoering;
- communicatie met de Cockpit via de gestandaardiseerde API;
- terugkoppeling van resultaten.

De Stekker bepaalt welke kandidaten in aanmerking komen voor verdere verwerking. De Cockpit bepaalt niet welke kandidaten geselecteerd worden, maar faciliteert de beoordeling en besluitvorming hierover.

Gegevens die door een Stekker worden geleverd kunnen in de Cockpit worden getoond en in het vernietigingsdossier worden opgenomen, zonder dat het eigenaarschap van die gegevens verschuift.

Cockpit-eigen metadata, zoals taaknummer, taaksjabloon, workflowstatus, beoordelingen, accorderingen, uitzonderingen, audittrail, vernietigingsdossier-id, exportreferentie en verklaring van vernietiging, maken geen onderdeel uit van dit Stekker API-informatiemodel. Deze gegevens worden door de Cockpit beheerd en horen bij de regie-, dossier- en verantwoordingsfunctie.

Het bronsysteem blijft verantwoordelijk voor het beheer van de onderliggende informatieobjecten en de feitelijke verwijdering van gegevens, tenzij een Stekker deze technische verwijdering voor een specifieke bron zelf uitvoert.

---

# 3. Terminologie

## 3.1 Vernietigingskandidaat

Een vernietigingskandidaat is het primaire uitwisselobject tussen de Vernietigingscockpit en de Stekker.

Een vernietigingskandidaat vertegenwoordigt één of meer onderliggende informatieobjecten die dezelfde selectiekenmerken delen.

Deze groepering maakt het mogelijk grote aantallen informatieobjecten beheersbaar te beoordelen en verwerken.

Een vernietigingskandidaat vormt de eenheid voor:

- selectie;
- beoordeling;
- besluitvorming;
- vrijgave;
- uitvoering;
- resultaatterugkoppeling.

Onderliggende informatieobjecten hoeven niet afzonderlijk tussen Cockpit en Stekker te worden uitgewisseld.

Hoewel de huidige toepassing gericht is op vernietiging, is het model bewust generiek opgezet zodat toekomstige verwerkingsvormen, zoals overbrenging, ondersteund kunnen worden zonder wijziging van het informatiemodel.

---

# 4. Domeinmodel

```text
Selectie
 └── Vernietigingskandidaat [0..*]

Vernietigingskandidaat
 └── vertegenwoordigt Informatieobject [1..*]

Selectie
 └── Vernietigingsuitvoering [0..*]

Vernietigingsuitvoering
 └── Uitvoeringsresultaat [0..*]
```

---

# 5. Objecten

## 5.1 Selectie

Een selectie is een bevroren momentopname van vernietigingskandidaten.

Een selectie bevat alle kandidaten die op een bepaald moment voldoen aan de toegepaste selectieregels.

Een selectie verandert niet nadat deze gereed is verklaard.

### Velden

| Veld | Omschrijving |
|--------|--------|
| SelectieId | Unieke identificatie van de selectie |
| Peildatum | Datum waarop de selectieregels zijn toegepast |
| Selectietijdstip | Datum en tijd waarop de selectie is uitgevoerd |
| Selectiestatus | Status van de selectie |
| TotaalKandidaten | Aantal vernietigingskandidaten in de selectie |
| TotaalObjecten | Totaal aantal onderliggende informatieobjecten in de selectie |
| TotaalBetrokkenen | Totaal aantal unieke betrokkenen in de selectie |
| StekkerNaam | Naam van de uitvoerende Stekker |
| StekkerOmschrijving | Beschrijving van de gegevensbronnen en applicaties die door de Stekker worden ontsloten |
| Stekkerversie | Versie van de Stekker waarmee de selectie is uitgevoerd |
| Configuratieversie | Gebruikte configuratieversie |
| ApiVersie | Versie van de API waarmee de selectie is geleverd |
| AantalWaarschuwingen | Aantal waarschuwingen dat tijdens selectie is opgetreden |
| AantalFouten | Aantal fouten dat tijdens selectie is opgetreden |

---

## 5.2 Vernietigingskandidaat

Een vernietigingskandidaat vertegenwoordigt één of meer informatieobjecten die dezelfde selectiekenmerken delen.

De kandidaat vormt de eenheid waarop beoordeling, besluitvorming en uitvoering plaatsvinden.

De API maakt onderscheid tussen:

- `VernietigingskandidaatId`: stabiele identificatie van de vernietigingskandidaat over het hele proces;
- `BronId`: technische sleutel waarmee de Stekker het object in de bron kan terugvinden en vernietigen;
- `BronIdNaam`: gebruikersherkenbare naam of aanduiding van het object die in de Cockpit kan worden getoond.

`VernietigingskandidaatId` ontstaat bij selectie en blijft behouden tijdens beoordeling, vrijgave, vernietiging en resultaatverwerking. De identifier koppelt de selectieregel aan de vernietigingslijst en aan de uiteindelijke uitvoeringsresultaten. `BronId` is de technische sleutel die de Cockpit later terugstuurt voor vernietiging. `BronIdNaam` is bedoeld voor herkenbaarheid en presentatie, niet voor technische uitvoering.

### Velden

| Veld | Omschrijving |
|--------|--------|
| VernietigingskandidaatId | Stabiele identificatie van de vernietigingskandidaat over selectie, beoordeling, vernietiging en resultaatverwerking |
| Omschrijving | Titel of omschrijving van de vernietigingskandidaat |
| Classificatieschema | Schema of stelsel waaruit de classificatie afkomstig is, bijvoorbeeld BAC, ZTC of een ander classificatieschema |
| Classificatiesleutel | Gebruikte classificatie, zoals dossierclassificatie, zaaktype of procestype |
| Classificatieomschrijving | Leesbare omschrijving van de gebruikte classificatie |
| Selectielijst | Toegepaste selectielijst |
| Grondslag | Selectielijstcategorie of grondslag waarop de kandidaat geselecteerd is |
| GrondslagAfwijkend | Optionele afwijkende of aanvullende grondslag, bijvoorbeeld specifieke wetgeving, beleid of normenkader |
| Resultaat | Resultaattype uit de selectielijst waarop de waardering is gebaseerd |
| Bewaartermijn | Toegepaste bewaartermijn uit de selectielijst |
| Waardering | Waardering uit de selectielijst |
| Begindatum | Startdatum van de periode waarop de kandidaat betrekking heeft |
| Einddatum | Einddatum van de periode waarop de kandidaat betrekking heeft |
| Vernietigingsdatum | Door de Stekker berekende vernietigingsdatum |
| AantalObjecten | Optioneel aantal onderliggende informatieobjecten dat door deze kandidaat wordt vertegenwoordigd |
| AantalBetrokkenen | Optioneel aantal unieke betrokkenen binnen de onderliggende informatieobjecten |
| BronIdNaam | Gebruikersherkenbare naam of aanduiding van het object, zoals zaaknummer, dossiernummer of documentnaam |
| BronId | Technische sleutel waarmee de Stekker het object in de bron kan terugvinden en vernietigen |
| RelatieType | Optioneel type relatie met een ander object of systeem, bijvoorbeeld een relatie met een zaaksysteem |
| RelatieId | Optionele identificatie van de gerelateerde zaak, dossiergroep of ander gerelateerd object |
| StatusVernietigingskandidaat | Operationele status van de kandidaat of objectgroep bij de Stekker of in de bron |
| Uitvoeringsresultaat | Resultaat van de technische uitvoering |
| Foutcode | Gestandaardiseerde foutcode indien uitvoering niet succesvol was |
| Foutmelding | Leesbare toelichting op een fout of afwijking |
| Bronstatus | Eventuele afwijking of wijziging geconstateerd in de bron |
| Toelichting | Optionele aanvullende toelichting op selectie, afwijkingen of uitvoering |

---

## 5.3 Vernietigingsuitvoering

Een vernietigingsuitvoering vertegenwoordigt een concrete uitvoeringsactie die gebaseerd is op een selectie.

Een selectie kan resulteren in meerdere uitvoeringen.

### Velden

| Veld | Omschrijving |
|--------|--------|
| VernietigingId | Unieke identificatie van de vernietigingsuitvoering |
| SelectieId | Verwijzing naar de onderliggende selectie |
| CockpitTaakId | Verwijzing naar de Cockpit-taak waaruit de uitvoering voortkomt |
| VernietigingsdossierId | Optionele verwijzing naar het vernietigingsdossier in de Cockpit |
| BesluitReferentie | Verwijzing naar het genomen besluit of de vrijgave |
| Status | Status van de vernietigingsuitvoering |
| Starttijd | Datum en tijd waarop de uitvoering is gestart |
| Eindtijd | Datum en tijd waarop de uitvoering is afgerond |
| TotaalKandidaten | Aantal aangeboden vernietigingskandidaten |
| TotaalObjecten | Aantal aangeboden onderliggende informatieobjecten |
| TotaalBatches | Aantal batches dat door de Cockpit is aangekondigd bij vrijgave |
| OntvangenBatches | Aantal batches dat door de Stekker is ontvangen |
| SuccesvolVernietigd | Aantal succesvol verwerkte informatieobjecten |
| Mislukt | Aantal informatieobjecten waarvoor verwerking is mislukt |
| Overgeslagen | Aantal overgeslagen informatieobjecten |
| Gewijzigd | Aantal informatieobjecten dat sinds selectie is gewijzigd |
| NietGevonden | Aantal informatieobjecten dat niet meer aanwezig was |
| StekkerNaam | Naam van de uitvoerende Stekker |
| StekkerOmschrijving | Beschrijving van de gegevensbronnen en applicaties die door de Stekker worden ontsloten |
| Stekkerversie | Versie van de Stekker waarmee de uitvoering is verricht |
| Configuratieversie | Gebruikte configuratieversie |
| AantalBatches | Aantal verwerkte batches |
| AantalWaarschuwingen | Aantal waarschuwingen tijdens uitvoering |
| AantalFouten | Aantal fouten tijdens uitvoering |

Een vernietigingsuitvoering wordt aangemaakt voordat technische vernietiging start. De Cockpit levert eerst batches aan. Daarna geeft de Cockpit de uitvoering expliciet vrij met het aantal aangeleverde batches en kandidaten. Pas na deze vrijgave mag de Stekker de technische vernietiging starten.

---

## 5.4 Uitvoeringsresultaat

Een uitvoeringsresultaat beschrijft het resultaat van een uitgevoerde verwerking voor een vernietigingskandidaat.

### Velden

| Veld | Omschrijving |
|--------|--------|
| VernietigingskandidaatId | Stabiele identificatie van de vernietigingskandidaat waarop het resultaat betrekking heeft |
| BronId | Technische sleutel waarmee de Stekker het object in de bron heeft teruggevonden of geprobeerd heeft terug te vinden |
| BatchNummer | Nummer van de technische batch waarin het informatieobject is aangeboden |
| Resultaat | Eindresultaat van de uitvoering |
| Foutcode | Gestandaardiseerde foutcode |
| Foutmelding | Toelichting op de fout of afwijking |
| Bronstatus | Eventuele afwijking of wijziging in de bron |
| LogReference | Verwijzing naar technische logging bij de Stekker |
| CorrelatieId | Technisch correlatiekenmerk voor tracing en foutanalyse |

### Resultaatwaarden

| Waarde | Omschrijving |
|--------|--------|
| SUCCESS | Verwerking succesvol uitgevoerd |
| FAILED | Verwerking mislukt |
| SKIPPED | Verwerking niet uitgevoerd |
| NOT_FOUND | Kandidaat of onderliggende objecten niet gevonden |
| CHANGED | Kandidaat of onderliggende objecten gewijzigd sinds selectie |

---

# 6. Relaties

## Selectie naar vernietigingskandidaten

Een selectie bevat nul of meer vernietigingskandidaten.

```text
Selectie [1]
 └── Vernietigingskandidaat [0..*]
```

---

## Vernietigingskandidaat naar informatieobjecten

Een vernietigingskandidaat vertegenwoordigt één of meer onderliggende informatieobjecten.

```text
Vernietigingskandidaat [1]
 └── Informatieobject [1..*]
```

Onderliggende informatieobjecten maken geen onderdeel uit van dit informatiemodel en worden niet rechtstreeks uitgewisseld via de API.

---

## Selectie naar vernietigingsuitvoering

Een selectie kan leiden tot nul of meer vernietigingsuitvoeringen.

```text
Selectie [1]
 └── Vernietigingsuitvoering [0..*]
```

---

## Vernietigingsuitvoering naar uitvoeringsresultaten

Een vernietigingsuitvoering bevat nul of meer uitvoeringsresultaten.

```text
Vernietigingsuitvoering [1]
 └── Uitvoeringsresultaat [0..*]
```

---

# 7. Gebruik in de OpenAPI-specificatie

De objecten uit dit informatiemodel worden vertaald naar OpenAPI-schema's.

Voor interoperabiliteit gelden de volgende minimale verplichte velden:

| Object | Verplichte velden |
|--------|--------|
| Selectie | SelectieId, Selectiestatus |
| Vernietigingskandidaat | VernietigingskandidaatId, BronId, Omschrijving |
| Vernietigingsuitvoering | VernietigingId, SelectieId, CockpitTaakId, BesluitReferentie, Status |
| Batchaanlevering | BatchNummer, VernietigingskandidaatId, BronId |
| Uitvoeringsresultaat | VernietigingskandidaatId, BronId, Resultaat |

Overige velden zijn metadata voor beoordeling, controle, troubleshooting, reproduceerbaarheid en dossieropbouw. Ontbrekende optionele velden mogen niet leiden tot een andere interpretatie van status, resultaat of verantwoordelijkheid.

De belangrijkste schema's zijn:

- Selectie
- Vernietigingskandidaat
- Vernietigingsuitvoering
- Uitvoeringsresultaat

Deze schema's vormen de basis voor:

- requests;
- responses;
- resources;
- validatieregels;
- contracttesten.

Het API-contract beschrijft de interactie tussen deze objecten. De OpenAPI-specificatie vormt de technische uitwerking hiervan.
