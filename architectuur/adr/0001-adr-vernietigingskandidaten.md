## ADR 001 – Vernietigingskandidaat als primair uitwisselobject tussen Cockpit en Stekker

### Status

Voorgesteld

### Datum

2026-07-30

### Context

De bestaande architectuur en het API-contract beschrijven de interactie tussen Vernietigingscockpit en Stekker grotendeels in termen van informatieobjecten. Hierbij wordt onder meer beschreven dat de Stekker per aangeboden informatieobject een uitvoeringsresultaat retourneert.

Tijdens de verdere uitwerking van het metadata-overzicht en het API-informatiemodel is gebleken dat deze benadering onvoldoende aansluit op de beoogde werking van het Vernietigingscockpit ecosysteem. De Stekker levert in de praktijk geen afzonderlijke informatieobjecten aan de Cockpit, maar geaggregeerde vernietigingskandidaten. Een vernietigingskandidaat kan daarbij één of meerdere onderliggende informatieobjecten vertegenwoordigen die dezelfde selectiekenmerken delen.

Deze aggregatie is noodzakelijk om grote aantallen informatieobjecten beheersbaar te kunnen presenteren, beoordelen en verwerken. Zonder aggregatie zouden selecties potentieel uit honderdduizenden of miljoenen afzonderlijke records kunnen bestaan, hetgeen de bruikbaarheid van de Cockpit aanzienlijk vermindert.

Daarnaast ontstaat op korte termijn de behoefte om naast vernietiging ook andere vormen van verwerking, zoals overbrenging, te ondersteunen. Hierdoor wordt het onderscheid tussen informatieobjecten en kandidaten voor verwerking nog belangrijker.

### Beslissing

De Vernietigingscockpit en de Stekker wisselen primair vernietigingskandidaten uit.

Een vernietigingskandidaat vertegenwoordigt één of meer onderliggende informatieobjecten die dezelfde selectiekenmerken delen.

De vernietigingskandidaat vormt de functionele eenheid voor:

- selectie;
- beoordeling;
- besluitvorming;
- vrijgave;
- uitvoering;
- resultaatterugkoppeling.

Onderliggende informatieobjecten blijven eigendom van en beheerd door het bronsysteem en maken geen onderdeel uit van het primaire uitwisselmodel tussen Cockpit en Stekker.

Waar in bestaande architectuurdocumentatie of contracten wordt gesproken over informatieobjecten als uitwisselobject tussen Cockpit en Stekker, moet dit binnen de context van de Stekker API gelezen worden als vernietigingskandidaat, tenzij expliciet anders vermeld.

De Stekker blijft verantwoordelijk voor de verwerking van de onderliggende informatieobjecten binnen de bron.

### Overwegingen

De volgende overwegingen hebben geleid tot deze beslissing:

- De Cockpit is verantwoordelijk voor regie, beoordeling en besluitvorming en heeft geen behoefte aan individuele verwerking van alle onderliggende informatieobjecten.
- Grote vernietigingslijsten moeten beheersbaar gepresenteerd kunnen worden aan gebruikers.
- Aggregatie vermindert netwerkverkeer, opslag en verwerking in de Cockpit.
- De Stekker blijft verantwoordelijk voor operationele selectie en bron-specifieke logica.
- Het model sluit beter aan bij toekomstige uitbreidingen zoals overbrenging.
- De scheiding tussen normatief en operationeel blijft behouden.
- De oplossing blijft compatibel met de bestaande architectuurprincipes rondom federatie, schaalbaarheid en herbruikbaarheid.

### Alternatieven

#### Alternatief 1 – Informatieobject als primair uitwisselobject

Alle informatieobjecten worden afzonderlijk tussen Cockpit en Stekker uitgewisseld.

Niet gekozen omdat:

- dit leidt tot zeer grote datasets;
- beoordeling door gebruikers complexer wordt;
- prestaties en schaalbaarheid nadelig worden beïnvloed;
- de Cockpit operationele detailinformatie ontvangt die niet noodzakelijk is voor haar verantwoordelijkheid.

#### Alternatief 2 – Zowel vernietigingskandidaten als informatieobjecten gelijkwaardig uitwisselen

De API ondersteunt beide niveaus als primaire uitwisselvorm.

Niet gekozen omdat:

- dit het contract complexer maakt;
- verantwoordelijkheden minder duidelijk worden;
- leveranciers meerdere implementatiepatronen moeten ondersteunen;
- semantische verschillen tussen kandidaat- en objectniveau tot interpretatieverschillen kunnen leiden.

#### Alternatief 3 – Aggregatie uitsluitend binnen de Cockpit uitvoeren

Stekkers leveren individuele informatieobjecten en de Cockpit groepeert deze.

Niet gekozen omdat:

- bronkennis en selectielogica daarmee deels verschuiven richting de Cockpit;
- dit strijdig is met het principe dat operationele logica in de Stekker plaatsvindt;
- aggregatieregels bronafhankelijk kunnen zijn.

### Gevolgen

#### Impact op architectuur

- Vernietigingskandidaat wordt het primaire functionele uitwisselobject tussen Cockpit en Stekker.
- Een vernietigingskandidaat kan meerdere informatieobjecten vertegenwoordigen.
- De architectuurprincipes blijven ongewijzigd.

#### Impact op implementaties

- Het API-informatiemodel wordt gebaseerd op vernietigingskandidaten.
- OpenAPI-specificaties moeten worden opgesteld vanuit kandidaten in plaats van informatieobjecten.
- Leveranciers moeten kunnen aangeven hoeveel onderliggende informatieobjecten door een kandidaat worden vertegenwoordigd.
- Velden zoals OmvangObjecten en OmvangClienten krijgen een expliciete betekenis binnen het model.

#### Gevolgen voor beheer en governance

- Beoordeling en accordering vinden plaats op kandidaatniveau.
- Rapportages en vernietigingsdossiers worden gebaseerd op kandidaten en de daarbij behorende aantallen onderliggende informatieobjecten.
- Traceerbaarheid naar de bron blijft mogelijk via BronId en aanvullende broninformatie.

#### Risico’s en aandachtspunten

- Het onderscheid tussen vernietigingskandidaat en informatieobject moet expliciet worden beschreven in architectuur-, contract- en API-documentatie.
- Historische documentatie die spreekt over informatieobjecten kan tot interpretatieverschillen leiden.
- Toekomstige ondersteuning van overbrenging moet dezelfde kandidaatstructuur blijven gebruiken om consistentie binnen het ecosysteem te behouden.