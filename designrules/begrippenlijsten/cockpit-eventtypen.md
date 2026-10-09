# Begrippenlijst Cockpit-eventtypen

| Kenmerk | Waarde |
|---|---|
| Naam | Cockpit-eventtypen |
| Identificatie | `urn:vernietigingscockpit:begrippenlijst:cockpit-eventtypen:1.0` |
| Versie | 1.0 |
| Type | Open |
| Basis | ADR-0005 §5 (wijzigt ADR-0003 §1) |

Eventtypen voor het auditlog van een taakinstantie (`audit_event`), voor gebeurtenissen waarvoor de **MDTO EventTypeLijst** geen begrip heeft.

## MDTO-eventtypen in het auditlog

Deze komen uit de MDTO EventTypeLijst en staan hier **niet** opnieuw gedefinieerd. Ze zijn hier alleen opgesomd, met hun gebruik:

| MDTO-label | Gebruik in de cockpit | `entiteit_type` |
|---|---|---|
| Creatie | Taakinstantie (vernietigingsdossier) aangemaakt; verklaring van vernietiging (nieuwe versie) gemaakt | taakinstantie, verklaring |
| Import | Selectie van een stekker geïmporteerd: alle selecties gereed, `init → beoordeling` | taakinstantie |
| Accordering | Akkoord van proceseigenaar of archivaris, per kandidaat of op de lijst | vernietigingskandidaat, taakinstantie |
| Bevriezing | Vernietigingslijst bevroren bij de vrijgave door de archivaris (`lijstHash`) | taakinstantie |
| Vernietigen | Stekker meldt `SUCCESS` voor een kandidaat; `eventTijd` van de stekker in de details | vernietigingskandidaat |
| Export | Dossier geëxporteerd naar het archiefsysteem: `resultaat → archief` | taakinstantie |

## Eigen eventtypen

| Label | Definitie | Actor | `entiteit_type` | Vervangt (ADR-0003) |
|---|---|---|---|---|
| Selectie aangevraagd | De recordmanager heeft de selectie bij de stekker(s) gestart. | gebruiker | taakinstantie | SELECTION_REQUESTED |
| Selectie opnieuw aangevraagd | Een mislukte selectie is opnieuw gestart; het oude selectierecord is vervangen. | gebruiker | taakinstantie | SELECTION_RETRY_REQUESTED |
| Kandidaat opgenomen | De recordmanager neemt de kandidaat op in de vernietigingslijst. | gebruiker | vernietigingskandidaat | OBJECT_INCLUDED |
| Kandidaat uitgesloten | De kandidaat is uitgesloten van vernietiging, met uitsluitreden (Cockpit-uitsluitredenen) en toelichting. Actor systeem bij automatische uitsluiting (*Waardering niet V*). | gebruiker, systeem | vernietigingskandidaat | OBJECT_EXCLUDED |
| Voorgelegd | De recordmanager legt de beoordeelde lijst voor aan de proceseigenaar: `beoordeling → accordering_po`. | gebruiker | taakinstantie | REVIEW_SUBMITTED |
| Retour | De proceseigenaar of archivaris stuurt terug, per kandidaat of de lijst (`accordering_* → beoordeling`). | gebruiker | vernietigingskandidaat, taakinstantie | APPROVAL_REJECTED |
| Vernietigingsopdracht | De recordmanager geeft na de vrijgave de opdracht tot vernietiging: `vrijgegeven → uitvoering`. | gebruiker | taakinstantie | DESTRUCTION_ORDERED_BY_RM |
| Uitvoering gestart | Een vernietigingsuitvoering is bij een stekker aangemaakt. | systeem | taakinstantie | EXECUTION_STARTED |
| Batch aangeboden | Een batch is aan de stekker aangeboden en geaccepteerd. | systeem | batch | BATCH_STARTED |
| Batch verwerkt | De stekker heeft resultaten voor de batch gemeld. | systeem | batch | BATCH_COMPLETED |
| Niet vernietigd | De stekker meldt voor de kandidaat een ander resultaat dan `SUCCESS` (`FAILED`, `SKIPPED`, `NOT_FOUND`, `CHANGED`; in de details). | systeem | vernietigingskandidaat | OBJECT_FAILED |
| Uitvoering mislukt | De vernietigingsopdracht voor een stekker is definitief mislukt. | systeem | taakinstantie | EXECUTION_FAILED |
| Uitvoering opnieuw aangevraagd | De recordmanager start een mislukte opdracht opnieuw. | gebruiker | taakinstantie | EXECUTION_RETRY_REQUESTED |
| Uitvoering afgerond | Alle uitvoeringen zijn afgerond: `uitvoering → resultaat`. | systeem | taakinstantie | EXECUTION_COMPLETED |
| Archivering aangevraagd | De recordmanager vraagt de archivering van het dossier aan. | gebruiker | taakinstantie | ARCHIVING_REQUESTED |
| Archivering mislukt | De archivering is definitief mislukt; opnieuw archiveren kan. | systeem | taakinstantie | ARCHIVING_FAILED |
| Logisch verwijderd | De functioneel beheerder heeft de taakuitvoering logisch verwijderd. Uitdrukkelijk **geen** MDTO *Vernietigen*. | gebruiker | taakinstantie | TASK_DELETED |

## Toewijzing ADR-0003 → ADR-0005

| ADR-0003 | Nieuw | Lijst |
|---|---|---|
| TASK_CREATED | Creatie | MDTO |
| SELECTION_COMPLETED | Import | MDTO |
| APPROVAL_GRANTED | Accordering | MDTO |
| DESTRUCTION_APPROVED_BY_ARCHIVIST | Accordering (rol archivaris), gevolgd door Bevriezing | MDTO |
| OBJECT_PROCESSED | Vernietigen | MDTO |
| CERTIFICATE_GENERATED | Creatie (`entiteit_type` verklaring) | MDTO |
| TASK_COMPLETED | Export | MDTO |
| overige | zie de tabel *Eigen eventtypen* | Cockpit-eventtypen |
