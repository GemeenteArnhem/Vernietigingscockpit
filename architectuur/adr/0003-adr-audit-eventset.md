# ADR 0003 – Audit-eventset en verifieerbare keten

## Status
Voorgesteld (concept, nog vast te stellen)

## Datum
2026-10-02

## Context

`ui-spec/state/audit-event-model.md` noemt een "enige geldige set" actienamen. Andere documenten en de implementatie wijken daarvan af:

- `ui-spec/state/task-state-machine.md` noemt ook `DESTRUCTION_APPROVED_BY_ARCHIVIST` en `DESTRUCTION_ORDERED_BY_RM` (gevolg van ADR-0002, status `vrijgegeven`);
- de cockpit-code gebruikt Nederlandse namen (`BEOORDELING_VOORGELEGD`, `ACCORDERING_PO_AKKOORD`, `KANDIDAAT_BEOORDEELD`, …);
- voor een aantal handelingen heeft de set geen naam: voorleggen, opnieuw proberen (selectie en vernietiging), het besluit per kandidaat en het definitief mislukken van een vernietigingsopdracht;
- configuratie-events (ADR-0002, `configuratie_event`) staan niet in de set.

Daarnaast is de hashketen van het auditlog nu één globale keten zonder vergrendeling. Gelijktijdige acties maken vertakkingen, en de hash dekt niet alle kolommen (`tijdstip`, `rol`, `actor_type`). De keten is daardoor niet verifieerbaar.

## Beslissing

### 1. Eventset

De set uit `audit-event-model.md` blijft de basis. De namen hieronder zijn de volledige, normerende set; **vet** zijn aanvullingen op het model. Een event onderscheidt het niveau via `entiteit_type` (`taakinstantie` of `vernietigingskandidaat`) en de besluitnemer via `rol`.

| Actie | Actor | Entiteit | Wanneer | Vervangt (code tot nu toe) |
|---|---|---|---|---|
| TASK_CREATED | gebruiker (RM) | taakinstantie | taakinstantie aangemaakt | `TAAK_INSTANTIE_AANGEMAAKT` (configuratie_event) |
| SELECTION_REQUESTED | gebruiker (RM) | taakinstantie | selectie gestart | (ongewijzigd) |
| **SELECTION_RETRY_REQUESTED** | gebruiker (RM) | taakinstantie | mislukte selectie opnieuw gestart | (ongewijzigd) |
| SELECTION_COMPLETED | systeem | taakinstantie | alle selecties geïmporteerd: `init → beoordeling` | (nieuw in code) |
| OBJECT_INCLUDED | gebruiker (RM) | vernietigingskandidaat | kandidaat akkoord | `KANDIDAAT_BEOORDEELD` |
| OBJECT_EXCLUDED | gebruiker (RM) | vernietigingskandidaat | kandidaat uitgesloten (met reden) | `KANDIDAAT_BEOORDEELD` |
| **REVIEW_SUBMITTED** | gebruiker (RM) | taakinstantie | `beoordeling → accordering_po` | `BEOORDELING_VOORGELEGD` |
| APPROVAL_GRANTED | gebruiker (PO/archivaris) | vernietigingskandidaat | akkoord per kandidaat | `ACCORDERING_*_KANDIDAAT_BESLUIT` |
| APPROVAL_REJECTED | gebruiker (PO/archivaris) | vernietigingskandidaat | retour per kandidaat | `ACCORDERING_*_KANDIDAAT_BESLUIT` |
| APPROVAL_GRANTED | gebruiker (PO) | taakinstantie | `accordering_po → accordering_archivaris` | `ACCORDERING_PO_AKKOORD` |
| APPROVAL_REJECTED | gebruiker (PO/archivaris) | taakinstantie | terug naar `beoordeling` (nieuwe ronde) | `ACCORDERING_*_RETOUR` |
| DESTRUCTION_APPROVED_BY_ARCHIVIST | gebruiker (archivaris) | taakinstantie | `accordering_archivaris → vrijgegeven` | `ACCORDERING_ARCHIVARIS_AKKOORD` |
| DESTRUCTION_ORDERED_BY_RM | gebruiker (RM) | taakinstantie | `vrijgegeven → uitvoering` | `VERNIETIGINGSOPDRACHT_GEGEVEN` |
| EXECUTION_STARTED | systeem | taakinstantie | vernietiging bij een stekker aangemaakt | (nieuw in code) |
| BATCH_STARTED | systeem | batch (`vernietigingId:batchnummer`) | batch naar de stekker gestuurd | (nieuw in code) |
| BATCH_COMPLETED | systeem | batch (`vernietigingId:batchnummer`) | batch door de stekker verwerkt | (nieuw in code) |
| OBJECT_PROCESSED | systeem | vernietigingskandidaat | resultaat `SUCCESS` | (nieuw in code) |
| OBJECT_FAILED | systeem | vernietigingskandidaat | resultaat `FAILED`, `NOT_FOUND`, `CHANGED` of `SKIPPED` | (nieuw in code) |
| **EXECUTION_FAILED** | systeem | taakinstantie | vernietigingsopdracht voor een stekker definitief mislukt | (nieuw in code) |
| **EXECUTION_RETRY_REQUESTED** | gebruiker (RM) | taakinstantie | mislukte opdracht opnieuw gestart | (ongewijzigd) |
| EXECUTION_COMPLETED | systeem | taakinstantie | `uitvoering → resultaat` | (nieuw in code) |
| CERTIFICATE_GENERATED | gebruiker (RM) | taakinstantie | verklaring gegenereerd | (ongewijzigd) |
| **ARCHIVING_REQUESTED** | gebruiker (RM) | taakinstantie | archivering van het dossier aangevraagd (CC-18) | (nieuw) |
| **ARCHIVING_FAILED** | systeem | taakinstantie | archivering definitief mislukt; opnieuw archiveren kan | (nieuw) |
| TASK_COMPLETED | systeem (na aanvraag door RM) | taakinstantie | dossier gearchiveerd: `resultaat → archief` | (nieuw in code) |

