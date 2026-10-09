# State: Audit Event Model

## Doel
Definieert hoe audit-events worden opgeslagen en weergegeven.

Dit model is de bron van waarheid voor:
- audit log
- compliance
- reconstructie van acties

De normerende set eventtypen staat in ADR-0003 (keten, bescherming) en ADR-0005 §5 (eventtypen volgens MDTO). De lijsten zelf staan in `designrules/begrippenlijsten/cockpit-eventtypen.md` en `cockpit-configuratie-eventtypen.md`.

---

## Belangrijk principe

- elke relevante systeem- en gebruikersactie wordt vastgelegd
- events zijn onveranderbaar (insert-only, hashketen per taakinstantie)
- events zijn chronologisch
- **MDTO is leidend**: waar MDTO een eventtype kent, wordt dat gebruikt (MDTO EventTypeLijst); anders een begrip uit Cockpit-eventtypen

---

## Event structuur

event:

- id (uniek, oplopend binnen de keten)
- tijdstip (datetime)
- actor:
  - type: user | system
  - id
  - naam
- rol (de rol waarmee de actie is uitgevoerd)
- event_type (begripLabel, bijv. "Accordering")
- event_type_begrippenlijst (naam + versie van de lijst, bijv. "MDTO EventTypeLijst 1.0" of "Cockpit-eventtypen 1.0")
- entiteit:
  - type (taakinstantie, vernietigingskandidaat, batch, verklaring)
  - id
- details (optioneel, JSON)
- vorige_hash, hash

---

## Eventtypen (enige geldige set)

### Uit de MDTO EventTypeLijst

- Creatie (taakinstantie aangemaakt; verklaring gemaakt)
- Import (selecties geïmporteerd: init → beoordeling)
- Accordering (akkoord proceseigenaar of archivaris; per kandidaat of op de lijst)
- Bevriezing (vernietigingslijst bevroren bij de vrijgave door de archivaris)
- Vernietigen (stekker meldt SUCCESS voor een kandidaat)
- Export (dossier gearchiveerd: resultaat → archief)

### Uit Cockpit-eventtypen

- Selectie aangevraagd
- Selectie opnieuw aangevraagd
- Kandidaat opgenomen
- Kandidaat uitgesloten
- Voorgelegd
- Retour
- Vernietigingsopdracht
- Uitvoering gestart
- Batch aangeboden
- Batch verwerkt
- Niet vernietigd
- Uitvoering mislukt
- Uitvoering opnieuw aangevraagd
- Uitvoering afgerond
- Archivering aangevraagd
- Archivering mislukt
- Logisch verwijderd

Configuratie-events (globaal configuratielog, niet in de taak-audit): zie Cockpit-configuratie-eventtypen.

---

## Details veld (voorbeelden)

Voor *Kandidaat uitgesloten*:

{
  "uitsluitReden": "Lopend verzoek of procedure",
  "toelichting": "Woo-verzoek 2026-117 loopt"
}

Bij automatische uitsluiting (actor system):

{
  "uitsluitReden": "Waardering niet V",
  "waardering": "B"
}

---

Voor *Retour*:

{
  "toelichting": "Onvoldoende onderbouwing"
}

---

Voor *Vernietigen*:

{
  "eventTijd": "2026-10-08T14:03:12Z",
  "vernietigingsmethode": "Verwijderd via bronfunctie",
  "specificatieSha256": "…"
}

Voor *Niet vernietigd*:

{
  "resultaat": "CHANGED",
  "foutmelding": "Zaak is na selectie heropend"
}

---

## Regels

- events worden nooit aangepast of verwijderd (uitzondering: de gecontroleerde verwijdering van een volledige werkkopie, ADR-0006)
- events zijn append-only
- volgorde is leidend voor reconstructie
- een nieuw eventtype komt er alleen via een wijziging van de begrippenlijst of van ADR-0005

---

## Relatie met UI

- de AuditLog-component toont deze events
- de UI toont `event_type` zoals vastgelegd, zonder vertaling; er is geen weergavetabel
- de UI mag events niet interpreteren, alleen weergeven

---

## Relatie met systeem

- elke UI-actie levert minimaal één audit-event op
- de backend is verantwoordelijk voor registratie

---

## UX-principes

- transparantie
- herleidbaarheid
- vertrouwen

---

## Samenvatting

Dit model zorgt ervoor dat:

- elke stap in het proces traceerbaar is
- het auditlog volledig en betrouwbaar is
- de eventgeschiedenis aansluit op MDTO en zonder vertaling in het archiefpakket kan
