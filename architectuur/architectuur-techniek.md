# Technische Architectuur – Vernietigingscockpit

## 1. Doel en scope

Dit document beschrijft de **technische implementatie** van de Vernietigingscockpit.

Het document heeft als doel:
- het concretiseren van de logische architectuur naar implementatie
- het vastleggen van technische keuzes
- het ondersteunen van ontwikkeling en deployment
- het borgen van schaalbaarheid richting Kubernetes / Haven

De scope omvat:
- code-architectuur (frontend en backend)
- data-opslag en modellering
- integraties (stekkers, archief, IAM)
- infrastructuur en deployment

Dit document bevat **geen normatieve architectuurprincipes**.

### 1.1 Relatie met architectuurdocumenten

Dit document is een technische uitwerking van `architectuur.md`, `architectuur-cockpit.md` en `architectuur-stekker.md`, en van de ADR's. Die documenten zijn leidend voor verantwoordelijkheden, proceslogica en normatieve kaders. Bij conflicten hebben zij voorrang.

**MDTO is leidend** voor benaming en informatiemodel (ADR-0005). ADR-0005 en ADR-0006 zijn doorgevoerd in de code (branch `dev6`).

---

## 2. Technisch overzicht

De Vernietigingscockpit bestaat uit de volgende technische componenten:

- Frontend: React (Vite), Tailwind CSS
- Backend API: NestJS (Node.js), modulaire monolith
- Worker: dezelfde codebase en hetzelfde image als de API, met een ander startcommando
- Database: PostgreSQL (Prisma), ook als werkwachtrij (outbox)
- IAM: Keycloak (OIDC)
- PDF-generatie: Gotenberg (PDF/A-2b)
- Externe systemen: stekkers (Stekker API v2) en een archiefsysteem (archiefadapter: bestand, later OpenZaak)

### 2.1 Componentdiagram

```text
Frontend (React)  ──OIDC──  Keycloak
      │
      ▼
Cockpit API (NestJS) ──────┐
      │                    │  schrijft taken in de outbox (zelfde transactie)
      ▼                    ▼
PostgreSQL  ◄──────── Worker(s) (claim met lease, FOR UPDATE SKIP LOCKED)
                           ├── Stekkers (Stekker API v2, OAuth2 client credentials)
                           ├── Gotenberg (verklaring PDF/A-2b)
                           └── Archiefadapter (MDTO-pakket)
```

---

## 3. Technologiestack

