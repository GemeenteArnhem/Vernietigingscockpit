# Screen: Vernietigingslijst (uitvoering)

## Doel
Inzicht geven in de voortgang en resultaten van de vernietiging.

De gebruiker kan:
- vernietiging starten (indien nog niet gestart)
- voortgang volgen per bron
- resultaten per object bekijken
- fouten analyseren

---

## Context

- onderdeel van taak-detail
- zichtbaar bij:
  - taak.status == uitvoering

- vernietigingslijst is read-only
- uitvoering gebeurt via stekkers (bronsystemen)

---

## Belangrijk principe

- geen bewerkingen mogelijk
- focus op monitoring en controle
- UI toont de werkelijkheid (geen aannames)
- zelfde datastructuur als vernietigingslijst (consistentie)

---

## Data source

GET /taken/{id}/uitvoering  
GET /taken/{id}/resultaten

---

## Layout

### 1. Contextblok (ContextPanel)

Toont:

- totaal aantal objecten
- aantal succesvol verwerkt
- aantal fouten
- aantal in verwerking

---

### 2. Stekkerstatus (StekkerStatus)

Toont per bron_systeem:

- naam
- aantal objecten
- voortgang (progress bar)
- status

---

## Statussen (stekker)

- NIET_GESTART
- BEZIG
- VOLTOOID
- FOUT

---

## Gedrag

- voortgang wordt periodiek opgehaald (polling)
- status verandert dynamisch
- fouten blijven zichtbaar
- elke stekker werkt onafhankelijk

---

### 3. Resultaten per object (ResultTable)

---

## Tabel (aligned met vernietigingslijst)

### Primaire kolommen

- naam
- omvang
- bewaartermijn
- einddatum bewaartermijn
- status (verwerkingsstatus)
- foutmelding

---

## Kolom mapping

| Vernietigingslijst | Uitvoering |
|-------------------|-----------|
| naam | naam |
| omvang | omvang |
| bewaartermijn | bewaartermijn.termijnLooptijd |
| einddatum bewaartermijn | bewaartermijn.termijnEinddatum |
| status | verwerkingsstatus |
| toelichting | foutmelding |

---

## Secundaire metadata (via expand)

- id
- identificatie (kenmerk + bron)
- classificatie
- dekking in tijd (begindatum – einddatum)
- informatiecategorie (met selectielijst)
- waardering
- bron_systeem

---

## Gedrag tijdens uitvoering

- resultaten worden realtime toegevoegd
- tabel groeit dynamisch
- sortering blijft stabiel (bijv. op naam)
- geen handmatige refresh nodig

---

## Filtering (optioneel)

- filter op status (SUCCESS / FAILED / etc.)
- filter op bron_systeem

---

## Gedrag bij fouten

- FAILED direct zichtbaar in tabel
- foutmelding zichtbaar in kolom
- fouten blijven zichtbaar (geen masking)

---

## Actie (via TaskHeader)

### "Start vernietiging"

Beschikbaar indien:

state.kan_vernietigen == true
taak.status == vrijgegeven

De actie wordt uitgevoerd door de recordmanager en zet de taak van `vrijgegeven` naar `uitvoering`.

---

## Gedrag na starten

- actie verdwijnt
- scherm wordt monitor-mode
- uitvoering start per stekker

---

## Tijdens uitvoering

- geen bewerkingen mogelijk
- geen bulk acties
- alleen monitoring en analyse

---

## Bij afronding

Wanneer:

- alle stekkers status == VOLTOOID of FOUT

Dan:

- taak.status → resultaat
- scherm gaat automatisch over naar resultaat

---

## Belangrijke regels

- UI toont actuele status (single source of truth)
- geen handmatige correcties toegestaan
- fouten worden niet verborgen
- structuur blijft identiek aan vernietigingslijst

---

## Consistentie met andere schermen

- zelfde kolomvolgorde als vernietigingslijst
- zelfde veldnamen
- zelfde visuele structuur

Verschillen:

- geen selectie
- geen edit velden
- foutmelding i.p.v. toelichting

---

## Audit

De volgende events worden gelogd:

- Vernietigingsopdracht
- Uitvoering gestart
- Batch aangeboden
- Batch verwerkt
- Vernietigen (MDTO-event, per vernietigde kandidaat)
- Niet vernietigd
- Uitvoering afgerond
