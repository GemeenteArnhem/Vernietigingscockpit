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
- afronding, verklaring en archiveren van vernietiging

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
Dit diagram beschrijft hoe de cockpit een selectie start bij een stekker en de lijst met vernietigingskandidaten ophaalt.

```mermaid
sequenceDiagram
    actor RM as Recordmanager
    participant UI as Cockpit UI
    participant WF as Workflow Engine
    participant Stekker
    participant D as Dossierbeheer

    RM ->> UI: Start ophalen vernietigingskandidaten
    UI ->> WF: Activeer stap "selectie ophalen"

    WF ->> D: Registreer selectiecontext (taak, scope, peildatum)
    WF ->> Stekker: POST /selecties
    Stekker -->> WF: selectieId + status

    loop Tot selectie gereed is
        WF ->> Stekker: GET /selecties/{selectieId}
        Stekker -->> WF: Status selectie
    end

    loop Per pagina
        WF ->> Stekker: GET /selecties/{selectieId}/objecten
        Stekker -->> WF: Vernietigingskandidaten + metadata
        WF ->> D: Sla vernietigingskandidaten op
    end

    UI ->> D: Vraag lijst met vernietigingskandidaten op
    D -->> UI: Lijst met vernietigingskandidaten + status
    UI -->> RM: Toon lijst met vernietigingskandidaten
```

Belangrijk:
- selectie is operationeel
- landelijke selectielijstinterpretatie vindt plaats in de stekker
- de stekker bepaalt vernietigingskandidaten
- de cockpit legt vernietigingskandidaten vast, maar bepaalt ze niet.
- de selectie is herleidbaar via `selectieId`

## 4. Beoordeling door recordmanager
Dit diagram toont de beoordeling van vernietigingskandidaten door de recordmanager.
Dit diagram toont de beoordeling van vernietigingskandidaten door de recordmanager.

```mermaid
sequenceDiagram
    actor RM as Recordmanager
    participant UI as Cockpit UI
    participant D as Dossierbeheer

    RM ->> UI: Bekijk lijst met vernietigingskandidaten
    RM ->> UI: Sluit informatieobjecten uit + toelichting
    UI ->> D: Leg uitsluitingen en toelichtingen vast
    D ->> D: Update status per informatieobject
    D -->> UI: Dossier bijgewerkt
```

Belangrijk:
- uitsluitingen zijn normatief
- elke uitsluiting heeft een toelichting
- alles wordt vastgelegd in het dossier

## 5. Accordering door proceseigenaar en archivaris
Dit diagram beschrijft de tweestapsaccordering.

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

    PO ->> UI: Bekijk vernietigingskandidaten en toelichtingen
    UI ->> D: Haal dossier + vernietigingskandidaten op
    D -->> UI: Lijst met vernietigingskandidaten + toelichtingen
    UI -->> PO: Toon vernietigingskandidaten

    PO ->> UI: Voeg toelichting toe (optioneel)
    UI ->> D: Sla toelichting op

    alt Akkoord
        PO ->> UI: Keur vernietigingslijst (accordering) goed
        UI ->> D: Leg accordering proceseigenaar vast
        D ->> WF: Update workflowstatus (naar archivaris)
    else Terugsturen
        PO ->> UI: Stuur terug naar recordmanager
        UI ->> D: Leg terugkoppeling vast (met toelichting)
        D ->> WF: Update workflowstatus (terug naar RM)
    end
```

### 5b. Accordering door gemeentearchivaris

```mermaid
sequenceDiagram
    actor AR as Archivaris
    participant UI as Cockpit UI
    participant D as Dossierbeheer
    participant WF as Workflow Engine

    AR ->> UI: Bekijk vernietigingskandidaten en toelichtingen
    UI ->> D: Haal dossier + vernietigingskandidaten op
    D -->> UI: Lijst met vernietigingskandidaten + toelichtingen + toelichtingen
    UI -->> AR: Toon vernietigingskandidaten

    AR ->> UI: Voeg toelichting toe (optioneel)
    UI ->> D: Sla toelichting op

    alt Akkoord (finale accordering)
        AR ->> UI: Keur vernietigingslijst (accordering) goed
        UI ->> D: Leg accordering archivaris vast
        D ->> WF: Update workflowstatus (gereed voor vernietiging)
    else Terugsturen
        AR ->> UI: Stuur terug naar recordmanager
        UI ->> D: Leg terugkoppeling vast (met toelichting)
        D ->> WF: Update workflowstatus (terug naar RM)
    end
