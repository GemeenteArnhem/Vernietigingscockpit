# Screen: Kandidatenlijst

## Doel
Beoordelen van vernietigingskandidaten door de recordmanager.

## Context
Onderdeel van taak (dossier).
Deze lijst is een snapshot en verandert niet tijdens beoordeling.

## Data source
GET /selecties/latest/objecten

## Velden (per object)
- id (string)
- titel (string)
- status (enum)
- reden (string, optioneel)
- uitgesloten (boolean)
- toelichting (string, optioneel)

## UI Componenten
- DataTable (NLDS)
- StatusBadge
- Checkbox (uitsluiten)
- Textarea (toelichting)

## Tabel kolommen
1. Selectie (checkbox)
2. Titel
3. Status
4. Reden
5. Toelichting (editable)

## Interactie

### Object uitsluiten
- gebruiker vinkt checkbox aan
- veld "toelichting" wordt verplicht

### Toelichting toevoegen
- vrij tekstveld per object

### Bulk acties
- meerdere objecten selecteren
- uitsluiten in bulk

## Primary action
Label: "Door naar accordering"

Enabled wanneer:
- alle objecten beoordeeld zijn
- alle uitgesloten objecten een toelichting hebben

## Status mapping
- SUCCESS → groen (vernietigbaar)
- FAILED → rood (probleem)
- SKIPPED → grijs (niet van toepassing)
- NOT_FOUND → grijs

## Regels
- lijst is read-only behalve uitsluiten/toelichting
- filtering verandert dataset niet
- acties zijn direct zichtbaar

## Feedback
- wijzigingen worden direct opgeslagen
- geen expliciete save knop

## Bulk acties

### Selectie
- gebruiker kan meerdere objecten selecteren via checkbox per rij
- header checkbox selecteert/deselecteert alle zichtbare rijen

### Bulk uitsluiten
Actie: "Selectie uitsluiten"

Gedrag:
- zet uitgesloten = true voor alle geselecteerde objecten
- opent bulk toelichting veld (optioneel invullen)

### Bulk toelichting
- ingevulde toelichting wordt toegepast op alle geselecteerde objecten
- bestaande toelichting wordt overschreven

### Bulk herstellen
Actie: "Uitsluiting ongedaan maken"

Gedrag:
- zet uitgesloten = false
- verwijdert toelichting

---

## Validatie

### Objectniveau
- als uitgesloten = true → toelichting is verplicht

### Schermniveau
Primary action ("Door naar accordering") is alleen enabled als:

1. alle objecten beoordeeld zijn
2. alle uitgesloten objecten een toelichting hebben

### Validatie feedback
- ontbrekende toelichting → rode foutmelding bij veld
- foutmelding tekst:
  "Toelichting is verplicht bij uitsluiting"

### Bulk validatie
- validatie geldt ook voor bulk updates
- foutmelding wordt per object getoond