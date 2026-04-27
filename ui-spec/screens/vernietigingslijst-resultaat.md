# Screen: Vernietigingslijst (resultaat)

## Doel
Toont de definitieve uitkomst van de vernietiging en de formele verantwoording.

Dit scherm sluit de taak inhoudelijk af en vormt de basis voor archivering.

---

## Context

- onderdeel van taak-detail
- zichtbaar bij:
  - taak.status == resultaat

- alle uitvoeringsstappen zijn afgerond
- alle data is definitief
- volledig read-only

---

## Belangrijk principe

- dit scherm toont de definitieve waarheid
- geen bewerkingen mogelijk
- audit en verantwoording staan centraal
- structuur blijft consistent met uitvoering en vernietigingslijst

---

## Data source

GET /taken/{id}/resultaten  
GET /taken/{id}/verklaring

---

## Layout

### 1. Contextblok (ContextPanel)

Toont:

- totaal aantal objecten
- succesvol vernietigd
- aantal fouten
- aantal overgeslagen
- aantal niet gevonden

---

### 2. ResultSummary

Geeft duiding aan de uitkomst.

Toont:

- totaal verwerkt
- aantal succesvol
- aantal fouten
- succespercentage

---

## Berekening

succespercentage:

aantal_succes / totaal_aantal * 100

---

### 3. Resultaten per object (ResultTable)

---

## Tabel (aligned met vernietigingslijst)

### Primaire kolommen

- titel
- omvang
- bewaartermijn
- vernietigingsdatum
- status (verwerkingsstatus)
- foutmelding

---

## Kolom mapping

| Vernietigingslijst | Resultaat |
|-------------------|----------|
| titel | titel |
| omvang | omvang |
| bewaartermijn | bewaartermijn |
| vernietigingsdatum | vernietigingsdatum |
| status | verwerkingsstatus |
| toelichting | foutmelding |

---

## Secundaire metadata (via expand)

- id
- bron_id
- code
- periode (startdatum - einddatum)
- selectielijst
- grondslag
- bron_systeem

---

## Status mapping

- SUCCESS → succesvol vernietigd
- FAILED → fout
- SKIPPED → overgeslagen
- NOT_FOUND → niet gevonden

---

## Gedrag

- volledig read-only
- filterbaar op status (FAILED / SUCCESS etc.)
- geen wijzigingen mogelijk
- sortering blijft stabiel

---

### 4. Vernietigingsverklaring (DestructionCertificate)

Toont:

- verklaringstekst
- datum uitvoering
- verantwoordelijke rollen:
  - recordmanager
  - proceseigenaar
  - archivaris
- juridische grondslag (optioneel)

---

## Eigenschappen

- formeel document
- onderdeel van dossier
- onveranderbaar
- reproduceerbaar via audit log

---

### 5. Acties (via TaskHeader + component)

Beschikbaar:

- "Download verklaring (PDF)"
- "Exporteer resultaten"
- "Archiveren" (primaire actie)

---

## Archiveren

### Gedrag

Bij klikken op "Archiveren":

- taak.status → archief
- vernietigingslijst wordt definitief afgesloten
- alle data blijft beschikbaar (read-only)
- geen verdere acties mogelijk

---

## Na archiveren

- scherm blijft zichtbaar als referentie
- UI is volledig read-only
- geen primaire actie meer zichtbaar

---

## Belangrijke regels

- resultaat is eindstatus van proces
- data verandert niet meer
- geen herstart of bewerking mogelijk
- alle informatie moet audit-proof zijn

---

## Relatie met uitvoering

- uitvoering = proces
- resultaat = definitieve uitkomst van de vernietigingslijst

---

## Consistentie met andere schermen

- zelfde kolomstructuur als vernietigingslijst
- zelfde veldnamen
- zelfde visuele opbouw

Verschillen:

- geen selectie
- geen edit velden
- foutmelding i.p.v. toelichting

---

## Audit

Audit log blijft altijd zichtbaar en bevat volledige historie.

Belangrijke events:

- EXECUTION_COMPLETED
- OBJECT_FAILED
- CERTIFICATE_GENERATED
- TASK_COMPLETED