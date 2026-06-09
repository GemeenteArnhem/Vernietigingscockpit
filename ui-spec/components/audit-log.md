# Component: AuditLog

## Doel
Toont alle gebeurtenissen binnen een taak.

De audit log is de bron van waarheid voor:
- wat is er gebeurd
- wanneer
- door wie

---

## Belangrijk principe

- audit log is altijd zichtbaar
- audit log is onveranderbaar
- audit log bevat alleen feiten (geen interpretatie)

---

## Zichtbaarheid

- zichtbaar op alle taak-gerelateerde schermen:
  - taak-start
  - kandidaten
  - accordering
  - uitvoering
  - resultaat

---

## Plaatsing

- rechterpaneel (voorkeur)
- of onderaan scherm

---

## Data (input)

events[]:

- timestamp
- actor (gebruiker of systeem)
- actie
- details (optioneel)

---

## Weergave

Per event:

- datum + tijd
- actor (naam of systeem)
- korte beschrijving van actie
- optioneel detail

---

## Voorbeelden events

- Taak aangemaakt
- Selectie opgehaald
- Object uitgesloten
- Toelichting toegevoegd
- Accordering goedgekeurd
- Accordering teruggestuurd
- Vernietiging gestart
- Batch verwerkt
- Fout opgetreden
- Vernietiging afgerond
- Verklaring gegenereerd

---

## Sortering

- chronologisch
- nieuwste bovenaan of onderaan (consistent houden)

---

## Gedrag

- read-only
- geen filtering of editing vereist (optioneel later)
- scrollbaar

---

## Regels

- events worden nooit aangepast of verwijderd
- elk belangrijk systeem- en gebruikersactie wordt gelogd
- audit log is onderdeel van dossier

---

## Niet doen

- geen businesslogica in component
- geen samenvattingen (dat hoort in context/samenvatting)
- geen afgeleide conclusies tonen

---

## Relatie met systeem

- alle acties in UI moeten corresponderen met een audit event
- audit log moet volledig reproduceerbaar zijn

---

## UX-principes

- transparantie
- vertrouwen
- controle

De audit log ondersteunt:
- controle achteraf
- compliance
- debugging