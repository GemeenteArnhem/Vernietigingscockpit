# Begeleidend contract – Stekker API Vernietigingscockpit

Dit document beschrijft de normatieve afspraken en gedragsregels voor implementaties van de Stekker API.
Deze afspraken zijn **bindend** voor alle leveranciers en implementaties.
De API-specificatie en dit document vormen samen het contract.

---

## 1. Doel en uitgangspunten

De Stekker API faciliteert:

- het leveren van een consistente lijst met vernietigingskandidaten (snapshot)
- het uitvoeren van vernietiging op basis van door de cockpit goedgekeurde objecten

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

### 2.2 Stateless API, state in gedrag

De API is eenvoudig en bevat geen expliciete job-identificatie.

De stekker:
- **beheert impliciet state** voor:
  - snapshot (kandidatenlijst)
  - vernietigingsproces

De cockpit:
- **is verantwoordelijk** voor procesregie, batching en herstartbaarheid

---

## 3. Snapshot gedrag (kandidatenlijst)

### 3.1 Snapshot definitie

De kandidatenlijst is een **bevroren snapshot** van vernietigingskandidaten.

- elke snapshot heeft een `selectieTimestamp`
- alle resultaten binnen één snapshot zijn consistent
- de snapshot verandert niet tijdens uitlezen

---

### 3.2 Genereren van snapshot

- `POST /kandidaten/genereer` start (of herstart) de generatie
- een nieuwe generatie **overschrijft** de vorige snapshot

---

### 3.3 Status

`GET /kandidaten/status` geeft:

- status van generatie (`IDLE`, `RUNNING`, `READY`, `FAILED`)
- `selectionTimestamp`
- totaal aantal kandidaten (`totaalObjecten`)

---

### 3.4 Ophalen kandidaten

- `GET /kandidaten` retourneert kandidaten uit de laatste succesvolle snapshot
- ophalen gebeurt batchgewijs via `offset` en `limit`
- maximale batchgrootte is 500

---

### 3.5 Consistentie

De stekker:

- **moet garanderen** dat alle batches uit dezelfde snapshot komen
- **mag geen** dynamische wijzigingen toepassen tijdens uitlezen

---

## 4. Vernietigingsproces

### 4.1 Start van vernietiging

- `POST /vernietig` start of vervolgt een vernietigingsproces
- de eerste batch zet de status op `RUNNING`

---

### 4.2 Eén actieve run

De stekker:

- **ondersteunt maximaal één actieve vernietigingsrun tegelijk**
- nieuwe batches horen bij de lopende run

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

---

### 4.5 Asynchrone verwerking

- vernietiging wordt **asynchroon uitgevoerd**
- de API-response van `/vernietig` bevat geen resultaten

---

## 5. Callback gedrag

### 5.1 Callback mechanisme

De stekker:

- **moet per batch een callback uitvoeren** naar `callbackUrl`
- callback bevat:
  - `batchNummer`
  - resultaten per object

---

### 5.2 Betrouwbaarheid

De stekker:

- **moet retries uitvoeren bij mislukte callbacks**
- aanbevolen:
  - minimaal 3 retries
  - exponential backoff

---

### 5.3 Idempotentie callbacks

De cockpit:

- **moet callbacks idempotent verwerken**
- moet omgaan met:
  - dubbele callbacks
  - callbacks in willekeurige volgorde

---

## 6. Status vernietiging

`GET /vernietig/status` geeft:

- status (`IDLE`, `RUNNING`, `COMPLETED`, `PARTIAL`, `FAILED`)
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

- `SUCCESS` → succesvol vernietigd
- `FAILED` → fout bij vernietiging
- `SKIPPED` → niet uitgevoerd (bijv. al verwijderd)
- `NOT_FOUND` → object niet gevonden

---

## 8. Fouten en logging

### 8.1 Selectie

- alleen succesvolle kandidaten worden geretourneerd
- fouten in selectie:
  - worden niet per object gerapporteerd
  - moeten in logging zichtbaar zijn

---

### 8.2 Vernietiging

- fouten worden per object gerapporteerd via callback
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

## 10. Security (minimaal)

- communicatie moet beveiligd zijn (HTTPS)
- callback endpoint moet beveiligd zijn
- authenticatie/authorisatie moet toegepast worden

(verdere invulling afhankelijk van implementatie)

---

## 11. Versies en compatibiliteit

- uitbreidingen zijn additief
- bestaande contracten mogen niet breken
- nieuwe velden moeten optioneel zijn

---

## 12. Samenvattend principe

> De stekker levert een consistente snapshot en voert vernietiging uit,
> de cockpit stuurt, controleert en verantwoordt het proces.