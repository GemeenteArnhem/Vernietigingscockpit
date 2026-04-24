# UI/UX Design Specification – Vernietigingscockpit
Versie: 2.0 (Aangescherpt op basis van mockups)  
Status: Normatief ontwerpdocument (bouwbaar)  
Doelgroep: Leveranciers, ontwerpers, ontwikkelaars

---

# 1. Doel en positionering

Dit document beschrijft de **bindende UI/UX ontwerpregels, interacties en schermstructuur** voor de Vernietigingscockpit.

Het document:
- is **normerend en afdwingbaar**
- beschrijft **gedrag, interactie en structuur**
- is geschikt voor **implementatie én AI UI generatie**
- borgt **besluitvorming, auditability en gebruiksvriendelijkheid**

---

# 2. Kernprincipe

De UI is een **besluitvormingsinstrument**.

De UI moet:
- expliciet maken wat de gebruiker moet doen
- zichtbaar maken wie aan zet is
- context geven vóór elke beslissing
- alle stappen en keuzes vastleggen

De UI mag niet:
- impliciete acties bevatten
- beslissingen verbergen
- context verstoppen

---

# 3. Gebruikers en kernbeslissingen

| Rol | Kernbeslissing |
|-----|---------------|
| Recordmanager | Mag deze set kandidaten door naar accordering? |
| Proceseigenaar | Is het verantwoord om deze set te vernietigen? |
| Archivaris | Is deze vernietiging rechtmatig en aantoonbaar? |
| Functioneel beheerder | Kan deze vernietiging technisch correct worden uitgevoerd? |

---

# 4. Decision Model

1. Beoordeling kandidaten  
2. Accordering (inhoudelijk)  
3. Accordering (formeel)  
4. Start vernietiging  
5. Afronding  

Elke stap bevat:
- één kernbeslissing
- één primaire actie
- expliciete context

---

# 5. Navigatie

## 5.1 Hoofdnavigatie
- Dashboard  
- Vernietigingstaken  
- Beheer  

## 5.2 Binnen taak (workflow)

Workflow is **geen navigatie**, maar **sturing**:

[ Selectie ] → [ Proceseigenaar ] → [ Archivaris ] → [ Uitvoering ] → [ Resultaat ]

Regels:
- huidige stap is actief
- toekomstige stappen zijn geblokkeerd
- workflow bepaalt beschikbare acties

---

# 6. Schermoverzicht

1. Dashboard  
2. Taakconfiguratie  
3. Taak (Dossier)  
4. Beheer  

---

# 7. Taak (Dossier) – Structuur

## 7.1 Header (altijd zichtbaar)

Toont:
- taaknaam
- workflowstatus (stap)
- actieve rol (wie is aan zet)
- primaire actie (CTA)
- aantal objecten (totaal / uitgesloten / fouten)
- startdatum
- tijd in huidige stap
- laatste activiteit

---

## 7.2 Workflowbalk

Toont:
- stappen
- huidige positie
- voortgang
- tijd in stap
- vertraging (visueel gemarkeerd)

---

## 7.3 Contextblok

Toont:
- totaal aantal objecten
- uitgesloten objecten
- afwijkingen / onzekerheden
- belangrijke signalen

---

## 7.4 Hoofdvlak

Bevat de actieve view (zie hoofdstuk 8)

---

## 7.5 Actiegebied

Bevat:
- primaire actie (dominant)
- secundaire acties (ondergeschikt)

Regels:
- altijd precies één primaire actie
- actie correspondeert met kernbeslissing

---

# 8. Views binnen Taak (Dossier)

---

## 8.1 Kandidaten (Recordmanager)

### Toont:
- lijst van objecten
- metadata per object
- status per object (geselecteerd / uitgesloten)

### Interactie:
- uitsluiten van objecten
- toevoegen van toelichting
- bulk selectie

### Filtering:
- filtering per kolom (inline)
- combinatie van filters
- realtime update

