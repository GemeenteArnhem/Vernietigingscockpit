# Screen: Taakdefinitie-overzicht

## Doel
Overzicht van alle taakdefinities (terugkerende vernietigingstaken) met actuele status van hun actieve/geplande instantie.

---

## Belangrijk principe

- **Tabel met taakdefinities** — niet instanties (volgende niveau)
- **Één kolom voortgang** — toon alleen van actieve instantie
- **Visuele urgentie** — vertraging duidelijk opvallend
- Gebruiker ziet op een oogopslag: wie actief, wat gepland, wat vertraagd

---

## Data source

GET /taakdefinities
Respons bevat per definitie:
- id
- naam
- proceseigenaar
- stekkers[] (aantal + namen)
- frequentie
- volgende_startdatum
- actieve_instantie_id (nullable)
- status (actief, gepland, idle, vertraagd)

Optioneel per actieve instantie:
- huidige_stap (workflow)
- voortgang_procent
- tijd_in_huidige_stap
- kritieke_drempel_overschreden (> 7d in stap)

---

## Kolommen

### 1. Taaknaam (linkerkant, sticky)
- **Toont:**
  - Naam taakdefinitie
  - Taak-ID (klein, secondary)
  
- **Interactie:**
  - Klikbaar → opent Taakdefinitie-detail

- **Breedte:** 220px

---

### 2. Proceseigenaar
- **Toont:**
  - Naam proceseigenaar
  - Label "Rol: Records Mgr" (secondary)

- **Breedte:** 180px

---

### 3. # Stekkers
- **Toont:**
  - Aantal stekkers (getal)
  - Namen stekkers als tooltip/expandable (klein grijs)
    Bijv. "4 stekkers" → hover → "MySQL, SAP, SharePoint, FileShare"

- **Breedte:** 80px

---

### 4. Frequentie
- **Toont:**
  - Frequentie-label: "Jaarlijks", "Kwartaal", "Maandelijks", "Ad-hoc"
  - Volgende datum (secondary, grijs)
    Bijv. "Jaarlijks" + "1 juli"

- **Breedte:** 120px

---

### 5. Volgende uitvoeringsdatum
- **Toont:**
  - Datum (ISO of lokaal formaat)
  - Afstand tot nu() in duidelijke termen:
    - "Volgende week"
    - "Volgende maand"
    - "47 dagen"
    - "—" (ad-hoc, geen vaste datum)

- **Visuele signaal:**
  - "In 1-2 dagen" → oranje
  - "Overdue" (voorbij geplande datum) → rood

- **Breedte:** 120px

---

### 6. Voortgangsbar actieve uitvoering
- **Toont (alleen als actieve_instantie_id != null):**
  - Voortgang als % (visueel)
  - Huidige stap (tekstueel)
  - Tijd in stap

- **Voorbeeld:**
  ```
  Beoordeling
  ████░░░░░░ 40% (4d in stap)
  ```

- **Voortgangsberekening:**
  - 1. Selectie = 10%
  - 2. Beoordeling = 30%
  - 3. Accordering PO = 20%
  - 4. Accordering Arch = 20%
  - 5. Uitvoering = 15%
  - 6. Resultaat = 5%

- **Kleur:**
  - Normaal (≤7d in stap) = Primair (blauw)
  - Vertraagd (>7d in stap) = Waarschuwing (oranje/geel)
  - Afgerond/Resultaat = Succes (groen)

- **Tooltip:**
  - Huidige stap
  - Startdatum stap
  - Relevante rol (wie is aan zet)

- **Indien geen actieve instantie:**
  - "Gepland" → nog geen voortgang
  - "Klaar voor start" (ad-hoc, idle)
  - "—" (geen actieve of geplande)

- **Breedte:** 240px

---

### 7. Status
- **Toont:** 
  - Status-badge

- **Mogelijke waarden:**
  - **Actief** (groen badge)
    - Instantie is in workflow
    - Kleur: Groen
  
  - **Gepland** (geel badge)
    - Volgende instantie gepland, nog niet gestart
    - Kleur: Geel
  
  - **Idle** (grijs badge)
    - Geen actieve of geplande instantie (meestal ad-hoc)
    - Kleur: Grijs
  
  - **Vertraagd** (rood badge)
    - Actieve instantie > 7 dagen in dezelfde stap
    - Kleur: Rood

