# Begeleidend contract – Stekker API Vernietigingscockpit

Dit document beschrijft de normatieve afspraken en gedragsregels voor implementaties van de Stekker API.  
Deze afspraken zijn **bindend** voor alle leveranciers en implementaties.  
De API-specificatie en dit document vormen samen het contract.

Dit contract is opgesteld conform gangbare API-ontwerpprincipes, waaronder de Nederlandse API Design Rules (ADR), Common Ground principes en de Nerds-leidraad.  
Daarbij is gekozen voor een resource-georiënteerde, eenvoudige en domein-gedreven opzet.

---

## 1. Doel en uitgangspunten

De Stekker API faciliteert:

- het leveren van een consistente selectie van vernietigingskandidaten (**selectie**)
- het uitvoeren van vernietiging op basis van aangeleverde objecten (**vernietiging**)

Daarbij geldt:

- de cockpit voert regie en besluitvorming uit
- de stekker voert selectie en vernietiging operationeel uit
- de stekker bevat de domeinlogica (zoals bewaartermijnen en selectieregels)
- de cockpit bevat geen selectie- of vernietigingslogica

---

## 2. Algemene principes

### 2.1 Scheiding van verantwoordelijkheden

- de cockpit bepaalt **wat** moet gebeuren  
- de stekker bepaalt **hoe** dit technisch wordt uitgevoerd  

De stekker:

- **mag geen** normatieve besluiten nemen  
- **moet** selectie en vernietiging operationeel uitvoeren  

---

### 2.2 Stateless API, state in resources

De API is stateless, maar exposeert de actuele toestand via resources.

- de actuele selectie is beschikbaar via `/selecties/latest`
- de actuele vernietiging is beschikbaar via `/vernietigingen/latest`

De stekker beheert intern de state voor:

- selectie (kandidatenlijst)
- vernietigingsproces

De cockpit is verantwoordelijk voor:

- procesregie
- batching
- herstartbaarheid

---

### 2.3 Representatie van `latest`

De resource `latest` is een representatie van de meest recente selectie of vernietiging.

- `latest` is geen persistente identificatie
- de API kan uitgebreid worden met resource-identificaties (`/selecties/{id}`, `/vernietigingen/{id}`) zonder breaking changes

---

## 3. Selectie (kandidatenlijst)

### 3.1 Definitie

Een selectie is een **bevroren momentopname** van vernietigingskandidaten.

- elke selectie heeft een `selectionTimestamp`
- alle resultaten binnen één selectie zijn consistent
- de selectie verandert niet nadat deze gereed is (`READY`)

---

### 3.2 Starten van een selectie

- `POST /selecties` start of herstart een selectie
- een nieuwe selectie **overschrijft** de vorige selectie

---

### 3.3 Status van een selectie

`GET /selecties/latest` retourneert:

- `status` (`IDLE`, `RUNNING`, `READY`, `FAILED`)
- `selectionTimestamp`
- `totaalObjecten`

---

### 3.4 Ophalen van kandidaten

- `GET /selecties/latest/objecten`
- standaard wordt paginering gedaan via `offset` en `limit`
- maximale batchgrootte is 500

#### Toekomstige uitbreiding

De API is uitbreidbaar naar cursor-based paginering:

- `cursor` kan als alternatief voor `offset` worden geïntroduceerd
- deze uitbreiding is backward compatible

---

### 3.5 Consistentie

De stekker:

- **moet garanderen** dat alle batches uit dezelfde selectie komen  
- **mag geen** wijzigingen toepassen tijdens uitlezen  

---

## 4. Vernietiging

### 4.1 Start van vernietiging

- `POST /vernietigingen` start of vervolgt een vernietigingsproces
- de eerste batch zet de status op `RUNNING`

---

### 4.2 Eén actieve vernietiging

De stekker:

- **ondersteunt maximaal één actieve vernietiging tegelijk** per stekkerinstantie
- nieuwe batches horen bij de lopende vernietiging

---

### 4.3 Batchverwerking

