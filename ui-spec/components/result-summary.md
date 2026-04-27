# Component: ResultSummary

## Doel
Geeft een compacte samenvatting van het eindresultaat van de vernietiging.

Helpt de gebruiker snel te begrijpen:
- hoeveel succesvol is verwerkt
- waar afwijkingen zitten

---

## Context

- alleen zichtbaar bij:
  - taak.status == resultaat

- read-only
- onderdeel van resultaatweergave

---

## Belangrijk principe

- samenvatting = interpretatie
- contextpanel = ruwe cijfers

Dit component voegt duiding toe, geen nieuwe data

---

## Input (vanuit state)

- totaal_aantal
- aantal_succes
- aantal_fouten
- aantal_overgeslagen
- aantal_niet_gevonden

---

## Berekeningen

succes_percentage:

aantal_succes / totaal_aantal * 100

---

## Weergave

Toont:

- totaal verwerkt
- aantal succesvol
- aantal fouten
- succespercentage

---

## Visuele signalen

- hoog succespercentage → groen
- fouten aanwezig → rood accent
- neutrale info → grijs

---

## Gedrag

- read-only
- geen interactie

---

## Relatie met andere componenten

- ContextPanel → toont ruwe aantallen
- ResultSummary → toont interpretatie
- ResultTable → toont detail per object

---

## Niet doen

- geen acties
- geen filtering
- geen businesslogica

---

## UX-principes

- snel scanbaar
- ondersteunt evaluatie
- benadrukt afwijkingen