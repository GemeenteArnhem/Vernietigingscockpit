# State: Taakdefinitie-detail

## Input Data (from API)

### Taakdefinitie Detail
```typescript
taakdefinitie: {
  id: string
  naam: string
  proceseigenaar: {
    id: string
    naam: string
    rol: string
  }
  archivaris: {
    id: string
    naam: string
    rol: string
  }
  frequentie: "jaarlijks" | "kwartaal" | "maandelijks" | "ad-hoc"
  startmaand: number | null // 1-12, null voor ad-hoc
  
  stekkers: Array<{
    id: string
    naam: string
    beschrijving: string
  }>
  
  // Statistieken
  aantal_uitgevoerd: number
  eerste_run_datum: ISO8601 | null
  laatste_run_datum: ISO8601 | null
  
  // Relatie naar instanties
  volgende_instantie: TaakInstantie | null
  actieve_instantie: TaakInstantie | null
}

// Instanties voor geschiedenis
instanties: TaakInstantie[] = [
  {
    id: string
    naam: string // "Zorgdomein 2025"
    status: "resultaat" | "archief"
    startdatum: ISO8601
    einddatum: ISO8601
    aantal_objecten: number
    aantal_vernietigd: number
    aantal_fouten: number
    verklaring_url: string // PDF URL
  }
  // ...
]
```

---

## Derived State: Sectie 1 (Configuratie)

```typescript
configuratie_card = {
  taaknaam: string
  frequentie_label: string // "Jaarlijks", "Kwartaal", etc
  volgende_datum: ISO8601 | null
  volgende_datum_label: string // "1 juli 2026", "47 dagen", "—"
  
  proceseigenaar_naam: string
  archivaris_naam: string
  frequentie: string
  startmaand: number | string
  stekkers_beschrijving: string // Geformateerde lijst
  
  stats: {
    aantal_uitgevoerd: number
    eerste_run: ISO8601 | string
    laatste_run: ISO8601 | string
  }
  
  can_edit: boolean // true = huidge user is RM
}
```

---

## Derived State: Sectie 2 (Volgende Geplande)

```typescript
volgende_kaart = {
  instantie_id: string
  naam: string // "Zorgdomein 2027"
  status: "gepland"
  geplande_datum: ISO8601
  dagen_tot: number
  afstand_label: string // "387 dagen", "Volgende week"
  
  status_message: string // "Selectie niet gestart"
  
  acties: {
    // RM only
    start_selectie?: boolean
    kopier_vorige?: boolean
    details?: boolean
  }
}
```

---

## Derived State: Sectie 3 (Actieve Instantie)

### Structuur
```typescript
actieve_kaart = {
  instantie_id: string
  naam: string // "Zorgdomein 2026"
  
  status: string
  status_badge: string // "🟠 Beoordeling"
  status_kleur: "primary" | "warning" | "error" | "success"
  
  voortgang: {
    procent: number // 0-100
    huidge_stap: string // "Beoordeling"
  }
  
  workflow_stappen: Array<{
    naam: string // "Selectie", "Beoordeling", etc
    status: "done" | "in_progress" | "waiting"
    start_datum: ISO8601
    tijd_in_stap: string // "1d", "4d", etc
    rol_aan_zet: string | null // "Recordmanager", "Proceseigenaar", etc
  }>
  
  statistieken: {
    aantal_objecten: number
    aantal_fouten: number
    startdatum: ISO8601
  }
  
  huidge_rol: string // Wie is nu aan zet
  
  acties: {
    primaire: string // "Beoordelen" | "Accorderen" | "Uitvoeren"
    primaire_href: string
    secundaire: Array<{
      label: string
      href: string
    }>
  }
}
```

### Stap-status bepalen
```typescript
bepaal_stap_status(stap, huidge_stap, workflow_positie):
  
  if stap.positie < workflow_positie:
    return "done" // Afgerond (groen vinkje)
  
  else if stap.naam == huidge_stap:
    return "in_progress" // In progress (pijl)
  
  else:
    return "waiting" // Nog niet bereikt (zandloper)
```

