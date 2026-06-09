# State: Vernietigingslijst (beoordeling)

## Context

Deze state is alleen actief wanneer:

taak.status == beoordeling

---

## Object status (UI)

Per object:

- default
- uitgesloten
- beoordeeld

---

## Regels

Een object is "beoordeeld" als:

- uitgesloten == false
OF
- uitgesloten == true EN reden + toelichting ingevuld

---

## Derived state

### Objectniveau

object_heeft_validatiefout:

true als:
- uitgesloten == true EN (reden leeg OF toelichting leeg)

---

### Lijstniveau

heeft_validatiefouten:

true als:
- minimaal één object_heeft_validatiefout == true

---

alle_objecten_beoordeeld:

true als:
- elk object:
  - niet uitgesloten
  OF
  - uitgesloten + reden + toelichting

---

## Selectie (bulk)

selected_object_ids: string[]

---

## Derived selectie state

heeft_selectie:

selected_object_ids.length > 0

---

bulk_mode:

heeft_selectie == true

---

## Primary action (TaskHeader)

### "Door naar accordering"

enabled als:

- alle_objecten_beoordeeld == true
- heeft_validatiefouten == false

---

## Validatie

### Objectniveau

Indien:

uitgesloten == true

Dan verplicht:

- reden
- toelichting

---

### Foutweergave

- inline per veld
- gekoppeld aan reden/toelichting

Voorbeeld:

"Reden is verplicht"
"Toelichting is verplicht bij uitsluiten"

---

## Gedrag

- wijzigingen worden direct opgeslagen via API
- state reflecteert altijd backend waarheid
- geen lokale-only state

---

## Relatie met andere state

- afhankelijk van task-detail-state (editability)
- bepaalt enable/disable van primary action
- beïnvloedt overgang naar accordering

---

## Belangrijke regels

- UI volgt deze state, niet andersom
- geen duplicatie van validatielogica in componenten
- alle logica rondom beoordeling zit hier

---

## Samenvatting

Deze state bepaalt:

- wanneer een object correct beoordeeld is
- wanneer de vernietigingslijst klaar is voor accordering
- wanneer de gebruiker door mag naar de volgende stap