- **Badge-stijl:**
  - Kleine rechthoek met afgeronde hoeken
  - Witte tekst

- **Breedte:** 80px

---

## Sortering (vanuit API)

**Primaire sortering:**
1. Vertraagde taken (rood)
2. Actieve taken (groen)
3. Geplande taken (geel)
4. Idle taken (grijs)

**Secundaire sortering (binnen groep):**
- Actief: Sorteer op `kritieke_drempel_overschreden` (true eerst), dan op `tijd_in_huidige_stap` (desc)
- Gepland: Sorteer op `volgende_startdatum` (asc, binnenkomst eerst)
- Idle: Geen specifieke sortering

---

## Filtering & Acties (balk boven tabel)

### Filter-opties
```
Filter: [Alle ▼] [Actief ✓] [Gepland ✗] [Idle ✗] [Vertraagd ✗]
```

- Default: Alle zichtbaar
- Gebruiker kan per status filteren
- Multi-select (checkboxes)

### Info-balk
```
📊 12 taken totaal | 3 actief | 9 inactief
```

---

## Interactie

### Klik op taakrij
- Opent **Taakdefinitie-detail** scherm
- Mee gegeven: taakdefinitie_id

### Klik op taakname (kolom 1)
- Idem (hele rij is klikbaar)

### Hover op taakrij
- Subtiele achtergrond-highlight
- Cursor → pointer

### Hover op "# Stekkers"
- Tooltip toont volledige stelkernamen
- Bijv. "MySQL, SAP, SharePoint, FileShare"

---

## Responsive gedrag

### Desktop (>1200px)
- Alle kolommen zichtbaar
- Tabel scrollt horizontaal indien nodig

### Tablet (768-1200px)
- Kolommen: Taaknaam, Frequentie, Volgende datum, Status
- Voortgang + Proceseigenaar verborgen (beschikbaar in detail)

### Mobiel (<768px)
- Kartweergave in plaats van tabel
- Per taak: Naam, Frequentie, Status
- Klik → Detail

---

## Visuele signalen

### Vertraging
- Status badge = "Vertraagd" (rood)
- Voortgangsbar = oranje/rood
- Verhoging van visuele prioriteit in sortering

### Binnenkort
- Volgende datum kolom: "Volgende week" → Oranje tint
- Badge: "Gepland"

### Afgerond/Verwijderd
- Niet in dit overzicht (alleen actieve of geplande taken)

---

## Volgorde weergave
```
1. Vertraagde actieve taken (rood badge, top priority)
2. Actieve taken zonder vertraging (groen badge)
3. Geplande taken (geel badge)
4. Idle taken (grijs badge)
```

---

## Laden en refresh

- Lijst wordt geladen bij openen scherm
- Auto-refresh elke 30 seconden (optioneel, backend afhankelijk)
- Gebruiker kan handmatig refreshen (⟳ knop)

---

## Regels

- Geen dubbele taakdefinities zichtbaar
- Voortgangsbar enkel voor actieve instanties
- Status bepaalt kleur en prioriteit
- Hele rij klikbaar (niet alleen taaknaam)

---

## Relatie met andere schermen

- Klik taak → **Taakdefinitie-detail**
- Taakdefinitie-detail → **Taakinstantie-detail**
- Taakinstantie-detail → **Dossier**

---

## Rollen & Zichtbaarheid

### Recordmanager
- **Ziet:** Alle taakdefinities
- **Filter:** Geen standaard filter (kan zelf filteren)
- **Acties:** Kan taakdefinitie bewerken, nieuwe instantie starten

### Proceseigenaar
- **Ziet:** Alleen taakdefinities waar ze proceseigenaar van zijn
- **Filter:** Automatisch gefilterd + standaard alleen "Accordering PO" status
- **Acties:** Kunnen accordering geven/weigeren (via Taakinstantie-detail)
- **Voortgang:** Zien alleen voortgang van instanties in hun accorderingsstap

### Archivaris
- **Ziet:** Alleen taakdefinities waar ze archivaris van zijn
- **Filter:** Automatisch gefilterd + standaard alleen "Accordering Archivaris" status
- **Acties:** Kunnen finale accordering geven/weigeren
- **Voortgang:** Zien voortgang van instanties in hun accorderingsstap

---

## Audit

Geen directe audit-interactie op dit niveau.
Audit zichtbaar in Taakinstantie-detail > Dossier-tab.
