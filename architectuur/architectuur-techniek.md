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
- integraties (stekkers, OpenZaak, IAM)
- infrastructuur en deployment

Dit document bevat **geen normatieve architectuurprincipes**.

---

## 1.1 Relatie met architectuurdocumenten

Dit document is een technische uitwerking van:

- architectuur.md  
- architectuur-cockpit.md  
- architectuur-stekker.md  

Deze documenten zijn leidend voor:
- verantwoordelijkheden
- proceslogica
- normatieve kaders

Dit document:
- herhaalt deze niet
- wijkt hier niet van af
- beschrijft uitsluitend de technische invulling

Bij conflicten hebben de architectuurdocumenten voorrang.

---

## 2. Technisch overzicht

De Vernietigingscockpit bestaat uit de volgende technische componenten:

- Frontend (React)
- Backend API (NestJS)
- Background workers
- Database (PostgreSQL)
- Queue (Redis / BullMQ)
- IAM (Keycloak)
- Externe systemen:
  - Stekkers
  - OpenZaak

---

## 2.1 Hoog niveau componentdiagram
Frontend (React)
│
▼
Cockpit API (NestJS)
│
▼
Queue (Redis/BullMQ)
│
▼
Workers
├── Stekkers
└── OpenZaak

Database (PostgreSQL)
IAM (Keycloak)


---

## 3. Technologiestack

### Frontend
- React
- Tailwind CSS

### Backend
- NestJS (Node.js)

### Data
- PostgreSQL

### Async verwerking
- Redis
- BullMQ

### IAM
- Keycloak

### Archivering
- OpenZaak

### Infra
- Docker Compose (MVP)
- Kubernetes / Haven (doel)

---

## 4. Belangrijke technische keuzes

Deze sectie beschrijft concrete keuzes, niet de onderliggende principes.

### 4.1 Backend als modulaire monolith

De backend is opgebouwd als een modulaire monolith:

- één deployable
- duidelijke modulegrenzen
- gedeelde database

Reden:
- sterke samenhang tussen workflow, dossier en besluitvorming
- behoefte aan consistente transacties
- eenvoudiger beheer in MVP fase

---

### 4.2 Asynchrone verwerking via queue

Alle lange processen worden asynchroon afgehandeld via BullMQ:

- vernietiging batches
- polling van stekkers
- archivering

Reden:
- schaalbaarheid
- fouttolerantie
- ontkoppeling API en uitvoering

---

### 4.3 Database: PostgreSQL

PostgreSQL wordt gebruikt voor:

- dossieropslag
- audit events
- workflowstatus

Reden:
- sterke consistentie
- transacties
- JSONB ondersteuning voor events

---

### 4.4 IAM via Keycloak

Authenticatie en basisautorisatie via Keycloak:

- OIDC login
- JWT tokens
- rollenbeheer

Reden:
- standaardisatie
- integratie met overheidslandschap
- scheiding identity en applicatie

---

### 4.5 Archivering via OpenZaak

Archivering gebeurt via OpenZaak:

- cockpit exporteert dossier
- OpenZaak beheert zaak en documenten

Reden:
- scheiding proces en archief
- aansluiting op Common Ground

---

## 5. Repository en code-structuur

De codebase is georganiseerd per applicatie.
apps/
├── cockpit-web/
└── cockpit-api/

---

### 5.1 Cockpit API structuur
src/
├── modules/
│ ├── taak/
│ ├── workflow/
│ ├── dossier/
│ ├── besluitvorming/
│ ├── uitvoering/
│ ├── stekker/
│ ├── archivering/
│ ├── verklaring/
│ └── auth/
│
├── shared/
└── main.ts

---

### 5.2 Scheiding API en worker

De backend wordt in twee runtime modes uitgevoerd:

- API server (HTTP)
- Worker (queue processing)

Voorbeeld:
- npm run start # API
- npm run worker # worker


---

### 5.3 Configuratie

Configuratie gebeurt via environment variables:

Voorbeeld:
- DB_URL=...
- REDIS_HOST=...
- KEYCLOAK_URL=...
- OPENZAAK_URL=...

Geen configuratie wordt hardcoded in code.

## 6. Backend architectuur (Cockpit API)

De Cockpit API is een NestJS applicatie die bestaat uit een set domeinmodules.  
De API exposeert HTTP endpoints en stuurt asynchrone verwerking aan via een queue.

