# Vernietigingscockpit – Ontwikkeling, architectuur en governance

Deze repository is de **centrale entree** voor de ontwikkeling van de Vernietigingscockpit.
Hier komen **agile werken**, **architectuur**, **security**, **compliance** en **governance** samen.

De repository ondersteunt samenwerking tussen gemeenten, leveranciers en community,
op een manier die **iteratief bouwen** combineert met **expliciete en normerende kaders**.

---

## 1. Doel van deze repository

Deze repository heeft twee expliciet samenhangende doelen:

### 1. Agile ontwikkeling ondersteunen
- werken met epics, features en user stories
- gezamenlijke backlog en prioritering
- transparant voortgangsbeheer
- iteratief opleveren en bijsturen

### 2. Architectuur en governance borgen
- gedeelde architectuurprincipes
- normatieve kaders en verantwoordelijkheden
- security, privacy en compliance
- aantoonbare besluitvorming

Agile werken en architectuur zijn hierin **bewust verbonden**:
we bouwen iteratief, **binnen vastgestelde kaders**.

---

## 2. Agile werken in deze repository

De ontwikkeling van de Vernietigingscockpit verloopt agile.

### 2.1 Werkvorm

Agile werken betekent:
- epics voor grote samenhangende doelen
- features en user stories voor concrete functionaliteit
- prioritering op basis van waarde, risico en compliance
- korte feedbackloops

GitHub wordt hierbij gebruikt voor:
- Issues, user stories en taken
- Projects voor planning en voortgang
- Pull requests voor wijzigingen en reviews

### 2.2 Relatie met architectuur

Agile werken **vindt altijd plaats binnen de architectuurkaders**.

Dat betekent:
- architectuur is niet optioneel
- functiescheiding mag niet worden doorbroken
- normatief en operationeel blijven gescheiden
- afwijkingen vereisen expliciete besluitvorming

Grote of structurele keuzes **worden vastgelegd als ADR**.

---

## 3. Wat is de Vernietigingscockpit

De Vernietigingscockpit is een centrale voorziening voor
gecontroleerde, herhaalbare en aantoonbare vernietiging
van digitale informatie, conform wet en regelgeving.

### Kernidee

- de cockpit **beslist en verantwoordt**
- stekkers **selecteren en voeren technisch uit**
- bronsystemen **blijven systeem van record**

De cockpit:
- beheert vernietigingstaken en workflows
- ondersteunt beoordeling en accordering
- borgt functiescheiding
- beheert dossiers en audittrail
- genereert verklaringen van vernietiging

De cockpit vernietigt zelf **geen** data.

---

## 4. Architectuur in het kort

Het ecosysteem bestaat uit drie hoofdonderdelen:
- Vernietigingscockpit, regie en besluitvorming
- Stekkers, selectie en technische uitvoering
- Bronsystemen, fysieke dataopslag en verwijdering

De onderdelen zijn los gekoppeld.
Communicatie verloopt altijd via vaste contracten.
Normatieve besluitvorming en operationele uitvoering zijn strikt gescheiden.

---

## 5. De Stekker als logisch architectuurpatroon

De **Stekker** is een **logisch architectuurpatroon**.
Het beschrijft verantwoordelijkheden en gedrag,
**niet** de technische of organisatorische vorm.

Een Stekker kan verschillende geldige verschijningsvormen hebben.

### 5.1 Standalone Stekker

Een Stekker kan zelfstandig worden geïmplementeerd:
- als aparte component of service
- werkend bovenop eenvoudige databronnen, zoals CSV‑bestanden, exports of databases
- los beheerd van het bronsysteem

Dit is passend bij:
- legacy bronnen
- eenvoudige of tijdelijke databronnen
- overbruggingssituaties

### 5.2 Geïntegreerde Stekker

Een Stekker kan ook volledig geïntegreerd zijn in een taakapplicatie van een leverancier:
- ontwikkeld en beheerd door die leverancier
- zonder aparte deployment als zelfstandige component
- als onderdeel van de applicatiearchitectuur

### 5.3 Architecturale gelijkwaardigheid

Deze verschijningsvormen zijn **architecturaal gelijkwaardig**.

In alle gevallen geldt:
- hetzelfde contract richting de Vernietigingscockpit
- dezelfde scheiding tussen normatief en operationeel
- dezelfde verantwoordelijkheden
- de bron blijft systeem van record

De architectuur schrijft **geen deployment‑ of eigenaarschapsmodel voor**,
maar **wel verantwoordelijkheden en gedrag**.

---

## 6. Architectuur- en governance documentatie

De architectuur en kaders zijn vastgelegd in afzonderlijke Markdown documenten.

### 6.1 Architectuur

- `architecture/architectuur.md`  
  Overkoepelend architectuurkader en principes

- `architecture/architectuur-cockpit.md`  
  Architectuur van de Vernietigingscockpit

- `architecture/architectuur-stekker.md`  
  Generiek stekkerpatroon en verantwoordelijkheden

- `architecture/sequence-diagrams.md`  
  Procesverloop en interacties

- `architecture/glossary.md`  
  Normatieve begrippenlijst

### 6.2 Security en compliance

- `security/security-and-privacy.md`  
  Security- en privacykaders

- `security/compliance-mapping.md`  
  Relatie met Common Ground, NeRDS, BIO, AVG, NIS2 en Archiefwet

### 6.3 Governance en rollen

- `governance/governance.md`  
  Besturing, besluitvorming en kaders

- `governance/roles-and-responsibilities.md`  
  Rollen, bevoegdheden en functiescheiding

### 6.4 Architectuurbesluiten

- `adr/`  
  Architecture Decision Records voor expliciete keuzes en afwijkingen

---

## 7. Normatief karakter

De architectuur- en governancedocumentatie is **normerend bedoeld**.

Dat betekent:
- architectuurkaders zijn bindend
- functiescheiding is verplicht
- besluiten en uitvoering zijn gescheiden
- afwijkingen moeten expliciet worden vastgelegd
- alle stappen zijn traceerbaar

Agile keuzes **mogen niet** strijdig zijn met deze kaders.

---

## 8. Relatie met implementaties

Deze repository bevat **geen productiecode**.

De documentatie vormt het kader voor:
- meerdere implementaties
- verschillende stekkers
- verschillende hostingvormen

Concrete implementaties:
- kiezen zelf technische middelen
- **moeten** aantoonbaar aansluiten op deze architectuur

---

## 9. Open source en samenwerking

De Vernietigingscockpit is opgezet als open source ecosysteem.

Deze repository ondersteunt:
- transparantie
- gezamenlijke doorontwikkeling
- hergebruik door meerdere organisaties
- bijdragen vanuit community en leveranciers

Richtlijnen voor bijdragen zijn vastgelegd in `CONTRIBUTING.md`.

---

## 10. Leeswijzer

Nieuw in het project:
1. Lees deze README
2. Ga naar `architecture/architectuur.md`
3. Verdiep je in cockpit en stekker architectuur
4. Gebruik sequence diagrams en glossary ter verdieping

Actief in ontwikkeling:
- gebruik Issues en Projects voor agile werk
- raadpleeg architectuur en governance bij twijfel
- leg afwijkingen vast via ADR’s

---

## 11. Status en governance

Deze repository en documentatie zijn in actieve ontwikkeling.
Wijzigingen worden transparant verwerkt via issues, pull requests en besluitvorming.

Governance en besluitvorming volgen de afspraken in:
- `governance/governance.md`