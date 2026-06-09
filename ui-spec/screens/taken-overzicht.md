# Screen: Taken-overzicht

## Doel

**Hoofdoverzicht van alle vernietigingstaken (taakdefinities).**

Dit is het startpunt waar gebruikers zien:
- Welke terugkerende taken er ingesteld zijn
- Status van huidge instanties (actief/gepland)
- Wat de volgende run is

Gebruikers kunnen van hier direct naar een taakdefinitie duiken om meer te zien.

---

## Belangrijk principe

- **Enkel taakdefinities** (niet instanties)
- **Sortering op prioriteit** — vertraagde taken bovenaan
- **Een regel per terugkerende taak** — compact overzicht
- **Klik → Detail** — daar zie je instanties

---

## Data source

```
GET /taakdefinities
```

---

## Layout

**Tabel met taakdefinities** (identiek aan taakdefinitie-overzicht spec).

### Kolommen

| Kolom | Inhoud | Breedte |
|-------|--------|---------|
| **Taaknaam** | Naam + ID | 220px |
| **Proceseigenaar** | Naam + rol | 180px |
| **# Stekkers** | Getal + tooltip met namen | 80px |
| **Frequentie** | Jaarlijks, Kwartaal, Ad-hoc + volgende datum | 120px |
| **Volgende uitvoering** | Datum + afstand tot nu() | 120px |
| **Voortgang actief** | Balk + % + stap + tijd | 240px |
| **Status** | Badge (Actief/Gepland/Vertraagd/Idle) | 80px |

---

## Voortgang-kolom (Hoofdkenmerk)

**Toont voortgang van huidge ACTIEVE instantie (indien die er is).**

### Visueel
```
Beoordeling
████░░░░░░ 40% (4d in stap)
```

### Kleuren
- **Blauw** — normaal (≤7d in stap)
- **Oranje** — vertraagd (>7d in stap)
- **Groen** — afgerond
- **Grijs** — geen actieve instantie (gepland/idle)

### Tooltip (hover)
- Huidge stap
- Startdatum stap
- Relevante rol (wie is aan zet)

---

## Sortering (vanuit API)

**Primaire volgorde:**

1. **Vertraagde taken** (rood badge, >7d in stap)
   - Sortering binnen groep: tijd_in_stap (desc)

2. **Actieve taken** (groen badge, in workflow)
   - Sortering binnen groep: tijd_in_stap (desc)

3. **Geplande taken** (geel badge, volgende cyclus)
   - Sortering binnen groep: volgende_startdatum (asc)

4. **Idle taken** (grijs badge, geen instantie)
   - Geen specifieke sortering

---

## Filtering & Zoeken

**Balk boven tabel:**

```
🔍 Zoek naar naam...  [Filter: Alle ▼]

Status: [Vertraagd] [Actief ✓] [Gepland ✓] [Idle ✓]
Eigenaar: [Mijn taken] [Alle ✓]
```

---

## Interactie

### Klik op taaknaam / hele rij
- Opent **Taakdefinitie-detail** scherm
- Doorgegeven: `taakdefinitie_id`

### Hover op taakrij
- Subtiele achtergrond highlight
- Cursor → pointer

### Hover op "# Stekkers"
- Tooltip toont volledige stelkernamen
- Bijv. "MySQL, SAP, SharePoint, FileShare"

---

## Taakdefinitie-detail (Volgende stap)

Klik op taakdefinitie → Detail-scherm toont:

```
📋 Taakdefinitie: Zorgdomein jaarlijks

Configuratie (read-only voor niet-RM)
- Proceseigenaar
- Archivaris
- Stekkers
- Frequentie

📅 Volgende Geplande Instantie
Zorgdomein 2027 | Gepland | 1 juli 2027 | 387 dagen
Selectie niet gestart

⚙️ Actieve Instantie (Huiding)
Zorgdomein 2026 | Beoordeling | ████░ 40% | 4d in stap
240 objecten | Start: 1 mei

📚 Geschiedenis (Afgehandelde Instanties)
Zorgdomein 2025 | Afgerond | 15 juli 2025 | ✓ Verklaring
Zorgdomein 2024 | Archief | 15 juli 2024 | ✓ Verklaring
```

**Klik op instantie-rij → Taakinstantie-detail**

---

## Rollen & Zichtbaarheid

### Recordmanager
- **Ziet:** Alle taakdefinities
- **Filter:** Geen standaard filter
- **Acties:** Kan taakdefinitie bewerken, nieuwe instantie starten

### Proceseigenaar
- **Ziet:** Alleen taakdefinities waar ze proceseigenaar van zijn
- **Filter:** Auto-gefilterd
- **Acties:** Ziet instanties in hun accorderingsstap (in detail)

### Archivaris
- **Ziet:** Alleen taakdefinities waar ze archivaris van zijn
- **Filter:** Auto-gefilterd
- **Acties:** Ziet instanties in hun accorderingsstap (in detail)

---

## Laden & Refresh

- **Initial load:** GET /taakdefinities
- **Auto-refresh:** Elke 30 seconden
- **Manual refresh:** ⟳ knop bovenaan

---

## Responsive

### Desktop (>1200px)
- Volledige tabel zichtbaar
- Alle kolommen zichtbaar

### Tablet (768-1200px)
- Compactere tabel
- Kolommen: Naam, Frequentie, Voortgang, Status
- Proceseigenaar/Stekkers verborgen

### Mobiel (<768px)
- Kartweergave in plaats van tabel
- Per taak: Naam, Frequentie, Status
- Klik → Detail

---

## Visuele signalen

### Status-badge kleuren
- **Rood (Vertraagd):** >7 dagen in dezelfde stap
- **Groen (Actief):** In werkflow
- **Geel (Gepland):** Volgende cyclus
- **Grijs (Idle):** Geen actieve/geplande instantie

### Voortgang-balk kleuren
- **Blauw:** Normaal tempo
- **Oranje:** Vertraagd
- **Groen:** Afgerond

---

## Relatie met andere schermen

```
Taken-overzicht (NIVEAU 1)
  ↓ Klik taakdefinitie
Taakdefinitie-detail (NIVEAU 2)
  ├─ Configuratie
  ├─ Volgende geplande instantie
  ├─ Actieve instantie
  └─ Geschiedenis
      ↓ Klik instantie-rij
      Taakinstantie-detail (NIVEAU 3)
        ├─ Workflow bar
        ├─ Views (Kandidaten/Beoordeling/Accordering/Uitvoering/Resultaat)
        └─ Dossier-tab (NIVEAU 4, audit)
```

---

## Audit

- Geen directe audit-interactie op dit niveau
- Audit beschikbaar in Taakinstantie-detail > Dossier-tab