| Laag | Keuze |
|---|---|
| Frontend | React 19, Vite, Tailwind CSS 3.4 |
| Backend | NestJS, Prisma, zod-validatie |
| Data en wachtrij | PostgreSQL (outbox met lease-claims) |
| IAM | Keycloak (OIDC, JWT) |
| Documenten | Gotenberg (PDF/A-2b) |
| Archivering | Archiefadapter: `BestandArchiefAdapter` (volume); OpenZaak volgt via dezelfde interface |
| Gedeelde pakketten | `packages/api-contract` (zod-schema's en antwoordtypes), `packages/stekker-client` (types gegenereerd uit de Stekker-OpenAPI) |
| Infra | Docker Compose (dev, test/E2E, acceptatie); doel Kubernetes / Haven |

---

## 4. Belangrijke technische keuzes

### 4.1 Backend als modulaire monolith

Eén deployable met duidelijke modulegrenzen en een gedeelde database. De reden is de sterke samenhang tussen workflow, dossier en besluitvorming, en de behoefte aan consistente transacties.

### 4.2 Asynchrone verwerking via een PostgreSQL-outbox

Lange of externe processen (selectie, vernietiging, verklaring, archivering en het opschonen van werkkopieën) lopen via een **outbox-tabel** in PostgreSQL:

- een actie schrijft de taak in dezelfde transactie als de statuswijziging en het audit-event;
- workers claimen werk met `FOR UPDATE SKIP LOCKED` en een lease (`geclaimd_tot`, standaard 5 minuten), die bij trage stappen wordt verlengd (heartbeat vóór en na elke externe aanroep);
- elke uitvoeringsstap wordt vastgelegd, zodat een nieuwe poging afgeronde stappen overslaat;
- retrybeleid met exponentiële backoff tot een maximum aantal pogingen; een 4xx-fout faalt direct.

De reden: geen extra infrastructuur (geen Redis/BullMQ), transactionele consistentie tussen besluit en opdracht, en herstartbaarheid zonder verlies.

### 4.3 Database: PostgreSQL

PostgreSQL wordt gebruikt voor dossieropslag, audit- en configuratie-events, workflowstatus en de outbox, vanwege sterke consistentie, transacties en JSONB.

### 4.4 IAM via Keycloak

OIDC-login en JWT-tokens. Rollen komen uit het token; een gebruiker wordt bij de eerste login eenmalig aan een medewerker gekoppeld (event *Gebruiker gekoppeld*). Stekkers worden aangeroepen met OAuth2 client credentials en scopes.

### 4.5 Archivering via een archiefadapter

De cockpit stelt het archiefpakket samen, als MDTO-XML 1.0.1 (indeling: ADR-0005 §7). Een adapter zet het weg: nu `BestandArchiefAdapter` (een map per taak en archivering op een volume, atomisch weggeschreven), later OpenZaak via dezelfde interface.

Het pakket is MDTO-XML 1.0.1 (indeling: ADR-0005 §7), met informatieobjecten voor dossier, vernietigingslijst, besluiten, verklaring en auditlog, en bestanden met omvang, bestandsformaat (PRONOM), checksum (algoritme, waarde, datum) en `isRepresentatieVan`. Daarnaast komen de MDTO-specificaties van de stekkers per vernietigde kandidaat in het pakket, plus een CSV met MDTO-kolomnamen.

De adapter heeft ook `verifieer(locatie, dossierSha256)`: de hercontrole vóór het verwijderen van een werkkopie (ADR-0006). Die leest het pakket terug en controleert de dossier-hash, elk bestand tegen zijn MDTO-bestandsbeschrijving, en de bestanden in `kandidaten/` en `specificaties/` tegen de SHA-256 in de CSV-bijlage. Een extra of ontbrekend bestand laat de verificatie ook mislukken.

---

## 5. Repository en code-structuur

```text
apps/
  cockpit-web/          React-frontend
  cockpit-api/          NestJS API en worker
packages/
  api-contract/         zod-invoerschema's en antwoordtypes (gedeeld door API en web)
  stekker-client/       types gegenereerd uit de Stekker-OpenAPI (architectuurrepo)
infrastructure/
  compose/              dev, test/E2E
  acceptatie/           acceptatieomgeving (o.a. Keycloak-init, geheimen)
```

### 5.1 Cockpit API: modules

```text
src/modules/
  taken/            taakinstanties: toegang, selectie, beoordeling, besluitvorming, uitvoering, dossier
  taakdefinities/   taakdefinities en planning van cycli
  workflow/         statusovergangen (enige plek voor statuswijzigingen)
  audit/            auditketen per taakinstantie, verificatie
  stekker/          stekkerclient (Stekker API)
  stekkers/         stekkerbeheer (configuratieversies, versleutelde secrets)
  worker/           outbox-verwerking: selectie, uitvoering, verklaring, archivering
  verklaring/       verklaring van vernietiging (PDF/A-2b, CSV)
  archief/          archiefpakket en archiefadapters
  auth/             JWT-validatie, rollen
  stamgegevens/     afdelingen en medewerkers
  me/, health/
src/shared/         db, geheim (versleuteling), http, logging
```

### 5.2 Runtime modes

De backend draait in twee modi uit hetzelfde image: de **API** (HTTP) en de **worker** (outbox-verwerking, eigen container, in de API standaard uit). Een aparte, eenmalige compose-service `cockpit-migrate` voert de databasemigraties uit als database-eigenaar.

### 5.3 Configuratie

Configuratie gebeurt via omgevingsvariabelen, bijvoorbeeld `DATABASE_URL`, `OIDC_ISSUER`, `GOTENBERG_URL`, `ARCHIEF_PAD`, `SECRET_ENCRYPTION_KEY` en `WORKER_LEASE_MS`. Voor ADR-0006: `WERKKOPIE_BEWAARTERMIJN` (beginwaarde van de bewaartermijn van de werkkopie, standaard `P12M`) en `OPSCHONING_INTERVAL` (standaard `P1D`), allebei ISO 8601-duren. Niets wordt hardcoded; geheimen staan niet in git.

---

## 6. Backend-architectuur

### 6.1 Implementatieregels

- statuswijzigingen alleen via de workflow-service; validatie vóór update;
- statuswijziging, audit-event en eventuele outbox-taak in **één transactie**;
- controllers bevatten geen databasetoegang; externe aanroepen alleen vanuit services en workers;
- invoer wordt gevalideerd met zod-schema's uit `packages/api-contract`;
- optimistic locking met `If-Match` (412 bij een verouderde versie, vóór 409); geen toegang betekent 404;
- `Idempotency-Key` verplicht op alle POST's van de cockpit-API; de worker stuurt vaste sleutels per stap naar de stekker (ADR-0004);
- rate limiting per gebruiker en per IP.

### 6.2 Workflow

De workflowstatus staat op de taakinstantie (`init`, `beoordeling`, `accordering_po`, `accordering_archivaris`, `vrijgegeven`, `uitvoering`, `resultaat`, `archief`; ADR-0002). Overgangen worden afgedwongen in de workflowmodule.

### 6.3 Auditlog

- `audit_event`: insert-only, één hashketen per taakinstantie, advisory lock per keten, SHA-256 over canonieke JSON van alle kolommen (ADR-0003);
- `configuratie_event`: insert-only, één globale keten;
- de app-rol heeft op deze tabellen alleen `SELECT` en `INSERT`; triggers weigeren `UPDATE`, `DELETE` en `TRUNCATE`.

De kolom `actie` is `event_type` (begripLabel) plus `event_type_begrippenlijst` geworden, met MDTO-eventtypen waar die bestaan en anders de lijsten Cockpit-eventtypen en Cockpit-configuratie-eventtypen.

`DELETE` op `audit_event` en `kandidaat_besluit` is alleen mogelijk via de functie `verwijder_werkkopie` (ADR-0006): de append-only-trigger staat een `DELETE` alleen toe voor de taak in de transactievariabele `cockpit.werkkopie_verwijderen`, die alleen die functie zet. `UPDATE` en `TRUNCATE` blijven altijd geweigerd.

### 6.4 Foutafhandeling

1. HTTP: validatiefouten, autorisatie (404 bij geen toegang), 409/412.
2. Outbox-taken: retries bij tijdelijke fouten, `MISLUKT` na het maximum; de gebruiker kan opnieuw proberen.
3. Database: transacties voorkomen gedeeltelijke updates.

### 6.5 Integratie via adapters

Stekkers (`stekker`-module, types uit `packages/stekker-client`), Gotenberg en het archief worden benaderd via adapters. Externe modellen worden gemapt naar interne modellen.

---

## 7. Data-architectuur

### 7.1 Datamodel (huidig, hoofdlijnen)

```text
afdeling ── medewerker ── gebruiker (OIDC sub)
stekker ── stekker_configuratie (versies, versleuteld secret)
taakdefinitie ── taakdefinitie_stekker
   └── taakinstantie (= vernietigingsdossier)
         ├── selectie (per stekker; vervangen_door_id bij herkansen)
         │     └── vernietigingskandidaat
         │           ├── kandidaat_besluit (append-only: PO/archivaris per ronde)
         │           └── uitvoeringsresultaat
         ├── vernietiging (per selectie) ── vernietiging_batch ── uitvoeringsresultaat
         ├── verklaring (versies, PDF + CSV + hashes)
         ├── archivering (pogingen)
         ├── audit_event (keten per taakinstantie)
         └── outbox
configuratie_event (globale keten)
```

### 7.2 Vernietigingskandidaat – doelmodel (ADR-0005)

De kandidaat slaat de MDTO-gegevens van Stekker API v2 op. Kolomnamen volgen het MDTO-pad (snake_case). Waarden waarop gezocht of gesorteerd wordt, staan in eigen kolommen; gegevensgroepen die vaker kunnen voorkomen, staan in JSONB met MDTO-sleutels.

| Kolom | Inhoud | Vervangt (huidig) |
|---|---|---|
| `kandidaat_id` | `vernietigingskandidaatId` | – |
| `identificatie` (JSONB) | `identificatieGegevens[]` | `bron_id`, `bron_id_naam` |
| `technische_sleutel` | eerste identificatiekenmerk, voor zoeken | `bron_id` |
| `naam`, `omschrijving` (JSONB) | MDTO naam en omschrijving | `omschrijving` |
| `aggregatieniveau_begrip_label` | Archief, Serie, Dossier, Archiefstuk | – |
| `classificatie` (JSONB) | `begripGegevens[]` | `classificatieschema/-sleutel/-omschrijving` |
| `dekking_in_tijd` (JSONB) | `dekkingInTijdGegevens[]` | `begindatum`, `einddatum` |
| `waardering_begrip_code`, `waardering_begrip_label` | B/V/N | `waardering` |
| `termijn_trigger_start_looptijd` (JSONB), `termijn_startdatum_looptijd`, `termijn_looptijd`, `termijn_einddatum` | bewaartermijn | `bewaartermijn`, `vernietigingsdatum` |
| `informatiecategorie_begrip_code`, `informatiecategorie_begrip_label`, `informatiecategorie_begrippenlijst` (JSONB) | informatiecategorie en selectielijst | `selectielijst`, `grondslag`, `resultaat` |
| `informatiecategorie_afwijking` (JSONB) | cockpituitbreiding | `grondslag_afwijkend` |
| `is_onderdeel_van`, `gerelateerd_informatieobject`, `archiefvormer`, `activiteit` (JSONB) | MDTO-verwijzingen | `relatie_type`, `relatie_id` |
| `aantal_objecten`, `aantal_betrokkenen`, `toelichting` | cockpituitbreidingen | – |
| `beoordeling`, `uitsluit_reden`, `toelichting_rm`, `beoordeeld_door`, `beoordeeld_op`, `versie` | cockpitbesluit; uitsluitreden uit Cockpit-uitsluitredenen | – |

De ruwe stekkerpayload (`bron`-JSON) vervalt. Alleen de MDTO-gegevens worden bewaard (dataminimalisatie).

### 7.3 Overige doelwijzigingen

| Tabel | Doel |
|---|---|
| `medewerker` | `archiefvormer` (`verwijzingGegevens`, via de stamgegevens-import; verplicht voor een proceseigenaar van een taakdefinitie) (ADR-0005, B-M3) |
| `taakinstantie` | `archiefvormer` (`verwijzingGegevens`, vastgepind bij aanmaken uit het profiel van de proceseigenaar) |
| `vernietiging` | `vernietigingsmethode` (`begripGegevens`), `vernietigingsmethode_toelichting` (B-M4) |
| `uitvoeringsresultaat` | `identificatie` (JSONB), `event` (JSONB, met `eventTijd`), `bron_event_referentie`, `specificatie` (MDTO-XML) + `specificatie_sha256` (B-M2, B-M7) |
| `audit_event`, `configuratie_event` | `event_type` + `event_type_begrippenlijst` in plaats van `actie` (§6.3) |
| `dossier_grafsteen` | insert-only, eigen keten; zie ADR-0006 §5 |
| `instelling` | sleutel/waarde per organisatie; nu `werkkopie_bewaartermijn` (ISO 8601-duur, CHECK-constraint); wijzigingen als configuratie-event *Instelling gewijzigd* |
| `archivering` | `dossier_sha256` (was `manifest_sha256`): SHA-256 van `dossier.mdto.xml` |

### 7.4 Statusvelden

| Veld | Waarden |
|---|---|
| `taakinstantie.status` | `init`, `beoordeling`, `accordering_po`, `accordering_archivaris`, `vrijgegeven`, `uitvoering`, `resultaat`, `archief` |
| `vernietigingskandidaat.beoordeling` | `OPGENOMEN` (standaard), `AKKOORD`, `UITGESLOTEN`, `RETOUR`; de besluiten van PO en archivaris per ronde (`AKKOORD`/`RETOUR`) staan append-only in `kandidaat_besluit` |
| `uitvoeringsresultaat.resultaat` | `SUCCESS`, `FAILED`, `SKIPPED`, `NOT_FOUND`, `CHANGED` |
| `vernietiging.status` | `LOPEND`, `MISLUKT`, `INTEGRITEIT_MISLUKT`, `AFGEROND` (stekkerstatus apart) |
| `archivering.status` | `PENDING`, `SUCCESS`, `FAILED` |

### 7.5 Transacties en idempotentie

In één databasetransactie gebeuren de statuswijziging, het audit-event, mutaties op kandidaten en het aanmaken van outbox-taken. Bij herhaalde verwerking controleert de worker de vastgelegde stap. Dubbele updates worden voorkomen; audit-events van pogingen blijven bewaard.

### 7.6 Constraints en regels

- FK-constraints tussen alle tabellen; geen cascade deletes op auditdata;
- uniek: (`selectie_id`, `kandidaat_id`), (`vernietiging_id`, `batch_nummer`), (`vernietiging_id`, `kandidaat_id`) voor resultaten;
- auditdata wordt nooit gemuteerd; verwijderen kan alleen via de gecontroleerde werkkopie-verwijdering (ADR-0006);
- statuswijzigingen altijd via services; de database wordt niet direct vanuit controllers benaderd.

### 7.7 Archivering en werkkopie

Na de verklaring vraagt de recordmanager de archivering aan. De worker stelt het pakket samen, de adapter zet het weg, de referentie en de dossier-hash (SHA-256 van `dossier.mdto.xml`) worden vastgelegd en de taak gaat naar `archief`. Bij een terugkerende taak wordt de volgende cyclus klaargezet.

Na een instelbare termijn (standaard `P12M`) en een hercontrole van het pakket verwijdert de job `opschoning` de werkkopie (ADR-0006). Er blijft een grafsteen achter.

- **Job.** Er staat altijd één open job `opschoning:werkkopieen` in de outbox; de volgende komt `OPSCHONING_INTERVAL` na de vorige. De job draait alleen bij een geconfigureerde archieflocatie. Kandidaten (status `archief`, geslaagde archivering, termijn verstreken) zoekt hij met de klok en de termijn van de database.
- **Per taak.** De worker herberekent de auditketen en verifieert het pakket. Daarna schrijft hij in één transactie de grafsteen en het configuratie-event *Werkkopie verwijderd*, en roept hij `verwijder_werkkopie(taak, grafsteen)` aan. De hashketens van grafsteen en configuratielog rekent de applicatie, zoals bij alle ketens.
- **Database.** De functie (`SECURITY DEFINER`, `EXECUTE` alleen voor de app-rol) controleert zelf: status `archief`, geslaagde archivering met dezelfde dossier-hash, termijn verstreken volgens `instelling`, geslaagde verificatie in de grafsteen, grafsteen geschreven in deze transactie, het configuratie-event aanwezig, en een aaneengesloten auditketen met hetzelfde aantal events en dezelfde laatste hash als de grafsteen. Daarna verwijdert ze alle rijen van de taak in FK-volgorde.
- **Mislukte verificatie.** Er wordt niets verwijderd en *Verificatie archief mislukt* vastgelegd. De volgende run probeert het opnieuw.
- **Termijn.** `WERKKOPIE_BEWAARTERMIJN` is de beginwaarde. De worker legt hem vast als er nog geen instelling is. De functioneel beheerder wijzigt hem met `PUT /beheer/instellingen/werkkopie-bewaartermijn`; de auditor leest mee.
- **Na verwijderen.** `GET /dossiers/{id}` geeft de grafsteen (status `werkkopie_verwijderd`), en `GET /dossiers/grafstenen/verificatie` controleert de grafsteenketen.
