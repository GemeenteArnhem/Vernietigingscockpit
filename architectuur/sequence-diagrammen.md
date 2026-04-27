# Sequence diagrams – Vernietigingscockpit ecosysteem

Dit document bevat sequence diagrams van de belangrijkste processen binnen het Vernietigingscockpit ecosysteem.
De diagrammen zijn bedoeld om interactie, verantwoordelijkheden en volgorde van stappen inzichtelijk te maken.

---

## 1. Overzicht kernprocessen

De volgende kernprocessen worden beschreven:
- aanmaken en plannen van een vernietigingstaak
- ophalen van vernietigingskandidaten
- beoordeling en accordering
- starten van vernietiging
- afronding en verklaring van vernietiging

## 2. Aanmaken en plannen van een vernietigingstaak

Dit diagram beschrijft hoe een recordmanager een vernietigingstaak aanmaakt op basis van een sjabloon.

```mermaid
sequenceDiagram
    actor RM as Recordmanager
    participant UI as Cockpit UI
    participant Task as Taak en Sjabloonbeheer
    participant WF as Workflow Engine
    participant D as Dossierbeheer

    RM ->> UI: Maak nieuwe vernietigingstaak aan
    UI ->> Task: Selecteer sjabloon en parameters
    Task ->> WF: Initialiseer workflow
    Task ->> D: Registreer taak en parameters
    WF -->> UI: Taak aangemaakt en gepland
```

## 3. Ophalen van vernietigingskandidaten
Dit diagram beschrijft hoe de cockpit vernietigingskandidaten ophaalt bij stekkers.

```mermaid
sequenceDiagram
    actor RM as Recordmanager
    participant UI as Cockpit UI
    participant WF as Workflow Engine
    participant Stekker
    participant D as Dossierbeheer

    RM ->> UI: Ophalen van selectie
    UI ->> WF: Activeer stap "selectie ophalen"

    WF ->> D: Registreer selectiecontext (regels, peildatum)
    WF ->> Stekker: GET selecties/latest

    Stekker -->> WF: Vernietigingskandidaten
    WF ->> D: Sla Vernietigingskandidaten op

    UI ->> D: Vraag Vernietiginglijst (concept) op
    D -->> UI: Vernietiginglijst (concept)
    UI -->> RM: Toon vernietiginglijst (concept)
```

Belangrijk:
- selectie is operationeel
- landelijke selectielijst interpretatie vindt plaats in de stekker
- cockpit slaat vernietigingskandidaten op als vernietigingslijst (concept), maar bepaalt ze niet
- vernietingslijst is een momentopname
- cockpit slaat deze op als dossier
- latere wijzigingen in bron hebben geen invloed op deze snapshot

## 4. Beoordeling door recordmanager
Dit diagram toont de beoordeling van vernietigingskandidaten door de recordmanager.

```mermaid
sequenceDiagram
    actor RM as Recordmanager
    participant UI as Cockpit UI
    participant D as Dossierbeheer

    RM ->> UI: Bekijk vernietigingslijst (concept)
    RM ->> UI: Sluit objecten uit + toelichting
    UI ->> D: Leg uitsluitingen en toelichtingen vast
    D ->> D: Update status per object
    D -->> UI: Dossier bijgewerkt
```

Belangrijk:
- uitsluitingen zijn normatief
- elke uitsluiting heeft een toelichting
- alles wordt vastgelegd in het dossier

## 5. Accordering door proceseigenaar en archivaris
Dit diagram beschrijft de twee staps accordering.

Belangrijk:
- functiescheiding is verplicht
- volgorde ligt vast in de workflow
- accordering is onderdeel van het dossier

### 5a. Accordering door proceseigenaar

```mermaid
sequenceDiagram
    actor PO as Proceseigenaar
    participant UI as Cockpit UI
    participant D as Dossierbeheer
    participant WF as Workflow Engine

    PO ->> UI: Bekijk vernietigingslijst (accordering) en toelichtingen
    UI ->> D: Haal dossier + vernietigingskandidaten op
    D -->> UI: Vernietigingslijst + toelichtingen
    UI -->> PO: Toon vernietigingskandidaten

    PO ->> UI: Voeg toelichting toe (optioneel)
    UI ->> D: Sla toelichting op

    alt Akkoord
        PO ->> UI: Keur taak goed
        UI ->> D: Leg accordering proceseigenaar vast
        D ->> WF: Update workflowstatus (naar archivaris)
    else Terugsturen
        PO ->> UI: Stuur terug naar recordmanager
        UI ->> D: Leg terugkoppeling vast (met toelichting)
        D ->> WF: Update workflowstatus (terug naar RM)
    end
```

### 5b. Accordering door gemeentarchivaris

```mermaid
sequenceDiagram
    actor AR as Archivaris
    participant UI as Cockpit UI
    participant D as Dossierbeheer
    participant WF as Workflow Engine

    AR ->> UI: Bekijk vernietigingslijst (accorering) en toelichtingen
    UI ->> D: Haal dossier + vernietigingskandidaten op
    D -->> UI: Vernietigingslijst + toelichtingen
    UI -->> AR: Toon vernietigingskandidaten

    AR ->> UI: Voeg toelichting toe (optioneel)
    UI ->> D: Sla toelichting op

    alt Akkoord (finale accordering)
        AR ->> UI: Keur taak definitief goed
        UI ->> D: Leg accordering archivaris vast
        D ->> WF: Update workflowstatus (gereed voor vernietiging)
    else Terugsturen
        AR ->> UI: Stuur terug naar recordmanager
        UI ->> D: Leg terugkoppeling vast (met toelichting)
        D ->> WF: Update workflowstatus (terug naar RM)
    end
```

