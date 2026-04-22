# Sequence diagrams – Vernietigingscockpit ecosysteem

Dit document bevat sequence diagrams van de belangrijkste processen binnen het Vernietigingscockpit ecosysteem.
De diagrammen zijn bedoeld om interactie, verantwoordelijkheden en volgorde van stappen inzichtelijk te maken.

De diagrams zijn logisch, niet technisch gedetailleerd.
Ze gebruiken Mermaid en zijn direct renderbaar in GitHub.

---

## 1. Overzicht kernprocessen

De volgende kernprocessen worden beschreven:
- aanmaken en plannen van een vernietigingstaak
- ophalen van vernietigingskandidaten
- beoordeling en accordering
- starten van vernietiging
- afronding en verklaring van vernietiging

---

## 2. Aanmaken en plannen van een vernietigingstaak

Dit diagram beschrijft hoe een recordmanager een vernietigingstaak aanmaakt op basis van een sjabloon.

```mermaid
sequenceDiagram
    actor RM as Recordmanager
    participant UI as Cockpit UI
    participant Task as Taak en Sjabloonbeheer
    participant WF as Workflow Engine

    RM ->> UI: Maak nieuwe vernietigingstaak aan
    UI ->> Task: Selecteer sjabloon en parameters
    Task ->> WF: Initialiseer workflow
    WF -->> UI: Taak aangemaakt en gepland
```

## 3. Ophalen van vernietigingskandidaten
Dit diagram beschrijft hoe de cockpit kandidaten ophaalt bij stekkers.

```mermaid
sequenceDiagram
    participant WF as Workflow Engine
    participant Conn as Stekker Connectie
    participant Stekker

    WF ->> Conn: Start selectie
    Conn ->> Stekker: GeefKandidaatVernietigingslijst
    Stekker -->> Conn: Kandidatenlijst + metadata
    Conn -->> WF: Gevalideerde kandidatenlijst
```

Belangrijk:
- selectie is operationeel
- landelijke selectielijst interpretatie vindt plaats in de stekker
- cockpit slaat kandidaten op, maar bepaalt ze niet

## 4. Beoordeling door recordmanager
Dit diagram toont de beoordeling van kandidaten door de recordmanager.

```mermaid
sequenceDiagram
    actor RM as Recordmanager
    participant UI as Cockpit UI
    participant D as Kandidaten en Dossierbeheer

    RM ->> UI: Bekijk kandidatenlijst
    RM ->> UI: Sluit objecten uit + toelichting
    UI ->> D: Sla uitsluitingen en toelichtingen op
    D -->> UI: Dossier bijgewerkt
```

Belangrijk:
- uitsluitingen zijn normatief
- elke uitsluiting heeft een toelichting
- alles wordt vastgelegd in het dossier

## 5. Accordering door proceseigenaar en archivaris
Dit diagram beschrijft de twee staps accordering.

```mermaid
sequenceDiagram
    actor PO as Proceseigenaar
    actor AR as Archivaris
    participant UI as Cockpit UI
    participant WF as Workflow Engine
    participant D as Dossierbeheer

    PO ->> UI: Beoordeel taak
    UI ->> WF: Registreer akkoord proceseigenaar
    WF ->> D: Log accordering

    AR ->> UI: Beoordeel taak
    UI ->> WF: Registreer akkoord archivaris
    WF ->> D: Log accordering
```

Belangrijk:
- functiescheiding is verplicht
- volgorde ligt vast in de workflow
- accordering is onderdeel van het dossier


## 6. Starten van vernietiging
Dit diagram beschrijft hoe de cockpit vernietiging vrijgeeft en start.

```mermaid
sequenceDiagram
    participant WF as Workflow Engine
    participant Conn as Stekker Connectie
    participant Stekker
    participant D as Dossierbeheer

    WF ->> Conn: Start vernietiging goedgekeurde objecten
    Conn ->> Stekker: Vernietig(lijstMetObjectIds)
    Stekker -->> Conn: Resultaten per object
    Conn -->> WF: Uitvoeringsresultaat
    WF ->> D: Sla uitvoeringsresultaten op
```

Belangrijk:
- alleen expliciet goedgekeurde objecten worden vernietigd
- vernietiging is idempotent
- resultaten worden per object vastgelegd

## 7. Fouten en retries bij vernietiging
Dit diagram laat een vereenvoudigd foutpad zien.

```mermaid
sequenceDiagram
    participant Stekker
    participant Retry as Retry en Foutafhandeling
    participant Conn as Stekker Connectie
    participant D as Dossierbeheer

    Stekker ->> Retry: Fout bij vernietiging
    Retry ->> Stekker: Retry actie
    Retry -->> Conn: Definitieve status per object
    Conn ->> D: Registreer failure of skip
```

Belangrijk:
- retries vinden plaats in de stekker
- cockpit registreert resultaten
- handmatige opvolging is mogelijk

## 8. Genereren van verklaring van vernietiging
Dit diagram beschrijft de afronding van het proces.

```mermaid
sequenceDiagram
    participant WF as Workflow Engine
    participant D as Dossierbeheer
    participant V as Verklaring en Archivering
    participant Z as Zaaksysteem

    WF ->> D: Controleer taak afgerond
    WF ->> V: Genereer vernietigingsverklaring
    V ->> Z: Archiveer verklaring als zaak
    Z -->> V: Bevestiging archivering
```
	
Belangrijk:
- verklaring bevat besluiten en uitvoering
- archivering vormt juridisch bewijs
- proces is hiermee formeel afgesloten