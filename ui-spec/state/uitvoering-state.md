# State: Uitvoering

## Input

taak.status:
- uitvoering
- resultaat

resultaten[]:
- object_id
- status
- foutmelding

---

## Derived state

is_gestart:
- true als eerste batch verstuurd

is_bezig:
- true als status == uitvoering

is_afgerond:
- true als status == resultaat

---

## Tellingen

aantal_succes:
- count(status == SUCCESS)

aantal_fouten:
- count(status == FAILED)

aantal_in_progress:
- count(status == RUNNING)

---

## Acties

kan_starten:
- true als status == uitvoering AND is_gestart == false