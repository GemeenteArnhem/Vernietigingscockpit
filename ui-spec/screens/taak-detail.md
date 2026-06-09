# Screen: Taak detail

## Doel
Centrale werkplek voor één vernietigingstaak.

Alle stappen van het proces vinden plaats binnen dit scherm.
De UI is volledig state-gedreven.

---

## Belangrijk principe

- er is geen navigatie binnen de taak
- workflow bepaalt wat zichtbaar is
- state bepaalt wat bewerkbaar is
- audit log is altijd zichtbaar

---

## Layout

### 1. Header (TaskHeader)

Toont:

- naam van de vernietigingslijst
- status (workflow stap)
- actieve rol
- recordmanager
- startdatum
- einddatum (indien afgerond)
- primaire actie

Regels:

- geen inhoudelijke data (zoals aantallen)
- gericht op status en actie

---

### 2. Workflowbalk

Stappen:

- init
- beoordeling
- accordering (proceseigenaar)
- accordering (archivaris)
- uitvoering
- resultaat

Regels:

- huidige stap is actief
- vorige stappen afgerond
- volgende stappen disabled
- niet klikbaar

---

### 3. Contextblok (ContextPanel)

Toont:

- totaal aantal objecten
- aantal uitgesloten
- aantal afwijkingen / fouten
- aanvullende signalen (indien relevant)

Doel:

- ondersteunt interpretatie vóór actie

---

### 4. Hoofdvlak (dynamisch)

De inhoud wordt bepaald door:

state.actieve_view

---

#### init → Taak starten

- toont betrokken stekkers (ConnectorOverview)
- actie: "Selectie ophalen"

---

#### beoordeling → Vernietigingslijst

- vernietigingslijst is editable indien state.is_editable == true
- uitsluiten en toelichten mogelijk

---

#### accordering → Accordering

- vernietigingslijst is read-only
- gebruiker kan:
  - goedkeuren
  - terugsturen
- DecisionPanel zichtbaar

---

#### uitvoering → Uitvoering

- voortgang per bron zichtbaar (StekkerStatus)
- resultaten per object zichtbaar (ResultTable)
- geen bewerkingen mogelijk

---

#### resultaat → Resultaat

- definitieve uitkomst zichtbaar
- vernietigingsverklaring zichtbaar
- volledig read-only

---

### 5. Actie (via TaskHeader)

Primary action afhankelijk van state:

- init → "Selectie ophalen"
- beoordeling → "Door naar accordering"
- accordering → "Goedkeuren"
- uitvoering → "Start vernietiging"
- resultaat → "Archiveren"

Regels:

- maximaal 1 primaire actie
- validatie bepaalt enabled/disabled
- aanvullende acties in specifieke componenten (bijv. DecisionPanel)

---

### 6. Audit log (AuditLog)

Plaatsing:

- rechterpaneel (voorkeur)
- altijd zichtbaar

Toont:

- alle acties en wijzigingen
- chronologisch

Eigenschappen:

- read-only
- onveranderbaar
- onderdeel van dossier

---

## Editability

Wordt volledig bepaald door:

state.is_editable

Regels:

- alleen recordmanager mag bewerken
- alleen in status "beoordeling"
- alle andere statussen zijn read-only

---

## Gedrag bij terugsturen

Wanneer taak wordt teruggestuurd:

- status → beoordeling
- vernietigingslijst wordt opnieuw bewerkbaar
- audit log registreert actie

---

## Belangrijke UX-principes

- één scherm per taak (geen fragmentatie)
- workflow stuurt gebruiker
- geen verborgen staten
- audit altijd zichtbaar
- acties zijn expliciet en controleerbaar
- terminologie is consistent: altijd "vernietigingslijst"