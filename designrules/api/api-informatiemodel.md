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
- verantwoording.

De Stekker is verantwoordelijk voor:

- selectie;
- operationele interpretatie van selectieregels;
- berekening van bewaartermijnen;
- technische uitvoering;
- terugkoppeling van resultaten.

De Stekker bepaalt welke kandidaten in aanmerking komen voor verdere verwerking. De Cockpit bepaalt niet welke kandidaten geselecteerd worden, maar faciliteert de beoordeling en besluitvorming hierover.

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
| TotaalClienten | Totaal aantal betrokken cliënten in de selectie |
| StekkerNaam | Naam van de uitvoerende Stekker |
| StekkerOmschrijving | Beschrijving van de gegevensbronnen en applicaties die door de Stekker worden ontsloten |
| Stekkerversie | Versie van de Stekker waarmee de selectie is uitgevoerd |
| Configuratieversie | Gebruikte configuratieversie |
| Mappingversie | Gebruikte mappingversie |
| AantalWaarschuwingen | Aantal waarschuwingen dat tijdens selectie is opgetreden |
| AantalFouten | Aantal fouten dat tijdens selectie is opgetreden |

---

## 5.2 Vernietigingskandidaat

Een vernietigingskandidaat vertegenwoordigt één of meer informatieobjecten die dezelfde selectiekenmerken delen.

De kandidaat vormt de eenheid waarop beoordeling, besluitvorming en uitvoering plaatsvinden.

### Velden

| Veld | Omschrijving |
|--------|--------|
| Omschrijving | Titel of omschrijving van de vernietigingskandidaat |
| Classificatiecode | BAC-code, zaaktype, procestype of andere classificatie waarop selectie plaatsvindt |
| Selectielijst | Toegepaste selectielijst |
| Grondslag | Selectielijstcategorie of grondslag waarop de kandidaat geselecteerd is |
| Resultaat | Resultaattype uit de selectielijst waarop de waardering is gebaseerd |
| Bewaartermijn | Toegepaste bewaartermijn uit de selectielijst |
| Waardering | Waardering uit de selectielijst |
| Begindatum | Startdatum van de periode waarop de kandidaat betrekking heeft |
| Einddatum | Einddatum van de periode waarop de kandidaat betrekking heeft |
| Vernietigingsdatum | Door de Stekker berekende vernietigingsdatum |
| OmvangObjecten | Aantal onderliggende informatieobjecten dat door deze kandidaat wordt vertegenwoordigd |
| OmvangClienten | Aantal unieke betrokken cliënten binnen de onderliggende informatieobjecten |
| BronIdNaam | Naam van het identificerende kenmerk binnen de bron |
| BronId | Identificatie van het object of de objectgroep binnen het bronsysteem |
| StatusVernietigingskandidaat | Status van de kandidaat binnen het proces |
| Uitvoeringsresultaat | Resultaat van de technische uitvoering |
| Foutcode | Gestandaardiseerde foutcode indien uitvoering niet succesvol was |
| Foutmelding | Leesbare toelichting op een fout of afwijking |
| Bronstatus | Eventuele afwijking of wijziging geconstateerd in de bron |

---

## 5.3 Vernietigingsuitvoering

Een vernietigingsuitvoering vertegenwoordigt een concrete uitvoeringsactie die gebaseerd is op een selectie.

Een selectie kan resulteren in meerdere uitvoeringen.

### Velden

| Veld | Omschrijving |
|--------|--------|
| VernietigingId | Unieke identificatie van de vernietigingsuitvoering |
| SelectieId | Verwijzing naar de onderliggende selectie |
| Status | Status van de vernietigingsuitvoering |
| Starttijd | Datum en tijd waarop de uitvoering is gestart |
| Eindtijd | Datum en tijd waarop de uitvoering is afgerond |
| TotaalKandidaten | Aantal aangeboden vernietigingskandidaten |
| TotaalObjecten | Aantal aangeboden onderliggende informatieobjecten |
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

---

## 5.4 Uitvoeringsresultaat

Een uitvoeringsresultaat beschrijft het resultaat van een uitgevoerde verwerking voor een vernietigingskandidaat.

### Velden

| Veld | Omschrijving |
|--------|--------|
| BronId | Identificatie van de vernietigingskandidaat binnen de bron |
| Resultaat | Eindresultaat van de uitvoering |
| Foutcode | Gestandaardiseerde foutcode |
| Foutmelding | Toelichting op de fout of afwijking |
| Bronstatus | Eventuele afwijking of wijziging in de bron |

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