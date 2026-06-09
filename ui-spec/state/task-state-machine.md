# State machine: Taak

## Doel
Definieert de volledige lifecycle van een vernietigingstaak.

Dit is de enige bron van waarheid voor:
- statussen
- transitions (overgangen)
- workflow gedrag

---

## Belangrijk principe

- workflow is strikt en lineair
- transitions zijn expliciet
- UI en API volgen deze state machine
- status bepaalt:
  - wat zichtbaar is
  - wat bewerkbaar is
  - welke acties mogelijk zijn

---

## States (enige geldige set)

- init
- beoordeling
- accordering_po
- accordering_archivaris
- uitvoering
- resultaat
- archief

---

## State beschrijving

### init

- taak is aangemaakt
- nog geen selectie uitgevoerd
- gebruiker moet selectie starten
- nog geen vernietigingslijst beschikbaar

---

### beoordeling

- vernietigingslijst is beschikbaar (snapshot)
- recordmanager kan bewerken
- uitsluiten, reden en toelichting vastleggen
- validatie bepaalt doorgang

---

### accordering_po

- vernietigingslijst is read-only
- proceseigenaar beoordeelt
- kan:
  - goedkeuren
  - terugsturen

---

### accordering_archivaris

- vernietigingslijst is read-only
- archivaris beoordeelt
- kan:
  - goedkeuren (definitief)
  - terugsturen

---

### uitvoering

- vernietiging wordt uitgevoerd
- geen bewerkingen mogelijk
- voortgang zichtbaar per bron
- resultaten worden opgebouwd

---

### resultaat

- taak is afgerond
- resultaten en verklaring beschikbaar
- volledig read-only
- wacht op archiveren

---

### archief

- taak is definitief afgesloten
- volledig read-only
- alleen raadpleegbaar

---

## Transitions (enige geldige overgangen)

init → beoordeling  

beoordeling → accordering_po  

accordering_po → accordering_archivaris  

accordering_archivaris → uitvoering  

uitvoering → resultaat  

resultaat → archief  

---

## Terugsturen (rework)

accordering_po → beoordeling  

accordering_archivaris → beoordeling  

---

## Acties die transitions triggeren

| Actie | Van | Naar |
|------|-----|------|
| Selectie ophalen | init | beoordeling |
| Door naar accordering | beoordeling | accordering_po |
| Goedkeuren (PO) | accordering_po | accordering_archivaris |
| Goedkeuren (archivaris) | accordering_archivaris | uitvoering |
| Terugsturen | accordering_* | beoordeling |
| Start vernietiging | uitvoering | uitvoering (start proces) |
| Voltooiing uitvoering | uitvoering | resultaat |
| Archiveren | resultaat | archief |

---

## Belangrijke regels

- transitions zijn strikt (geen sprongen)
- status wordt alleen gewijzigd via backend
- UI mag geen status direct aanpassen
- elke transition genereert een audit event

---

## Relatie met UI

- taak.status bepaalt welk scherm zichtbaar is
- taak.status bepaalt editability
- taak.status bepaalt welke acties beschikbaar zijn

---

## Relatie met API

- elke actie correspondeert met een endpoint
- backend valideert transitions
- verkeerde state → 409 fout

---

## Relatie met audit

Elke transition resulteert in events zoals:

- TASK_STARTED
- SELECTION_COMPLETED
- APPROVAL_GRANTED
- APPROVAL_REJECTED
- EXECUTION_STARTED
- EXECUTION_COMPLETED
- TASK_COMPLETED

---

## Afgeleide principes

- editability wordt bepaald door state
- zichtbare UI wordt bepaald door state
- acties worden bepaald door state

---

## Samenvatting

Deze state machine bepaalt:

- de volledige lifecycle van een vernietigingstaak
- welke stappen verplicht zijn
- hoe gebruikers door het proces geleid worden

Alles in het systeem is hiervan afgeleid:
- UI
- API
- business logica