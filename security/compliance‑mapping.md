# Compliance mapping – Vernietigingscockpit ecosysteem

Dit document beschrijft hoe het Vernietigingscockpit ecosysteem aantoonbaar aansluit op relevante normen en wetgeving.

Het document is **normerend bedoeld** en vormt een referentiekader voor:
- auditors en toezichthouders
- deelnemende organisaties
- leveranciers en implementatiepartners

Dit document beschrijft **architecturale en procesmatige borging**.
Het beschrijft **geen implementatie‑ of control‑niveau maatregelen**.

## 1. Doel en gebruik

Het doel van deze compliance mapping is:
- inzichtelijk maken welke normen en wetten van toepassing zijn
- expliciteren hoe deze normen architecturaal worden geborgd
- ondersteunen van compliance zonder bureaucratie
- faciliteren van audits en toezicht

Dit document:
- vervangt geen lokale compliance toets
- ondersteunt aantoonbaarheid op ecosysteemniveau
- maakt expliciet waar verantwoordelijkheden liggen

## 2. Algemene uitgangspunten

De volgende uitgangspunten **zijn leidend**:
- compliance wordt geborgd via architectuur en governance
- verantwoordelijkheden blijven bij de deelnemende organisatie
- implementaties zijn verantwoordelijk voor technische invulling
- documentatie en dossiers vormen het primaire bewijs

De mapping is indicatief en gericht op hoofdlijnen.

## 3. Common Ground

### 3.1 Relevantie

Common Ground vormt het leidende architectuurkader voor publieke digitale voorzieningen.

### 3.2 Architecturale interpretatie

Binnen dit ecosysteem betekent Common Ground:
- losse koppeling van componenten
- data blijft bij de bron
- heldere verantwoordelijkheden
- API first communicatie

### 3.3 Borging in het ecosysteem

- de cockpit **bevat geen** brondata
- bronsystemen **blijven** systeem van record
- communicatie verloopt uitsluitend via stekkers
- regie en uitvoering zijn strikt gescheiden

### 3.4 Verwijzing naar documentatie

- architectuur.md
- architectuur-cockpit.md
- architectuur-stekker.md

---

## 4. NeRDS leidraad

### 4.1 Relevantie

De NeRDS leidraad biedt een kwaliteitskader voor gemeentelijke softwareontwikkeling.

### 4.2 Architecturale interpretatie

Dit betekent:
- expliciete architectuurdocumentatie
- toetsbare ontwerpkeuzes
- iteratieve doorontwikkeling
- open source samenwerking

### 4.3 Borging in het ecosysteem

- vastgelegde architectuurdocumenten
- ADR’s voor architectuurbesluiten
- governance structuur
- contributierichtlijnen

### 4.4 Verwijzing naar documentatie

- governance.md
- contributing.md
- adr directory

---

## 5. BIO – Baseline Informatiebeveiliging Overheid

### 5.1 Relevantie

De BIO is het primaire normenkader voor informatiebeveiliging binnen de overheid.

### 5.2 Architecturale interpretatie

De architectuur richt zich op:
- functiescheiding
- autorisatie op basis van rollen
- logging en audittrail
- expliciete verantwoordelijkheden

### 5.3 Borging in het ecosysteem

- rollen en verantwoordelijkheden vastgelegd
- verplichte workflowstappen
- centrale auditlogging
- scheiding regie en uitvoering

### 5.4 Verwijzing naar documentatie

- security-and-privacy.md
- roles-and-responsibilities.md
- architectuur.md

---

## 6. Cybersecuritywet en NIS2

### 6.1 Relevantie

De Cybersecuritywet en NIS2 stellen eisen aan weerbaarheid van digitale ketens.

### 6.2 Architecturale interpretatie

Belangrijke principes zijn:
- transparante ketenverantwoordelijkheid
- inzicht in afhankelijkheden
- aantoonbare incidentafhandeling

### 6.3 Borging in het ecosysteem

- losse koppeling tussen componenten
- expliciete verantwoordelijkheidsverdeling
- logging en monitoring
- governance voor incidenten

### 6.4 Verwijzing naar documentatie

- security-and-privacy.md
- governance.md

---

## 7. AVG – Algemene Verordening Gegevensbescherming

### 7.1 Relevantie

