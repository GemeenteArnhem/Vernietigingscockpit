# State: Taak detail

## Doel
Bepaalt gedrag van de UI binnen een taakdetail.

Dit bestand is de enige bron van waarheid voor:
- editability (bewerken ja/nee)
- zichtbaarheid van acties
- zichtbaarheid van schermdelen
- rolgedrag

---

## Input

taak:
- id
- naam
- status (zie state machine)
- recordmanager
- startdatum
- einddatum (optioneel)

user:
- id
- rol (recordmanager / proceseigenaar / archivaris)

---

## Derived state

### Eigenaarschap

is_recordmanager:
- user.id == taak.recordmanager

---

### Editability (enige waarheid)

is_editable:

true als:
- is_recordmanager == true
- taak.status == beoordeling

anders false

---

### Read-only

is_read_only:
- taak.status in:
  - accordering_po
  - accordering_archivaris
  - uitvoering
  - resultaat

---

### Acties

kan_selectie_starten:

true als:
- taak.status == init
- is_recordmanager == true

---

kan_naar_accordering:

true als:
- taak.status == beoordeling
- is_editable == true
- geen validatiefouten

---

kan_goedkeuren_po:

true als:
- taak.status == accordering_po
- user.rol == proceseigenaar

---

kan_goedkeuren_archivaris:

true als:
- taak.status == accordering_archivaris
- user.rol == archivaris

---

kan_terugsturen:

true als:
- taak.status in:
  - accordering_po
  - accordering_archivaris
- user.rol komt overeen met huidige stap

---

kan_vernietigen:

true als:
- taak.status == uitvoering
- vernietiging nog niet gestart

---

kan_archiveren:

true als:
- taak.status == resultaat

---

actieve_view:

resultaat → resultaat
archief → resultaat (zelfde view, maar afgesloten)

### View mapping (welk scherm zichtbaar is)

actieve_view:

- init → taak-start
- beoordeling → kandidaten
- accordering_po → accordering
- accordering_archivaris → accordering
- uitvoering → uitvoering
- resultaat → resultaat

---

### Audit log

audit_log_zichtbaar:
- altijd true

---

## Belangrijke regels

- UI volgt deze state, niet andersom
- componenten mogen geen eigen logica hebben voor:
  - editability
  - acties
  - workflow

- alle knoppen en velden zijn afhankelijk van deze state

---

## Samenvatting

Deze state bepaalt:

- wie mag bewerken
- wanneer iets read-only is
- welke acties zichtbaar zijn
- welk scherm getoond wordt

Alles is afgeleid van:
- taak.status
- user rol / eigenaarschap