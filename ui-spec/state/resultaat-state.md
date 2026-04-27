# State: Resultaat

## Input

resultaten[]:
- status

taak:
- einddatum

---

## Derived state

aantal_succes:
- count(status == SUCCESS)

aantal_fouten:
- count(status == FAILED)

aantal_overgeslagen:
- count(status == SKIPPED)

aantal_niet_gevonden:
- count(status == NOT_FOUND)

succes_percentage:
- aantal_succes / totaal * 100

---

## Gedrag

- alle data is read-only
- geen acties mogelijk