De backend draait in twee modi:
- API (HTTP server)
- Worker (queue processing)

---

## 6.1 Architectuurstijl

De backend is opgezet als een modulaire monolith.

Kenmerken:

- één codebase en deployment
- duidelijke modulegrenzen
- gedeelde database
- interne communicatie via services (geen HTTP)

Deze structuur maakt het mogelijk om:
- consistentie te waarborgen via transacties
- modules logisch te scheiden zonder distributiecomplexiteit

---

## 6.2 Module-indeling

Modules zijn gegroepeerd per domein:
modules/
├── taak/
├── workflow/
├── dossier/
├── besluitvorming/
├── uitvoering/
├── stekker/
├── archivering/
├── verklaring/
└── auth/


Elke module bevat zijn eigen controllers, services en repositories.

---

## 6.3 Module verantwoordelijkheden (technisch)

### taak
- CRUD voor taken en sjablonen
- startpunt voor workflows

---

### workflow
- beheren en valideren van status transitions
- centrale plek voor statuswijzigingen

---

### dossier
- opslag en ophalen van dossierdata
- verwerken van audit events

---

### besluitvorming
- verwerken van user-acties (uitsluiten, accorderen)
- schrijven van events naar dossier

---

### uitvoering
- aanmaken van batch jobs
- aansturen van queue voor verwerking

---

### stekker
- HTTP client(s) voor stekkers
- mapping van responses naar interne modellen

---

### archivering
- aanroepen van OpenZaak API
- mapping van dossier naar archiefpayload

---

### verklaring
- genereren van documenten (PDF/JSON)

---

### auth
- JWT validatie
- role guards

---

## 6.4 Interne lagen

Elke module volgt dezelfde structuur:

module/
├── controller/ # HTTP endpoints
├── service/ # use cases
├── domain/ # entities / value objects
├── repository/ # database interactie
└── dto/ # request/response modellen


---

## 6.5 Workflow implementatie (technisch)

Workflow status wordt opgeslagen als veld op de taak.

Transitions worden afgedwongen in de workflow module:

- elke statuswijziging verloopt via één service
- validatie gebeurt vóór update
- update en audit event gebeuren in één transactie

Voorbeeld:
workflowService.transition(taakId, targetStatus, userContext)


---

## 6.6 Event logging (audit)

Alle acties worden opgeslagen in de `audit_event` tabel.

Technische kenmerken:

- insert-only (geen updates)
- JSONB payload
- gekoppeld aan taakId

Opslag gebeurt altijd binnen dezelfde database transactie als de actie.

---

## 6.7 Asynchrone verwerking

Queue wordt gebruikt voor:

- uitvoering (vernietiging)
- polling van externe systemen
- archivering

Technische flow:
controller → service → queue.add(job)
worker → job handler → externe call → database update


---

## 6.8 Workers

Workers draaien als aparte processen.

Verantwoordelijkheden:

- ophalen van jobs uit queue
- uitvoeren van externe calls
- verwerken van resultaten

Implementatie:

- BullMQ processors
- retry configuratie per job
- logging per job

---

## 6.9 Foutafhandeling

Fouten worden op drie niveaus afgehandeld:

1. HTTP (API)
   - validatie errors
   - authorization errors

2. Queue jobs
   - retries bij transient errors
   - failure status na max retries

3. Database
   - transacties voorkomen partial updates

Errors worden gelogd en (indien relevant) opgeslagen in database.

---

## 6.10 Integratie via adapters

Externe systemen worden benaderd via adapters:

- stekker clients
- OpenZaak client

Kenmerken:

- geïsoleerd per module
- mapping naar interne DTO’s
- geen directe afhankelijkheid van externe modellen

---

## 6.11 Belangrijke implementatieregels

- statuswijzigingen alleen via workflow service
- alle writes binnen transacties
- geen directe repository calls vanuit controllers
- externe calls alleen vanuit services/workers
- queue gebruiken voor lange processen

## 7. Data-architectuur

De cockpit gebruikt PostgreSQL als primaire datastore.

De database ondersteunt:

- opslag van taken en status
- opslag van vernietigingslijsten (snapshot)
- opslag van audit events
- opslag van uitvoeringsresultaten
- opslag van archiveringsstatus

---

