# Architectuur – Vernietigingscockpit ecosysteem

## 1. Doel en scope

Dit document beschrijft de overkoepelende architectuur van het Vernietigingscockpit ecosysteem.
Het document **is normerend bedoeld** en geeft richting aan ontwerp, ontwikkeling, implementatie en gebruik.

Doel van dit document is:
- het vastleggen van het architecturale totaalbeeld
- het expliciet afbakenen van verantwoordelijkheden
- het borgen van consistentie tussen componenten
- het ondersteunen van hergebruik en doorontwikkeling

Dit document beschrijft **geen** technische implementatiedetails.
Implementaties **moeten** aantoonbaar aansluiten op dit architectuurkader.

## 2. Context en probleemstelling

Organisaties beheren informatie verspreid over vele applicaties en bronsystemen.
Selectie en vernietiging volgens wet en regelgeving is hierdoor complex en foutgevoelig.

Het Vernietigingscockpit ecosysteem **moet** dit adresseren door:
- centrale en gecontroleerde regie
- decentrale technische uitvoering
- uniforme processen over systemen heen
- volledige audit en verantwoording

Het ecosysteem **moet** toepasbaar zijn in een gefragmenteerd en voortdurend veranderende informatiehuishouding (het digitale landschap).

## 3. Architectuurvisie

De architectuur is gebaseerd op een ecosysteemgedachte waarin verantwoordelijkheden expliciet zijn gescheiden.

Daarbij gelden de volgende uitgangspunten:
- de cockpit vervult de rol van regie en besluitvorming
- de Stekker vervult de rol van selectie en technische uitvoering
- het bronsysteem bevat en beheert de feitelijke informatieobjecten

Deze rolverdeling geldt onafhankelijk van technische of organisatorische inrichting.
Integratie van Stekker en in het bronsysteem toegestaan, zolang verantwoordelijkheden gescheiden blijven.

De cockpit **weet wat** moet gebeuren.
De stekker **weet hoe** dit technisch gebeurt.
Het bronsysteem **blijft eigenaar en beheerder** van de informatieobjecten zolang deze bestaan.

Deze verantwoordelijkheden **mogen niet** vermengd worden.

## 4. Architectuurprincipes

De volgende principes **zijn leidend** voor alle onderdelen:

- scheiding van verantwoordelijkheden
- centrale regie, decentrale uitvoering (federatief)
- expliciete scheiding tussen normatief en operationeel
- configuratie boven maatwerk
- generieke en herbruikbare componenten
- volledige audit en traceerbaarheid
- backward compatibility is verplicht
- security en privacy by default
- architectuur volgens Common Ground en NeRDS
- open source en transparantie
- architectuur **schrijft verantwoordelijkheden voor**, maar **schrijft geen technische of organisatorische vorm af**

Afwijkingen van deze principes **moeten** expliciet gemotiveerd en vastgelegd worden.

## 5. Logisch architectuuroverzicht

Het ecosysteem bestaat uit drie hoofdcomponenten:
- Vernietigingscockpit
- Stekkers
- Bronsystemen

De componenten Vernietigingscockpit en Stekkers **moeten** strikt gescheiden blijven. Een stekker kan zowel als losstaand component als geïntegreerd onderdeel van een bronsysteem worden aangeboden.

### 5.1 Overzichtsdiagram

```mermaid
flowchart LR

    A["Vernietigingscockpit
    - Regie
    - Besluitvorming
    - Dossier"]
    B["Stekkers
    - Logica
    - Selectie
    - Uitvoering"]
    C["Bronsystemen
    - Records"]

    A --> B
    B --> A
    B --> C
    C --> B
```

Technisch vindt er tweerichtingscommunicatie plaats, het bovenstaande schema dwingt architecturaal de route ad: cockpit communiceert met stekker, stekker met bronsysteem, cockpit niet met bronsysteem.

## 6. Hoofdcomponenten

Het ecosysteem bestaat uit drie hoofdcomponenten.
Deze componenten **moeten** strikt gescheiden blijven en **mogen** geen verantwoordelijkheden van elkaar overnemen.

### 6.1 Vernietigingscockpit

De Vernietigingscockpit **is** het centrale regie en besluitvormingscomponent.
De cockpit:
- **moet** vernietigingstaken en workflows beheren
- **moet** beoordeling en accordering ondersteunen
- **moet** dossiers en verantwoordingsinformatie beheren
- **moet** verklaringen van vernietiging genereren

De cockpit **mag geen** directe selectie in of tegen bronsystemen uitvoeren. Dit verloopt altijd via de stekker.
De cockpit **mag geen** directe vernietigingshandelingen tegen bronsystemen uitvoeren. Dit verloopt altijd via de stekker.

