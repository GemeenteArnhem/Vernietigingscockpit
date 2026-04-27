# Design System: Layout

## Doel
Definieert layout-, spacing- en compositieregels voor de UI.

Dit is een aanvulling op NL Design System:
- NLDS → componenten (buttons, inputs, etc.)
- dit document → hoe die componenten samenkomen in schermen

---

## Belangrijk principe

- consistent ritme over alle schermen
- voorspelbare layout
- minimale variatie

---

# 1. Grid & pagina-opbouw

## Pagina breedte

- max width: 1280px
- content padding (links/rechts): 24px

---

## Hoofd layout

Structuur:

[ Sidebar ] [ Main content ] [ Audit panel ]

---

### Sidebar

- breedte: 240px
- achtergrond: wit
- geen zware visuele nadruk

---

### Main content

- flexibel
- max width binnen grid
- padding: 24px

---

### Audit panel

- vaste breedte: 320px
- altijd zichtbaar
- rechts uitgelijnd
- zelfde verticale padding als main content

---

## Gaps

- tussen hoofdblokken: 24px
- tussen secties: 24px
- binnen secties: 16px

---

# 2. Vertical rhythm

Gebruik vaste spacing schaal:

- 8px
- 16px
- 24px
- 32px

---

## Regels

- nooit afwijkende waarden (zoals 10px, 18px)
- grote secties → 24px
- interne spacing → 16px
- compacte elementen → 8px

---

# 3. Cards

## Gebruik

Cards worden gebruikt voor:

- context metrics
- blokken met inhoud
- audit panel

---

## Stijl

- padding: 16px
- border: 1px solid #E5E7EB
- border-radius: 8px
- shadow: zeer subtiel of geen

---

## Regels

- geen nested cards tenzij echt nodig
- cards altijd uitlijnen op grid

---

# 4. Context metrics

## Layout

- altijd 4 per rij
- gelijke breedte
- gelijke hoogte

---

## Inhoud

- label (klein)
- waarde (groot)
- optioneel icon

---

## Spacing

- padding: 16px
- gap tussen cards: 16px

---

# 5. Tabellen

## Doel

Primair component voor data en interactie

---

## Layout

- full width binnen container
- consistente kolombreedtes per scherm

---

## Rijhoogte

- standaard: 44px

---

## Padding

- cel padding: 12px (verticaal en horizontaal)

---

## Header

- font-weight: semibold
- subtiel onderscheid (licht grijs)

---

## Regels

- geen variërende rijhoogtes
- inline editing binnen vaste structuur
- geen visuele ruis (zware borders vermijden)

---

# 6. Filters

## Plaatsing

- direct boven tabel
- onderdeel van dezelfde container

---

## Stijl

- compact
- inline (geen apart paneel)

---

## Spacing

- gap tussen filters: 8–16px

---

# 7. Bulk actie balk

## Gedrag

- alleen zichtbaar bij selectie

---

## Layout

- onder tabel
- full width

---

## Stijl

- achtergrond: licht grijs (#F9FAFB)
- border-top: 1px solid #E5E7EB
- padding: 12–16px

---

# 8. Validatie

## Inline validatie

- in tabelrij
- gekoppeld aan input

---

## Globale validatie

- onder bulk acties

---

## Stijl

- lichte rode achtergrond
- geen zware visuele dominantie

---

# 9. Header (taak detail)

## Inhoud

- titel
- status
- metadata (recordmanager, datum)
- primary action

---

## Layout

- horizontaal verdeeld
- primary action rechts

---

## Spacing

- onder header: 24px

---

# 10. Workflowbalk

## Layout

- horizontaal
- stappen gelijk verdeeld

---

## Spacing

- boven en onder: 16–24px

---

# 11. Audit panel

## Structuur

- verticale timeline
- events onder elkaar

---

## Spacing

- tussen events: 12px
- padding: 16px

---

## Regels

- altijd zichtbaar
- nooit verbergen achter tabs

---

# 12. Component consistentie regels

## Altijd gelijk houden:

- spacing tussen blokken
- audit panel breedte
- tabel structuur
- context card layout

---

## Niet doen

- per scherm andere layout bedenken
- variëren in spacing
- audit panel verplaatsen
- tabellen anders structureren

---

# 13. Samenvatting

Dit layout system zorgt voor:

- visuele rust
- voorspelbaarheid
- snellere UX
- consistente implementatie

---

## Kernregel

Niet elk scherm opnieuw ontwerpen.

→ Gebruik dezelfde layout, elke keer.