### Rol aan zet bepalen
```typescript
bepaal_rol_aan_zet(huidge_stap):
  switch(huidge_stap) {
    case "selectie":
      return "Recordmanager"
    case "beoordeling":
      return "Recordmanager"
    case "accordering_po":
      return "Proceseigenaar"
    case "accordering_arch":
      return "Archivaris"
    case "uitvoering":
      return "Systeem"
    case "resultaat":
      return "Archief"
  }
```

### Acties bepalen (Context-aware)
```typescript
bepaal_acties(huidge_stap, current_user_rol):
  
  // Recordmanager
  if current_user_rol == "recordmanager":
    if huidge_stap in ["selectie", "beoordeling"]:
      return {
        primaire: "Beoordelen",
        primaire_href: `/taakinstantie/${id}/kandidaten`,
        secundaire: [
          { label: "Details", href: `/taakinstantie/${id}` }
        ]
      }
  
  // Proceseigenaar
  else if current_user_rol == "proceseigenaar":
    if huidge_stap == "accordering_po":
      return {
        primaire: "Accorderen",
        primaire_href: `/taakinstantie/${id}/accordering`,
        secundaire: [
          { label: "Details", href: `/taakinstantie/${id}` }
        ]
      }
  
  // Archivaris
  else if current_user_rol == "archivaris":
    if huidge_stap == "accordering_arch":
      return {
        primaire: "Accorderen",
        primaire_href: `/taakinstantie/${id}/accordering`,
        secundaire: [
          { label: "Details", href: `/taakinstantie/${id}` }
        ]
      }
  
  // Geen actie (informatief)
  else:
    return {
      primaire: "Details",
      primaire_href: `/taakinstantie/${id}`
    }
```

---

## Derived State: Sectie 4 (Geschiedenis)

### Tabel-rijen
```typescript
geschiedenis_rijen: Array<{
  instantie_id: string
  naam: string // "2025", "2024", etc
  status_badge: string // "✓" (Afgerond) of "📄" (Archief)
  afgerond_op: ISO8601 | string
  
  verklaring_url: string | null
  
  acties: {
    details: string // `/taakinstantie/${id}`
    dossier: string // `/taakinstantie/${id}#dossier`
  }
}>
```

### Sortering geschiedenis
```
sort(instanties, (a, b) =>
  b.einddatum - a.einddatum // Meest recent eerst
)
```

### Paginering
```
max_rows_per_pagina: 10
total_rows: instanties.length
current_page: 1
```

---

## Bepaal welke sectie zichtbaar

### Volgende Instantie (Sectie 2)
```
is_visible: 
  volgende_instantie != null
  AND volgende_instantie.status == "gepland"
```

### Actieve Instantie (Sectie 3)
```
is_visible:
  actieve_instantie != null
  
empty_state (Sectie 3b):
  actieve_instantie == null
  AND volgende_instantie != null
```

### Geschiedenis (Sectie 4)
```
is_visible:
  instanties.length > 0
```

---

## Laden & Refresh

```
initial_load():
  GET /taakdefinities/{taakdefinitie_id}
  GET /taakdefinities/{taakdefinitie_id}/instanties?limit=50

auto_refresh():
  every 30 seconds:
    GET /taakdefinities/{taakdefinitie_id} (configuratie + actieve)
    update voortgang in Sectie 3
    
manual_refresh():
  user klik ⟳
  GET /taakdefinities/{taakdefinitie_id}
  GET /taakdefinities/{taakdefinitie_id}/instanties
```

---

## Navigatie-state

```typescript
navigation = {
  back_link: "/taken-overzicht"
  edit_link: current_user.rol == "recordmanager" 
    ? `/taakdefinitie/${id}/edit`
    : null
  
  volgende_klik_href: `/taakdefinitie/${id}/instantie/${volgende_instantie.id}`
  actief_klik_href: `/taakdefinitie/${id}/instantie/${actieve_instantie.id}`
  
  actief_primaire_actie_href:
    bepaal_primaire_actie_href(actieve_instantie.huidge_stap)
}
```

---

## Performance

- Initial load: 2 API calls
- Auto-refresh: 1 API call (slim update)
- Geschiedenis pagination: max 10 rijen zichtbaar
- Lazy-load volgende pagina (bij scroll of klik "Meer laden")