## 7.1 Datamodel (overzicht)
taak
├── dossier
│ ├── vernietigingslijst
│ │ └── vernietigingsobject
│ ├── audit_event
│ └── uitvoeringsresultaat
└── archivering


---

## 7.2 Tabellen

### 7.2.1 taak

Hoofdentiteit.

Belangrijke velden:

- id (UUID, PK)
- naam (string)
- status (enum)
- aangemaakt_op (timestamp)
- afgerond_op (timestamp, nullable)
- sjabloon_id (nullable)

Index:
- PRIMARY KEY (id)

---

### 7.2.2 dossier

Koppelt data aan een taak.

- id (UUID, PK)
- taak_id (FK → taak.id)
- versie (int)
- aangemaakt_op (timestamp)

Index:
- taak_id

---

### 7.2.3 vernietigingslijst

Snapshot van selectie.

- id (UUID, PK)
- dossier_id (FK → dossier.id)
- peildatum (date)
- bron (string, stekkerId)
- status (enum)

Index:
- dossier_id

---

### 7.2.4 vernietigingsobject

Object binnen lijst.

- id (UUID, PK)
- lijst_id (FK → vernietigingslijst.id)
- object_id (string, extern)
- status (enum)
- reden (string, nullable)
- toelichting (text, nullable)

Index:
- lijst_id
- object_id

---

### 7.2.5 audit_event

Audit log.

- id (UUID, PK)
- taak_id (FK → taak.id)
- type (string)
- timestamp (timestamp)
- user_id (string)
- rol (string)
- payload (JSONB)

Index:
- taak_id
- type

---

### 7.2.6 uitvoeringsresultaat

Resultaat per object.

- id (UUID, PK)
- object_id (FK → vernietigingsobject.id)
- status (enum)
- timestamp (timestamp)
- foutmelding (text, nullable)

Index:
- object_id

---

### 7.2.7 archivering

Status van archivering.

- id (UUID, PK)
- taak_id (FK → taak.id)
- status (enum)
- openzaak_zaak_id (string, nullable)
- timestamp (timestamp)

Index:
- taak_id

---

## 7.3 Statusvelden

### taak.status

Enum:

- AANGEMAAKT
- IN_BEOORDELING
- WACHT_OP_PO
- WACHT_OP_ARCHIVARIS
- GOEDGEKEURD
- IN_UITVOERING
- AFGEROND

---

### vernietigingsobject.status

Enum:

- SELECTED
- EXCLUDED
- APPROVED
- IN_PROGRESS
- DELETED
- FAILED

---

### uitvoeringsresultaat.status

Enum:

- SUCCESS
- FAILED
- NOT_FOUND
- GEWIJZIGD

---

### archivering.status

Enum:

- PENDING
- SUCCESS
- FAILED

---

## 7.4 Event opslag

Audit events worden opgeslagen in `audit_event`.

Eigenschappen:

- insert-only
- geen updates of deletes
- JSONB payload voor flexibiliteit

Voorbeeld:

```json
{
  "type": "ObjectUitgesloten",
  "taakId": "...",
  "userId": "...",
  "payload": {
    "objectId": "123"
  }
}
```

## 7.5 Transacties

De volgende operaties gebeuren binnen één database transactie:

- statuswijziging taak
- schrijven audit_event
- mutaties op vernietigingsobject

Doel:
- consistentie
- geen partial updates

---

## 7.6 Idempotentie

Bij herhaalde verwerking (bijv. retries):

- bestaande status wordt gecontroleerd
- dubbele updates worden voorkomen
- audit events blijven wel opgeslagen

---

## 7.7 Performance

Belangrijke maatregelen:

- index op taak_id (audit_event)
- index op object_id (vernietigingsobject)
- gebruik van JSONB voor event payload
- paginering bij grote datasets

---

## 7.8 Archivering

Na afronding van een taak:

- dossier snapshot wordt opgehaald
- verklaring wordt gegenereerd
- data wordt geëxporteerd naar OpenZaak
- referentie (openzaak_zaak_id) wordt opgeslagen

---

## 7.9 Constraints en regels

- FK constraints tussen alle tabellen
- geen cascade deletes op audit_event
- unieke combinatie (lijst_id, object_id)
- statusvelden via enums

---

## 7.10 Belangrijke implementatieregels

- audit_event nooit muteren
- geen soft deletes op audit data
- statuswijzigingen altijd via services
- database niet direct vanuit controllers benaderen
