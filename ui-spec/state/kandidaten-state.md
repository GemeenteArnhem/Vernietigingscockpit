# State: Kandidaten

## Object status (UI)
- default
- uitgesloten
- beoordeeld

## Regels
- object is "beoordeeld" als:
  - niet uitgesloten
  - of uitgesloten + toelichting

## Derived state
alle_objecten_beoordeeld = true/false

## Primary action enabled
true als:
- alle_objecten_beoordeeld = true

## Bulk state

selected_object_ids: string[]

## Derived state

heeft_selectie = selected_object_ids.length > 0

bulk_mode = heeft_selectie == true

## Validatie state

object_heeft_fout:
- true als uitgesloten == true en toelichting leeg

heeft_validatiefouten:
- true als minimaal één object_heeft_fout == true

alle_objecten_beoordeeld:
- elk object:
  - niet uitgesloten
  - of uitgesloten + toelichting

## Primary action enabled

true als:
- alle_objecten_beoordeeld == true
- heeft_validatiefouten == false