## 6. Uitvoeren van vernietiging
Dit diagram beschrijft hoe de cockpit vernietiging vrijgeeft en start.

```mermaid
sequenceDiagram
    actor RM as Recordmanager
    participant UI as Cockpit UI
    participant D as Dossierbeheer
    participant WF as Workflow Engine
    participant Stekker

    RM ->> UI: Geef opdracht tot vernietiging
    UI ->> D: Leg vernietigingsbesluit vast
    D ->> WF: Activeer uitvoeringsstap

    WF ->> D: Haal goedgekeurde objecten op
    WF ->> WF: Split in batches (batchNummer)

    loop Per batch
        WF ->> Stekker: Vernietig(batchNummer, lijstMetObjectIds)
        Stekker -->> WF: Ontvangstbevestiging (async gestart)
    end

    loop Polling resultaten
        WF ->> Stekker: Vraag status/resultaten(batchNummer)
        Stekker -->> WF: Resultaten per object (incl. afwijkingen)
        WF ->> D: Registreer resultaten per object
    end

    UI ->> D: Vraag uitvoeringsresultaten op
    D -->> UI: Resultaten per object + status
    UI -->> RM: Toon resultaten vernietiging
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
    participant WF as Workflow Engine
    participant D as Dossierbeheer
    participant UI as Cockpit UI
    actor RM as Recordmanager

    Stekker ->> Retry: Fout bij vernietiging
    Retry ->> Stekker: Retry actie
    Retry -->> Stekker: Definitieve status per object

    Stekker -->> WF: Status update (incl. fouten)
    WF ->> D: Registreer status per object

    UI ->> D: Vraag status en fouten op
    D -->> UI: Resultaten per object + foutstatus
    UI -->> RM: Toon fouten en status
```

Belangrijk:
- retries vinden plaats in de stekker
- cockpit registreert resultaten
- handmatige opvolging is mogelijk

## 8. Genereren van verklaring van vernietiging
Dit diagram beschrijft de afronding van het proces.

```mermaid
sequenceDiagram
    actor RM as Recordmanager
    participant UI as Cockpit UI
    participant WF as Workflow Engine
    participant D as Dossierbeheer
    participant V as Verklaring en Archivering
    participant Z as Archiefsysteem

    RM ->> UI: Rond taak af / genereer verklaring
    UI ->> WF: Activeer stap "afronding"

    WF ->> D: Valideer dossier compleet
    D -->> WF: Dossier compleet

    WF ->> V: Genereer vernietigingsverklaring
    V ->> D: Registreer verklaring

    V ->> Z: Archiveer verklaring als zaak
    Z -->> V: Bevestiging archivering

    UI ->> D: Vraag verklaring op
    D -->> UI: Verklaring + metadata
    UI -->> RM: Toon / download verklaring
```

Belangrijk:
- verklaring bevat besluiten en uitvoering
- archivering vormt juridisch bewijs
- proces is hiermee formeel afgesloten

## 9. Overzicht processen  – Functioneel beheerder
- Beheer van stekkers (configuratie)
- Gebruikers- en rollenbeheer
- Monitoring en logging
- Configuratiebeheer
- Versie- en wijzigingsbeheer

## 10. Configureren van een stekker
Dit diagram beschrijft de configuratie van stekkers

```mermaid
sequenceDiagram
    actor FB as Functioneel Beheerder
    participant UI as Cockpit UI
    participant C as Configuratiebeheer
    participant D as Dossierbeheer

    FB ->> UI: Configureer stekker (parameters, mapping)
    UI ->> C: Sla configuratie op
    C ->> D: Registreer configuratiewijziging (versie, tijd, actor)
    C -->> UI: Bevestiging configuratie
```

## 11 Gebruikers en rollen beheren
Dit diagram beschrijft de configuratie van gebruikers en rollen

```mermaid
sequenceDiagram
    actor FB as Functioneel Beheerder
    participant UI as Cockpit UI
    participant IAM as Auth & Rollen

    FB ->> UI: Beheer gebruikers en rollen
    UI ->> IAM: Maak/wijzig gebruiker + roltoewijzing
    IAM -->> UI: Bevestiging
```

## 12 Inzien logging en monitoring
Dit diagram beschrijft de configuratie van gebruikers en rollen

```mermaid
sequenceDiagram
    actor FB as Functioneel Beheerder
    participant UI as Cockpit UI
    participant D as Dossierbeheer
    participant LOG as Logging/Monitoring

    FB ->> UI: Bekijk logging / monitoring
    UI ->> LOG: Vraag systeemlogs op
    LOG -->> UI: Logs en events

    UI ->> D: Vraag proces- en auditinformatie op
    D -->> UI: Audittrail en status
    UI -->> FB: Toon overzicht
```