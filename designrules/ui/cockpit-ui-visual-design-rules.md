# UI Visual Design Rules – Vernietigingscockpit (NLDS & React Compliant)
Versie: 2.0  
Status: Normatief – visuele laag (ondersteunend aan UX document)

---

# 1. Doel en positionering

Dit document beschrijft de **visuele ontwerpregels** voor de Vernietigingscockpit.

Deze regels:
- ondersteunen de UX en interactieregels
- zorgen voor consistentie en herkenbaarheid
- zijn **conform NL Design System (NLDS)**
- zijn geschikt voor **React implementatie**

---

# 2. Relatie tot UX en NLDS

## 2.1 Rol van dit document

Dit document bepaalt:
- visuele hiërarchie
- gebruik van kleur en vorm
- consistent gedrag van UI-elementen

## 2.2 Rol van NL Design System

NLDS levert:
- componenten (Button, Table, Input, etc.)
- design tokens (kleur, spacing, typografie)
- toegankelijkheidsrichtlijnen

## 2.3 Leidende principes

- UX document bepaalt gedrag
- NLDS bepaalt component en styling
- dit document bepaalt toepassing en consistentie

Bij conflict geldt:
- UX (besluitvorming) is leidend boven visuele vorm

---

# 3. Algemene stijlprincipes

- clean en functioneel (geen decoratie zonder functie)
- visuele hiërarchie ondersteunt besluitvorming
- consistent gebruik van componenten
- visuele eenvoud boven esthetiek

---

# 4. Design Tokens (verplicht)

## 4.1 Gebruik van tokens

Alle visuele eigenschappen moeten via tokens worden toegepast.

Niet toegestaan:
- hardcoded kleuren (#fff, #000)
- vaste spacing (16px, 24px)

Verplicht:
- gebruik van NLDS tokens

---

## 4.2 Kleur tokens

Gebruik:

- `--color-primary`
- `--color-success`
- `--color-warning`
- `--color-danger`
- `--color-neutral`

### Mapping

| Betekenis | Token |
|----------|------|
| Primaire actie | var(--color-primary) |
| Succes | var(--color-success) |
| Waarschuwing | var(--color-warning) |
| Fout | var(--color-danger) |
| Inactief | var(--color-neutral) |

---

## 4.3 Overige tokens

Gebruik:

- `--spacing-*` (layout en padding)
- `--radius-*` (afronding)
- `--font-*` (typografie)

---

# 5. Buttons (NLDS compliant)

Gebruik NLDS Button component.

## 5.1 Variants

- `primary`
- `secondary`
- `destructive`

## 5.2 React gebruik

```jsx
<Button variant="primary">Akkoord</Button>
<Button variant="secondary">Terug</Button>
<Button variant="destructive">Vernietigen</Button>
```

## 5.3 Regels

- altijd precies één primary button per view
- primary button is visueel dominant
- secondary is ondersteunend
- destructive alleen bij kritieke acties
- labels zijn werkwoorden

---

# 6. Vormgeving (Shape & Layout)

## 6.1 Vormgeving

- gebruik lichte afronding via token (`--radius-default`)
- geen extreme vormen (geen pill-buttons tenzij functioneel)
- consistente componentvormen

## 6.2 Layout

Gebruik NLDS grid en spacing tokens:

- `--spacing-sm`
- `--spacing-md`
- `--spacing-lg`

Regels:
- consistente marges en padding
- duidelijke scheiding tussen secties

---

# 7. Typografie

Gebruik NLDS typografie tokens.

## Regels

- duidelijke hiërarchie (H1, H2, body)
- labels boven velden
- geen overmatig gebruik van hoofdletters
- tekst ondersteunt begrip van besluit

---

# 8. Tabellen (Data Table)

Gebruik NLDS Data Table component.

## 8.1 Gedrag

- kolomtitels altijd zichtbaar
- hover state verplicht
- selectie zichtbaar per rij

## 8.2 Optioneel

- zebra striping (indien leesbaarheid vereist)

---

# 9. Status en feedback

## 9.1 Statusweergave

Gebruik:

- Badge / Tag component
- kleur + tekst + eventueel icoon

## 9.2 Feedback

| Status | Weergave |
|-------|--------|
| Laden | Spinner |
| Succes | Checkmark |
| Fout | Alert / melding |

## Regels

- status is altijd zichtbaar
- status is nooit alleen kleur
- fouten bevatten context

---

# 10. Workflow visualisatie

Workflow wordt visueel ondersteund via:

- progress indicator / stepper

## Regels

- huidige stap is visueel dominant
- afgeronde stappen zijn herkenbaar
- toekomstige stappen zijn gedempt
- vertraging wordt visueel gemarkeerd

---

# 11. Interactie feedback

De UI moet reageren op interactie.

## Verplicht

- hover states
- focus states
- click feedback
- disabled states

## Regels

- alle interactieve elementen geven feedback
- states zijn consistent

---

# 12. Toegankelijkheid (WCAG)

De UI moet minimaal voldoen aan WCAG 2.2 AA.

## Verplicht

- voldoende contrast (via tokens)
- keyboard navigatie
- zichtbare focus states
- semantische HTML (via NLDS componenten)

---

# 13. Consistentie

## Regels

- dezelfde component → zelfde gedrag
- dezelfde actie → zelfde visuele representatie
- geen variatie zonder expliciete reden

---

# 14. Anti-patterns (verboden)

Niet toegestaan:

- meerdere primary buttons
- kleur zonder betekenis
- decoratieve UI zonder functie
- afwijking van NLDS componenten zonder motivatie
- hardcoded styling buiten tokens

---

# 15. Implementatie (React)

## Regels

- gebruik NLDS component library
- gebruik tokens via CSS variables of theme
- geen custom styling buiten design tokens
- componenten blijven consistent met UX gedrag