- vernietiging gebeurt per batch
- elke batch bevat:
  - `batchNummer`
  - lijst met objecten

---

### 4.4 Idempotentie

De stekker:

- **moet batches herkennen op basis van `batchNummer`**
- **mag een batch nooit dubbel uitvoeren**
- **moet bij dubbele aanlevering hetzelfde resultaat leveren of negeren**

Herhaalde aanlevering van een batch met hetzelfde batchNummer leidt niet tot dubbele uitvoering,
maar kan wel opnieuw worden geregistreerd en gerapporteerd in status en logging.

---

### 4.5 Asynchrone verwerking

- vernietiging wordt **asynchroon uitgevoerd**
- de API-response bevat geen directe resultaten

---

## 5. Resultaten via API

### 5.1 Polling als primair mechanisme

De API is polling-gebaseerd. Clients halen status en resultaten actief op via de API.

---

### 5.2 Resultaten (bron van waarheid)

Resultaten zijn altijd opvraagbaar via de API:

- `GET /vernietigingen/latest`
- `GET /vernietigingen/latest/batches`
- `GET /vernietigingen/latest/batches/{batchNummer}`

---

## 6. Status vernietiging

`GET /vernietigingen/latest` geeft:

- `status` (`IDLE`, `RUNNING`, `COMPLETED`, `PARTIAL`, `FAILED`)
- aantal verwerkte batches
- totaal aantal batches (indien bekend)
- aantallen successen en fouten

---

### 6.1 Status betekenis

| Status | Betekenis |
|--------|----------|
| IDLE | geen actieve vernietiging |
| RUNNING | verwerking bezig |
| COMPLETED | alles succesvol |
| PARTIAL | deels mislukt |
| FAILED | proces mislukt |

---

## 7. Objectresultaten

Per object wordt gerapporteerd:

- `SUCCESS` = succesvol vernietigd  
- `FAILED` = fout bij vernietiging  
- `SKIPPED` = niet uitgevoerd  
- `NOT_FOUND` = object niet gevonden  / fysiek vernietigd
- `SKIPPED` = business/logische reden (bijv. niet meer vernietigbaar)
- `CHANGED` = gewijzigd sinds selectie

---

## 8. Fouten en logging

### 8.1 Selectie

- alleen succesvolle kandidaten worden geretourneerd  
- fouten worden gelogd, maar niet per object gerapporteerd  

---

### 8.2 Vernietiging

- fouten worden per object gerapporteerd  
- technische fouten:
  - moeten gelogd worden  
  - mogen niet leiden tot inconsistent gedrag  

---

## 9. Performance en schaalbaarheid

De stekker:

- **moet grote datasets ondersteunen**
- **moet batchverwerking ondersteunen**
- **mag interne optimalisaties toepassen (bijv. caching, scheduling)**

---

## 10. Security

### 10.1 API beveiliging

- communicatie moet beveiligd zijn (HTTPS)
- de API moet beveiligd worden met OAuth2

Aanbevolen flow:

- Client Credentials flow voor systeem-naar-systeem communicatie

---

### 10.2 Autorisatie

- toegang tot endpoints moet gebaseerd zijn op scopes of rollen
- minimale rechten moeten worden toegepast (least privilege)

---

## 11. Versies en compatibiliteit

- uitbreidingen zijn additief  
- bestaande contracten mogen niet breken  
- nieuwe velden moeten optioneel zijn  

---

## 12. Toekomstige uitbreidbaarheid

De API exposeert standaard de **meest recente selectie en vernietiging** via `latest`.

Het model is uitbreidbaar naar:

- resource-identificatie (`/selecties/{id}`, `/vernietigingen/{id}`)
- cursor-based paginering
- event notificaties (bijv. webhooks)

Deze uitbreidingen kunnen worden toegevoegd zonder breaking changes.

---

## 13. Samenvattend principe

> De stekker levert een consistente selectie en voert vernietiging uit,  
> de cockpit stuurt, controleert en verantwoordt het proces.  
> De API blijft eenvoudig door alleen de actuele toestand te exposen.