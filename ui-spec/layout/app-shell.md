# Layout: AppShell

## Doel
Definieert de globale layout van de applicatie.

De AppShell bepaalt:
- de vaste structuur van de UI
- positionering van hoofdcomponenten
- consistentie over alle schermen

---

## Structuur

De applicatie bestaat uit drie hoofdgebieden:

- Sidebar (links)
- Main area (midden)
- Audit panel (rechts)

---

## Layout (horizontaal)

[ Sidebar ] [ Main area ] [ Audit panel ]

---

## Sidebar (links)

Bevat:

- hoofdnavigatie
- secundaire navigatie (onderaan)

Eigenschappen:

- vaste breedte
- altijd zichtbaar

Gebruikt component:

- SidebarNavigation

---

## Main area (midden)

Bestaat uit:

- TaskHeader (boven)
- ContentContainer (onder)

---

### Opbouw

[ TaskHeader ]
[ WorkflowBar ]
[ ContextPanel ]
[ Content ]

---

### TaskHeader

- toont titel (vernietigingslijst)
- toont status
- toont metadata (recordmanager, datum)
- bevat primary action

Zie:

/components/task-header.md

---

### ContentContainer

- toont het actieve screen
- wisselt op basis van navigatie en taakstatus

Voorbeelden:

- vernietigingslijst (beoordeling)
- accordering
- uitvoering
- resultaat

---

## Audit panel (rechts)

Bevat:

- audit log (altijd zichtbaar)

Eigenschappen:

- vaste breedte
- scrollbaar
- onafhankelijk van main content

---

## Gedrag

- Sidebar blijft zichtbaar bij navigatie
- TaskHeader blijft consistent over alle schermen
- ContentContainer wisselt per screen
- Audit panel blijft altijd zichtbaar en toont realtime updates

---

## Navigatie

- navigatie bepaalt welk screen geladen wordt
- taakstatus bepaalt welke acties beschikbaar zijn
- gebruiker navigeert primair via taken

---

## Belangrijke regels

- layout is consistent over alle schermen
- componenten worden niet verplaatst tussen schermen
- TaskHeader is altijd aanwezig binnen main area
- Audit panel is altijd zichtbaar (geen tabs of verborgen states)

---

## Niet in scope van AppShell

- inhoud van schermen (zie /screens)
- componentgedrag (zie /components)
- business logica (zie /state en /api)