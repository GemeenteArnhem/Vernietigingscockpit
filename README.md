
# Vernietigingscockpit

De Vernietigingscockpit is een open source applicatie gericht op het gecontroleerd, transparant en aantoonbaar vernietigen van digitale informatie bij gemeenten.

De cockpit ondersteunt informatiebeheerders, proceseigenaren en archivarissen bij het uitvoeren van vernietigingstaken conform Archiefwet, AVG en aanverwante regelgeving, binnen een steeds complexer wordend informatielandschap.

Dit project wordt ontwikkeld als onderdeel van een bredere community aanpak, met nadruk op herbruikbaarheid, standaardisatie en open samenwerking.

---

## Doel en scope

Het doel van de Vernietigingscockpit is

- centraal regie voeren op vernietiging van informatieobjecten over meerdere bronsystemen
- het vernietigingsproces navolgbaar en controleerbaar maken
- expliciete besluitvorming ondersteunen voorafgaand aan vernietiging
- standaardisatie van vernietigingslogica en APIs mogelijk maken

De cockpit is nadrukkelijk **geen archiefsysteem**, maar een sturings en controlelaag binnen een Common Ground landschap.

---

## Ontwikkelprincipes en richtlijnen

Dit project volgt de principes uit onder andere

- Common Ground
- NeRDS leidraad
- Standaard voor Publieke Code
- Open source werken binnen de publieke sector

Concreet betekent dit onder andere

- scheiding tussen ontwerp en implementatie
- contract first denken bij APIs
- expliciete besluitvorming vastgelegd in de repository
- maximale transparantie richting gebruikers en hergebruikers

Deze richtlijnen schrijven geen concrete Github inrichting voor, maar vragen wel om traceerbaarheid en herleidbaarheid. De inrichting van deze repository is daarop afgestemd.

---

## Werkwijze in deze repository

We werken met Github Issues als centrale plek voor

- ontwerp en verkenning
- besluitvorming
- concrete ontwikkeling

Daarbij hanteren we drie expliciete typen issues.

### Design sprint issues

Design sprint issues worden gebruikt voor ontwerpvragen en verkenning, bijvoorbeeld

- UX flows en gebruikersinteractie
- afbakening cockpit versus bron
- API contractverkenning
- MVP scope keuzes

Deze issues hebben het label `design-sprint` en leiden altijd tot een expliciet resultaat, zoals een ontwerpkeuze of een besluit.

### Decision issues

Decision issues leggen expliciete besluiten vast, inclusief aanleiding en gevolgen.

Besluiten worden niet impliciet genomen in code, maar vastgelegd in issues met het label `decision`. Dit maakt latere verantwoording en hergebruik mogelijk.

### Dev issues

Dev issues beschrijven concreet ontwikkelwerk, zoals

- frontend implementatie
- backend logica
- API implementatie
- bugfixes en technische verbeteringen

Een dev issue verwijst altijd naar afgerond ontwerp of een genomen besluit.

---

## Labels en betekenis

In deze repository gebruiken we vaste labels om consistentie en duidelijkheid te borgen.

Voor ontwerp en governance

- `design-sprint` ontwerp en verkenning
- `decision` expliciete besluitvorming
- `ui` UX en UI scope
- `api` API standaard en contractontwerp
- `standardisation` herbruikbare afspraken
- `mvp-boundary` bewust buiten MVP scope geplaatst

Voor ontwikkeling

- `dev` algemeen ontwikkelwerk
- `frontend` frontend implementatie
- `backend` backend implementatie
- `api-implementation` implementatie van vastgesteld API contract
- `bug` foutief gedrag
- `tech-debt` technische schuld of verbetering

Ontwerp en ontwikkeling worden niet gemengd in één issue.

---

## Open source en community

De Vernietigingscockpit is bedoeld als open source bouwsteen voor gemeenten en andere overheidsorganisaties.

Bijdragen zijn welkom in de vorm van

- issues
- ontwerpinput
- code
- documentatie
- gebruikservaringen

Iedere bijdrage is openbaar en navolgbaar. Governance en richting worden bewaakt via expliciete besluitvorming in deze repository.

---

## Status

Dit project bevindt zich in actieve ontwikkeling. Functionaliteit wordt gefaseerd gerealiseerd, beginnend met een werkbare MVP.
Actuele voortgang is te volgen via Github Issues en Projects.

---

## Contact en context
Dit project wordt geïnitieerd door gemeente Arnhem, gemeente Tilburg, Visma Circle, Ilionix, Centric en ontwikkeld in samenwerking met andere gemeenten en partners. Voor inhoudelijke vragen of deelname aan de community, gebruik bij voorkeur vernietigingscockpit.nl, Github Issues of Discussions.