### 6.2 Stekkers

Stekkers **vormen** de schakel tussen cockpit en bronsystemen.
Stekkers:
- **moeten** selectieregels operationeel interpreteren
- **moeten** vernietigingskandidaten bepalen
- **moeten** na vrijgave vernietiging technisch uitvoeren via het bronsysteem
- **moeten** per aangeboden informatieobject een uitvoeringsresultaat retourneren

Stekkers **mogen** bronsysteem‑ en domeinspecifieke logica bevatten.
Stekkers **mogen geen** normatieve besluitvorming uitvoeren.

### 6.3 Bronsystemen

bronsystemen:
- **bevatten** de informatieobjecten
- **blijven** eigenaar en beheerder van de informatieobjecten zolang deze bestaan
- **voeren** de feitelijke vernietiging van informatieobjecten uit

Bronsystemen **mogen geen** kennis nodig hebben van cockpitprocessen of normatieve besluitvorming.

Zo kan een een geïntegreerde stekker technisch naast een bronsysteem kan zitten, maar het bronsysteem zelf mag niet afhankelijk mag worden van cockpitlogica.

## 7. Normatief versus operationeel

De architectuur **maakt verplicht onderscheid** tussen normatief en operationeel.

### 7.1 Normatief

Normatief betreft:
- wat vernietigd mag worden
- onder welke voorwaarden
- op basis van welke besluiten

Normatieve besluitvorming:
- **moet** plaatsvinden in de Vernietigingscockpit
- **moet** door mensen worden uitgevoerd
- **moet** worden vastgelegd in het dossier

Normatieve besluitvorming **mag niet** plaatsvinden in stekkers en/of bronsystemen.

### 7.2 Operationeel

Operationeel betreft:
- selectie van concrete informatieobjecten (vernietigingskandidaten)
- operationele uitvoering van vernietiging
- foutafhandeling en retries

Operationele logica:
- **moet** plaatsvinden in de Stekkers
- **mag niet** plaatsvinden in de cockpit

## 8. Interactie en verantwoordelijkheden

De verantwoordelijkheden zijn strikt gescheiden:
- de cockpit **moet** regie voeren en besluiten vastleggen
- stekkers **moeten** selectie en vernietiging operationeel uitvoeren
- bronsystemen **moeten** de daadwerkelijke vernietiging van informatieobjecten uitvoeren

De cockpit **mag niet** direct communiceren met bronsystemen. Alle communicatie **moet** verlopen via stekkers.

## 9. Niet functionele kwaliteitsdoelen

Het ecosysteem **moet** voldoen aan de volgende kwaliteitsdoelen conform gemeentelijk normenkader:
- schaalbaarheid over meerdere bronsystemen
- betrouwbaarheid en herstartbaarheid
- volledige audit en reproduceerbaarheid
- beveiliging en functiescheiding 
- beheerbaarheid en configureerbaarheid
- transparantie richting toezicht en controle

Deze kwaliteitsdoelen **zijn richtinggevend** voor alle ontwerpkeuzes.

## 10. Versies en evolutie

Het ecosysteem **moet** kunnen evolueren zonder dat bestaande processen breken.
Daarom geldt:
- uitbreidingen zijn additief
- brekende wijzigingen binnen een major versie zijn niet toegestaan, een separate stekker als uitzondering is mogelijk
- de actuele stekker-versie en maximaal twee eerdere ondersteunde versies moeten parallel ondersteund kunnen worden, tenzij anders overeengekomen
- historische processen **moeten** reproduceerbaar blijven

Versie‑informatie **moet** worden vastgelegd in audit en dossiers.

## 11. Aannames en kaders

### 11.1 Aannames

- regie, beoordeling en accordering van selectie en vernietiging vinden centraal plaats in de cockpit
- selectie en technische vernietiging worden uitgevoerd via stekkers
- selectieregels worden niet centraal geïnterpreteerd
- feitelijke vernietiging is mogelijk in bronsystemen
- organisatorische rollen zijn ingericht

Deze aannames **moeten** expliciet worden gemaakt bij implementatie.

### 11.2 Kaders

Het ecosysteem **moet** aansluiten bij:
- Archiefwet, BIO2, Cybersecuritywet, AVG en aanpalende regelgeving
- Common Ground architectuurprincipes
- NeRDS-leidraad
- Nederlandse API Design Rules (ADR)
- Toegankelijkheid volgens WCAG 2.1 AA
- Open source standaarden

## 12. Relatie met verdiepende architectuurdocumenten

Dit document **vormt het bindende architectuurkader** voor:
- architectuur-cockpit.md
- architectuur-stekker.md

Deze documenten **mogen niet** strijdig zijn met dit architectuurkader.