```

## 6. Uitvoeren van vernietiging
Dit diagram beschrijft hoe de cockpit vernietiging vrijgeeft, een vernietiging start en batches aanbiedt aan de stekker.

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

    WF ->> D: Haal vrijgegeven informatieobjecten op
    WF ->> Stekker: POST /vernietigingen
    Stekker -->> WF: vernietigingId + status

    loop Per batch
        WF ->> Stekker: POST /vernietigingen/{vernietigingId}/batches
        Stekker -->> WF: Batch geaccepteerd
    end

    loop Tot vernietiging afgerond is
        WF ->> Stekker: GET /vernietigingen/{vernietigingId}
        Stekker -->> WF: Status vernietiging
    end

    loop Per batchresultaat
        WF ->> Stekker: GET /vernietigingen/{vernietigingId}/batches/{batchNummer}
        Stekker -->> WF: Uitvoeringsresultaten per aangeboden informatieobject
        WF ->> D: Registreer uitvoeringsresultaten
    end

    UI ->> D: Vraag uitvoeringsresultaten op
    D -->> UI: Uitvoeringsresultaten + status
    UI -->> RM: Toon resultaten vernietiging
```

Belangrijk:
- alleen expliciet vrijgegeven informatieobjecten worden aangeboden voor vernietiging
- vernietiging wordt asynchroon uitgevoerd
- batches zijn technische verdelingen van de uitvoering
- de POST op een batch bevestigt acceptatie, maar bevat nog geen definitieve uitvoeringsresultaten
- resultaten worden per aangeboden informatieobject vastgelegd
- de vernietiging is herleidbaar via `vernietigingId`

## 7. Fouten en retries bij vernietiging
Dit diagram laat een vereenvoudigd foutpad zien bij batchverwerking.

```mermaid
sequenceDiagram
    participant Stekker
    participant Retry as Retry en Foutafhandeling
    participant WF as Workflow Engine
    participant D as Dossierbeheer
    participant UI as Cockpit UI
    actor RM as Recordmanager

    Stekker ->> Retry: Fout bij verwerking van batch of informatieobject
    Retry ->> Stekker: Retry binnen dezelfde vernietigingId en batchNummer
    Retry -->> Stekker: Definitieve status per aangeboden informatieobject

    WF ->> Stekker: GET /vernietigingen/{vernietigingId}/batches/{batchNummer}
    Stekker -->> WF: Uitvoeringsresultaten inclusief fouten
    WF ->> D: Registreer uitvoeringsresultaten per informatieobject

    UI ->> D: Vraag status en fouten op
    D -->> UI: Uitvoeringsresultaten + foutstatus
    UI -->> RM: Toon fouten en status
```

Belangrijk:
- retries vinden plaats in de stekker
- retries blijven gekoppeld aan dezelfde `vernietigingId` en `batchNummer`
- cockpit registreert definitieve uitvoeringsresultaten
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

    V ->> Z: Archiveer verklaring
    Z -->> V: Bevestiging archivering

    UI ->> D: Vraag verklaring op
    D -->> UI: Verklaring + metadata
    UI -->> RM: Toon / download verklaring
```

Belangrijk:
- verklaring bevat besluiten en uitvoering
- archivering ondersteunt juridisch bewijs
- proces is hiermee formeel afgesloten

## 9. Overzicht processen  – Functioneel beheerder
- Beheer van stekkers (configuratie)
- Gebruikers- en rollenbeheer
- Monitoring en logging
- Configuratiebeheer
- Versie- en wijzigingsbeheer

## 10. Configureren van een stekker
Dit diagram beschrijft de configuratie van stekkers.

```mermaid
sequenceDiagram
    actor FB as Functioneel Beheerder
    participant UI as Cockpit UI
    participant C as Configuratiebeheer
    participant D as Dossierbeheer

    FB ->> UI: Configureer stekkerkoppeling (endpoint, autorisatie, versie, parameters)
    UI ->> C: Sla configuratie op
    C ->> D: Registreer configuratiewijziging (versie, tijd, actor)
    C -->> UI: Bevestiging configuratie
```

## 11. Gebruikers en rollen beheren
Dit diagram beschrijft de configuratie van gebruikers en rollen.

```mermaid
sequenceDiagram
    actor FB as Functioneel Beheerder
    participant UI as Cockpit UI
    participant IAM as Auth & Rollen

    FB ->> UI: Beheer gebruikers en rollen
    UI ->> IAM: Maak/wijzig gebruiker + roltoewijzing
    IAM -->> UI: Bevestiging
```

## 12. Inzien logging en monitoring
Dit diagram beschrijft het inzien van logging en monitoring.

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