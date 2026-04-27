# State: Accordering

## Input

taak.status:
- accordering_po
- accordering_archivaris

user.rol:
- proceseigenaar
- archivaris

---

## Derived state

is_read_only = true

kan_goedkeuren:
- true als user rol overeenkomt met taak.status

kan_terugsturen:
- true als user rol overeenkomt met taak.status

---

## Validatie

terugsturen:
- toelichting verplicht

goedkeuren:
- geen extra validatie