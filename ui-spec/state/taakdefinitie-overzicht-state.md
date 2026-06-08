# State: Taakdefinitie-overzicht

## Input Data (from API)

```typescript
taakdefinities: TaakDefinitie[] = [
  {
    id: string
    naam: string
    proceseigenaar: {
      naam: string
      rol: string
    }
    stekkers: {
      aantal: number
      namen: string[] // ["MySQL", "SAP", "SharePoint", "FileShare"]
    }
    frequentie: "jaarlijks" | "kwartaal" | "maandelijks" | "ad-hoc"
    volgende_startdatum: ISO8601 | null // null voor ad-hoc
    
    // Actieve instantie (indien aanwezig)
    actieve_instantie: {
      id: string
      huidige_stap: "selectie" | "beoordeling" | "accordering_po" | "accordering_arch" | "uitvoering" | "resultaat"
      startdatum_stap: ISO8601
      voortgang_procent: number // 0-100
    } | null
  }
]
```

---

## Derived State

### Status bepalen
```
bepaal_status(taakdef):
  if actieve_instantie:
    if tijd_in_stap > 7 dagen:
      return "vertraagd"
    else:
      return "actief"
  else if volgende_startdatum en volgende_startdatum > nu():
    return "gepland"
  else:
    return "idle"
```

### Voortgang berekenen
```
stap_gewicht = {
  "selectie": 10,
  "beoordeling": 30,
  "accordering_po": 20,
  "accordering_arch": 20,
  "uitvoering": 15,
  "resultaat": 5
}

bepaal_voortgang_procent(huidige_stap):
  cumulative = sum(stap_gewicht[stap] for stap in stappen_tot_huidige)
  return cumulative
```

### Vertraging bepalen
```
is_vertraagd:
  - actieve_instantie != null
  - AND (nu() - startdatum_stap) > 7 dagen
  - AND huidige_stap in ["beoordeling", "accordering_po", "accordering_arch"]
```

### Urgentie volgende datum
```
urgentie_volgende_datum(volgende_startdatum):
  dagen_tot = (volgende_startdatum - nu()).days
  
  if dagen_tot <= 2:
    return "kritiek" // Rood/Oranje
  else if dagen_tot <= 7:
    return "binnenkort" // Geel
  else:
    return "normaal" // Grijs
```

---

## Tabel Rendering State

### Per rij in tabel:
```typescript
row = {
  taakdefinitie_id: string
  taaknaam: string
  proceseigenaar_naam: string
  stekkers_aantal: number
  stekkers_namen: string[]
  frequentie: string
  volgende_datum: ISO8601 | null
  volgende_datum_label: string // "Volgende week", "47 dagen", "—"
  voortgang_procent: number | null // null als geen actieve instantie
  voortgang_stap: string | null
  voortgang_tijd: string | null // "4d in stap"
  voortgang_kleur: "primary" | "warning" | "error"
  status: "actief" | "gepland" | "idle" | "vertraagd"
  is_kritiek: boolean // Voor sortering
}
```

---

## Sortering

```
gesorteerde_rijen = sort(rijen, [
  // Primaire: Status
  (rij) => {
    priority = {
      "vertraagd": 1,
      "actief": 2,
      "gepland": 3,
      "idle": 4
    }
    return priority[rij.status]
  },
  
  // Secundaire: Urgentie binnen groep
  (rij) => {
    if rij.status == "actief":
      return (rij.is_kritiek ? 0 : 1, rij.voortgang_tijd desc)
    
    if rij.status == "gepland":
      return rij.volgende_datum asc // Binnenkomende eerst
    
    return 0
  }
])
```

---

## Filtering State

### User-driven filtering
```typescript
filterState = {
  actief: boolean // default true
  gepland: boolean // default true
  idle: boolean // default true
  vertraagd: boolean // default true
}
```

### Role-based filtering (API-side)
```typescript
// Afhankelijk van huistische rol van user

recordmanager_filter:
  // Ziet alles
  geen filtering

proceseigenaar_filter:
  // Ziet alleen taken waar hij/zij proceseigenaar is
  rijen = rijen.filter(rij =>
    rij.proceseigenaar_id == current_user.id
    AND rij.status == "actief"  // Standaard filter (kan override)
  )

archivaris_filter:
  // Ziet alleen taken waar hij/zij archivaris is
  rijen = rijen.filter(rij =>
    rij.archivaris_id == current_user.id
    AND rij.status == "actief"  // Standaard filter (kan override)
  )
```

### Combined filtering
```typescript
gefilterde_rijen = rijen
  .filter(rij => apply_role_based_filter(rij, current_user))
  .filter(rij => apply_user_chosen_filter(rij, filterState))
```

---

## Taakdefinitie vs. Taakinstantie Relationchip

**Taakdefinitie** (dit scherm):
- Master-record, terugkerend
- Configuratie (frequentie, stekkers, rollen)

**Taakinstantie** (volgende niveau):
- Concrete uitvoering van taakdefinitie
- Één per cyclus
- Status: Gepland / Selectie / Beoordeling / Accordering / Uitvoering / Resultaat / Archief

**Relatie in deze view:**
- Kolom "Voortgangsbar" = voortgang van **huidige actieve instantie** van deze definitie
- Volgende datum = start van **volgende geplande instantie**

---

## Refresh Strategy

- **Initial load:** GET /taakdefinities
- **Auto-refresh:** Elke 30 seconden (polls for updates)
- **Manual refresh:** User kan ⟳ klikken

---

## Performance

- Max 50 taakdefinities per pagina
- Indien > 50: Pagination of lazy-loading
- Filtering gebeurt client-side (alle data geladen)
- Sortering gebeurt client-side (API sorteert ook)