### Regels:
- uitsluiting moet zichtbaar zijn
- filtering verbergt geen context
- bulkacties tonen impact vooraf

---

## 8.2 Accordering (Proceseigenaar)

### Toont:
- samenvatting van dataset
- uitsluitingen
- toelichtingen recordmanager

### Acties:
- akkoord
- terugsturen
- uitzonderingen toevoegen

### Regels:
- geen technische details zichtbaar
- focus op begrijpelijkheid

---

## 8.3 Accordering (Archivaris)

### Toont:
- volledige samenvatting
- accordering proceseigenaar
- auditinformatie

### Acties:
- definitief akkoord
- terugsturen

### Regels:
- nadruk op rechtmatigheid
- volledige transparantie

---

## 8.4 Uitvoering

### Toont:
- lijst van stekkers
- aantallen per bron
- geplande acties

### Feedback:
- status per stekker (bezig / geslaagd / fout)
- visuele indicatoren (spinner, checkmark)

### Acties:
- starten vernietiging (met bevestiging)

### Regels:
- uitvoering is expliciet zichtbaar
- fouten zijn traceerbaar

---

## 8.5 Resultaat

### Toont:
- resultaat per object
- samenvatting per stekker
- fouten en afwijkingen
- vernietigingsverklaring

### Acties:
- bekijken resultaten
- downloaden verklaring

---

## 8.6 Dossier / Audit

### Toont:
- volledige historie
- accorderingen
- wijzigingen
- logging
- aantekeningen

---

# 9. Objectniveau interactie

De UI moet ondersteunen:

- uitsluiten van objecten
- toevoegen van toelichting per object
- inzicht in objectstatus

Regels:
- uitsluiting kan verplicht toelichting vereisen
- status moet direct zichtbaar zijn
- acties zijn direct toepasbaar

---

# 10. Aantekeningen en audit

De UI moet ondersteunen:

- taakniveau aantekeningen
- objectniveau aantekeningen

Regels:
- aantekeningen zijn onderdeel van audit
- gekoppeld aan gebruiker en tijd
- zichtbaar in alle vervolgstappen

---

# 11. Bulkacties

De UI moet ondersteunen:

- selectie van meerdere objecten
- bulk wijzigingen

Regels:
- preview vóór uitvoering
- expliciete bevestiging
- omkeerbaar vóór accordering

---

# 12. Tijd en voortgang

De UI moet tonen:

- startdatum taak
- tijd in huidige stap
- laatste activiteit

De UI moet:
- vertraging signaleren
- prioriteit visueel maken

---

# 13. Actiepatronen

Elke view bevat:

- één primaire actie
- optionele secundaire acties

Regels:
- primaire actie is visueel dominant
- primaire actie reflecteert kernbeslissing
- secundaire acties zijn ondergeschikt

---

# 14. Taak als centrale context

De UI moet:

- alle interacties binnen één taak houden
- context behouden tussen stappen
- consistent header en workflow tonen

---

# 15. Scheiding verantwoordelijkheden

## Recordmanager
- configureert taken
- beoordeelt kandidaten
- start vernietiging

## Proceseigenaar / Archivaris
- accorderen
- geen technische interactie

## Functioneel beheerder
- configureert stekkers
- beheert systeem

---

# 16. Beheer (apart scherm)

Toont:
- stekkers
- configuraties
- endpoints
- logging

Regels:
- niet zichtbaar voor recordmanager
- strikt gescheiden van taak UI

---

# 17. UX Principes

- explicietheid boven gemak  
- besluitvorming centraal  
- audit-first ontwerp  
- taakgericht werken  
- tijd zichtbaar maken  
- gebruiker sturen naar actie  
- scheiding inhoud vs techniek  

---

# 18. Implementatie en overdracht

Dit document is leidend voor:

- frontend ontwerp (React)
- componentstructuur
- UX gedrag
- acceptatiecriteria
- AI UI generatie

Afwijkingen zijn alleen toegestaan met expliciete motivatie.