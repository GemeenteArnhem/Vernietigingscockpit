# Component: StekkerStatus

## Doel
Toont de voortgang en status van de uitvoering per stekker (bron/systeem).

Geeft inzicht in:
- welke systemen betrokken zijn
- hoe ver de verwerking is
- waar fouten optreden

---

## Context

- alleen zichtbaar tijdens:
  - taak.status == uitvoering

- read-only
- onderdeel van monitoring (geen acties)

---

## Belangrijk principe

- UI toont de werkelijkheid per bron
- geen aggregatie die detail verbergt
- fouten blijven zichtbaar

---

## Input (vanuit state/API)

stekkers[]:

- naam
- totaal_aantal_objecten
- verwerkt_aantal
- status

---

## Statussen (enige geldige set)

- NIET_GESTART
- BEZIG
- VOLTOOID
- FOUT

---

## Weergave per stekker

- naam
- voortgang (progress bar)
- status label
- optioneel: aantal verwerkt / totaal

---

## Voortgang

berekening:

verwerkt_aantal / totaal_aantal_objecten

weergave:

- visuele progress bar
- percentage (optioneel)

---

## Gedrag

- data wordt periodiek ververst (polling)
- UI update automatisch
- geen handmatige refresh vereist (optioneel knop)

---

## Visuele signalen

- BEZIG → neutraal / blauw
- VOLTOOID → groen
- FOUT → rood
- NIET_GESTART → grijs

---

## Regels

- status per stekker is leidend
- totale voortgang wordt elders (contextblok) getoond
- component bevat geen businesslogica

---

## Niet doen

- geen acties (geen retry knop hier)
- geen bewerkingen
- geen samenvattingen (dat hoort in contextpanel)

---

## Relatie met resultaten

- stekkerstatus toont voortgang per bron
- resultatenlijst toont detail per object

---

## Audit

Relevante events:

- batch gestart per stekker
- batch afgerond
- fout opgetreden

Deze worden zichtbaar in audit log