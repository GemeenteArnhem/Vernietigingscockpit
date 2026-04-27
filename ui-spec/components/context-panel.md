# Component: ContextPanel

## Doel
Geeft een samenvatting van de inhoud van de taak.

Ondersteunt de gebruiker bij:
- begrijpen van de situatie
- nemen van beslissingen

---

## Belangrijk principe

- context = inhoud
- header = actie

Deze component bevat:
- alleen inhoudelijke informatie
- geen acties

---

## Input (vanuit state)

- totaal aantal objecten
- aantal uitgesloten
- aantal fouten / afwijkingen
- aantal succesvol (indien uitvoering/resultaat)
- aantal in verwerking (indien uitvoering)

---

## Weergave

Toont kerncijfers, bijvoorbeeld:

- Totaal objecten
- Uitgesloten
- Fouten / afwijkingen
- Succesvol verwerkt (indien van toepassing)

---

## Gedrag per workflow fase

### init
- geen cijfers (nog geen selectie)
- eventueel melding:
  "Nog geen selectie uitgevoerd"

---

### beoordeling
- totaal
- uitgesloten
- afwijkingen

---

### accordering
- zelfde als beoordeling
- read-only

---

### uitvoering
- totaal
- succesvol
- fouten
- in verwerking

---

### resultaat
- totaal
- succesvol
- fouten
- overgeslagen
- niet gevonden

---

## Visuele signalen

- fouten → rood accent
- waarschuwingen → oranje
- succes → groen

---

## Regels

- cijfers moeten consistent zijn met data in hoofdvlak
- geen duplicatie met header
- geen businesslogica (alleen weergave)

---

## Niet tonen

- knoppen
- acties
- workflow status (dat zit in header/workflowbalk)

---

## UX-principes

- snel scanbaar
- ondersteunt besluitvorming
- altijd zichtbaar boven hoofdinhoud