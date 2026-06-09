# State: Taken-overzicht

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
    archivaris: {
      naam: string
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

### Tabelrij-data
```typescript
rij = {
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
  voortgang_kleur: "primary" | "warning" | "success" | "grey"
  status: "actief" | "gepland" | "idle" | "vertraagd"
  is_kritiek: boolean // true als vertraagd
  status_badge: string // "Actief", "Gepland", "Idle", "Vertraagd"
}
```

---

## Sortering

```typescript
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

## Filtering

### User-driven filters
```typescript
filterState = {
  vertraagd: boolean // default true
  actief: boolean // default true
  gepland: boolean // default true
  idle: boolean // default true
  mijn_taken: boolean // default false (nur for PO/Arch)
}
```

### Role-based filtering
```typescript
// Afhankelijk van rol

recordmanager:
  // Ziet alles
  gefilterde = taakdefinities

proceseigenaar:
  // Ziet alleen taakdefinities waar zij proceseigenaar zijn
  gefilterde = taakdefinities.filter(taak =>
    taak.proceseigenaar_id == current_user.id
  )

archivaris:
  // Ziet alleen taakdefinities waar zij archivaris zijn
  gefilterde = taakdefinities.filter(taak =>
    taak.archivaris_id == current_user.id
  )
```

### Combined filtering
```typescript
final_rijen = gefilterde
  .filter(rij => apply_role_based_filter(rij, current_user))
  .filter(rij => apply_user_chosen_filter(rij, filterState))
  .sort(by_priority)
```

---

## Zoeken

```typescript
zoek(taakdefinities, query):
  return taakdefinities.filter(taak =>
    taak.naam.includes(query) OR
    taak.proceseigenaar.naam.includes(query)
  )
```

---

## Laden & Refresh

```
initial_load():
  GET /taakdefinities
  
auto_refresh():
  every 30 seconds:
    GET /taakdefinities
    update UI (enkel voortgang kolom)

manual_refresh():
  user klik ⟳
  GET /taakdefinities (full reload)
```

---

## Performance

- Max 50 taakdefinities per pagina
- Indien > 50: Pagination of lazy-loading
- Filtering client-side (alle data geladen)
- Sortering client-side (API sorteert ook)