De AVG stelt eisen aan verwerking van persoonsgegevens.

### 7.2 Architecturale interpretatie

Binnen dit ecosysteem betekent dit:
- dataminimalisatie
- doelbinding
- transparantie
- verantwoording

### 7.3 Borging in het ecosysteem

- cockpit verwerkt geen inhoudelijke gegevens
- alleen noodzakelijke metadata wordt gebruikt: de MDTO-gegevens uit de Stekker API, zonder de ruwe stekkerpayload (ADR-0005)
- volledige audittrail van besluiten
- duidelijke rollen en verantwoordelijkheden
- de werkkopie van een dossier wordt na archivering en een instelbare termijn automatisch verwijderd; er blijft een grafsteen zonder persoonsgegevens (ADR-0006)
- het blijvend bewaarde dossier krijgt een expliciete gebruiksbeperking (`beperkingGebruik`) voor persoonsgegevens

### 7.4 Verwijzing naar documentatie

- security-and-privacy.md
- architectuur.md
- glossary.md

---

## 8. Archiefwet

### 8.1 Relevantie

De Archiefwet vormt de grondslag voor selectie en vernietiging.

### 8.2 Architecturale interpretatie

De architectuur **moet** ondersteunen:
- normatieve besluitvorming op basis van de vastgestelde selectielijst
- gecontroleerde uitvoering
- aantoonbare vernietiging, met een verklaring volgens art. 8 Archiefbesluit 1995: specificatie van de vernietigde archiefbescheiden, wijze en tijdstip van vernietiging
- reproduceerbaarheid
- duurzame toegankelijkheid van het vernietigingsdossier zelf

### 8.3 Borging in het ecosysteem

- workflow met vaste accorderingsstappen (recordmanager, proceseigenaar, archivaris)
- vernietigingsdossiers als MDTO-informatieobject, waardering *Blijvend te bewaren* (ADR-0005)
- per kandidaat de informatiecategorie uit de vastgestelde selectielijst, de waardering en een controleerbare bewaartermijn (trigger, startdatum, looptijd, einddatum)
- per vernietigde kandidaat het MDTO-event *Vernietigen* met tijdstip en een MDTO-specificatie, per uitvoering de vernietigingsmethode
- verklaring van vernietiging (PDF/A-2b) met alle accorderingen
- archivering van bewijslast als MDTO-XML-pakket in een aangewezen archief- of zaaksysteem

### 8.4 Verwijzing naar documentatie

- architectuur-cockpit.md
- sequence-diagrammen.md
- rollen-en-verantwoordelijkheden.md
- adr/0005-adr-mdto-leidend.md, adr/0006-adr-verwijderen-werkkopie-dossier.md, adr/0007-adr-identiteit-snapshots-aggregaties.md

## 8a. MDTO – Metagegevens voor duurzaam toegankelijke overheidsinformatie

### 8a.1 Relevantie

MDTO is de standaard van het Nationaal Archief voor het vastleggen en uitwisselen van metagegevens van informatieobjecten, en de opvolger van TMLO. Archief- en zaaksystemen en e-depots verwachten MDTO.

### 8a.2 Architecturale interpretatie

MDTO is leidend voor benaming, begrippen en informatiemodel in alle lagen: documentatie, Stekker API, datamodel, auditlog, verklaring, archiefpakket en UI-labels (ADR-0005).

### 8a.3 Borging in het ecosysteem

- de Stekker API v2 gebruikt MDTO-namen en -structuren (`api-informatiemodel.md`)
- eigen begrippen staan in gepubliceerde, geversioneerde begrippenlijsten (`designrules/begrippenlijsten/`)
- het vernietigingsdossier en zijn onderdelen worden als MDTO-XML 1.0.1 gearchiveerd
- stekkerspecificaties worden gevalideerd tegen de MDTO-XSD

### 8a.4 Verwijzing naar documentatie

- adr/0005-adr-mdto-leidend.md
- designrules/api/api-informatiemodel.md
- designrules/begrippenlijsten/README.md

---

## 9. Gebruik en verantwoordelijkheid

Dit document:
- ondersteunt audits en toezicht
- biedt inzicht in architecturale borging
- vervangt geen lokale compliance toets

De eindverantwoordelijkheid voor naleving **blijft bij de deelnemende organisatie**.