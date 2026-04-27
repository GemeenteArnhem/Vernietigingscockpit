# State: Taken overzicht

## Input

taken[]:
- id
- naam
- status (workflow stap)
- aantal_objecten
- aantal_fouten
- startdatum
- tijd_in_stap

## Derived state

heeft_actie_nodig:
- true als status in:
  - beoordeling
  - accordering_po
  - accordering_archivaris

heeft_fouten:
- aantal_fouten > 0

is_gepland:
- status == selectie AND startdatum in toekomst

is_afgerond:
- status == resultaat

## Sortering

prioriteit:
1. heeft_actie_nodig
2. heeft_fouten
3. status == uitvoering
4. is_gepland
5. is_afgerond

Binnen groep:
- sorteer op tijd_in_stap (desc)