`TASK_STARTED` en `OBJECT_UPDATED` uit het model vervallen: het starten van een taak is `SELECTION_REQUESTED`, en een kandidaat verandert alleen via de events hierboven.

Configuratie-events (`configuratie_event`), in dezelfde stijl:

| Actie | Wanneer | Vervangt |
|---|---|---|
| **MASTER_DATA_IMPORTED** | stamgegevens geïmporteerd | `STAMGEGEVENS_GEIMPORTEERD` |
| **TASK_DEFINITION_CREATED** | taakdefinitie aangemaakt | `TAAKDEFINITIE_AANGEMAAKT` |
| **USER_LINKED** | een gebruiker (OIDC `sub`) is eenmalig aan een medewerker gekoppeld (CC-12) | (nieuw) |

Nieuwe acties komen er alleen via een wijziging van deze ADR.

### 2. Verifieerbare keten

- `audit_event` heeft één keten **per taakinstantie**; `configuratie_event` één globale keten.
- Vóór het lezen van de vorige hash neemt de schrijver een transactie-advisory-lock op de keten, zodat er geen vertakkingen ontstaan.
- De hash is SHA-256 over canonieke JSON (sleutels gesorteerd) van alle kolommen behalve `id` en `hash`, inclusief `tijdstip`, `actor_type`, `rol` en `vorige_hash`.
- `rol` is de rol waarmee de actie is uitgevoerd, niet een afgeleide.
- De API biedt `GET /taken/{id}/auditlog` (gepagineerd) en `GET /taken/{id}/auditlog/verificatie`, voor betrokkenen bij de taak en de auditor.

### 3. Databasebescherming

- De applicatie verbindt met een eigen databaserol (lid van `cockpit_app`) die op `audit_event` en `configuratie_event` alleen `SELECT` en `INSERT` heeft.
- Migraties draaien als eigenaar.
- Naast de bestaande `UPDATE`/`DELETE`-trigger weigert een `TRUNCATE`-trigger het legen van de tabellen, ook voor de eigenaar.

## Overwegingen

- Eén Engelstalige set voor UI, export en compliance; de spec is al Engelstalig.
- Besluitniveau en rol staan in vaste kolommen (`entiteit_type`, `rol`). Daardoor zijn er geen aparte namen per rol nodig, behalve waar de state machine ze al noemt (ADR-0002).
- Een keten per taak houdt verificatie en vergrendeling lokaal; taken blokkeren elkaar niet.

## Alternatieven

- Alleen de oorspronkelijke set gebruiken: voorleggen en opnieuw proberen hebben dan geen eigen naam, wat de reconstructie onduidelijk maakt.
- De Nederlandse codenamen vastleggen: dat wijkt af van de spec en de UI-teksten.
- Eén globale keten met een tabel-lock: dat serialiseert alle schrijvers in de hele applicatie.

## Gevolgen

- De bestaande audit-data is testdata; de overstap begint met een lege `audit_event` en `configuratie_event` (de migratie controleert dat).
- De UI toont actienamen niet zelf vertaald; een weergavetabel is een UI-besluit.
- Beheer: er zijn twee databaseverbindingen nodig (migratie als eigenaar en de app-rol).
