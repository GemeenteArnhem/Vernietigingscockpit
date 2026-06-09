# UI/UX Interactie & Structuur – Vernietigingscockpit (NLDS & React Compliant)
Versie: 3.0  
Status: Normatief ontwerpdocument (UX + interactie + implementatiegericht)  
Doelgroep: Leveranciers, ontwerpers, ontwikkelaars

---

# 1. Doel en positionering

Dit document beschrijft de **bindende UX-structuur, interactieregels en schermopbouw** van de Vernietigingscockpit.

Het document:
- is **leidend voor gedrag en structuur**
- borgt **besluitvorming en auditability**
- is geschikt voor **React implementatie**
- is compatibel met **NL Design System (NLDS)**

---

# 2. Kernprincipe

De UI is een **besluitvormingsinstrument**.

De UI moet:
- expliciet maken wat de gebruiker moet doen
- zichtbaar maken wie aan zet is
- context tonen vóór elke beslissing
- alle stappen en keuzes vastleggen

De UI mag niet:
- impliciete stappen bevatten
- context verbergen
- gebruikers laten zoeken naar acties

---

# 3. Gebruikers en kernbeslissingen

| Rol | Kernbeslissing |
|-----|---------------|
| Recordmanager | Mag deze set kandidaten door naar accordering? |
| Proceseigenaar | Is het verantwoord om deze set te vernietigen? |
| Archivaris | Is deze vernietiging rechtmatig en aantoonbaar? |

---

# 4. Decision Model (leidend voor UX)

1. Beoordeling kandidaten  
2. Accordering (inhoudelijk)  
3. Accordering (formeel)  
4. Start vernietiging  
5. Afronding  

Regels:
- elke stap = 1 beslissing
- elke stap = 1 primaire actie
- elke stap heeft expliciete context

---

# 5. Navigatiestructuur

## 5.1 Hoofdnavigatie

- Dashboard  
- Vernietigingstaken  
- Beheer  

---

## 5.2 Binnen taak (workflow gestuurd)

Workflow is **geen navigatie**, maar **sturing**:

[ Selectie ] → [ Proceseigenaar ] → [ Archivaris ] → [ Uitvoering ] → [ Resultaat ]

Regels:
- huidige stap is actief
- volgende stappen zijn geblokkeerd
- gebruiker navigeert niet, maar wordt geleid

---

# 6. Schermoverzicht

1. Dashboard  
2. Taakconfiguratie  
3. Taak (Dossier)  
4. Beheer  

---

# 7. Taak (Dossier) – Hoofdscherm

De taak is de **centrale UX-container**.

Alle interacties vinden plaats binnen deze context.

---

## 7.1 Header (altijd zichtbaar)

Toont:
- taaknaam
- workflowstatus (huidige stap)
- actieve rol (wie is aan zet)
- primaire actie (CTA)
- aantallen (totaal / uitgesloten / fouten)
- startdatum
- tijd in huidige stap
- laatste activiteit

---

## 7.2 Workflowbalk

Toont:
- alle stappen
- huidige positie
- afgeronde stappen
- toekomstige stappen

Aanvullend:
- tijd per stap
- vertraging indicatie

---

## 7.3 Contextblok

Toont:
- totaal aantal objecten
- aantal uitgesloten
- aantal afwijkingen
- belangrijke signalen

Doel:
- snelle interpretatie vóór actie

---

## 7.4 Hoofdvlak (View container)

Toont de actieve view:

- Kandidaten
- Accordering
- Uitvoering
- Resultaat
- Dossier

---

## 7.5 Actiegebied

Bevat:
- één primaire actie
- secundaire acties

Regels:
- primaire actie is altijd zichtbaar
- actie correspondeert met kernbeslissing

---

# 8. Views binnen Taak

---

## 8.1 Kandidaten (Recordmanager)

### Toont:
- tabel met objecten (NLDS Data Table)
- metadata per object
- status per object

### Interactie:
- object uitsluiten
- toelichting toevoegen
- bulk selectie

### Filtering:
- inline filters per kolom
- combinatie van filters
- realtime update

### Regels:
- filtering verliest context niet
- bulkacties tonen impact vooraf
- status zichtbaar per object

---

## 8.2 Accordering (Proceseigenaar)

### Toont:
- samenvatting dataset
- uitsluitingen
- toelichtingen recordmanager

### Acties:
- akkoord
- terugsturen
- uitzonderingen toevoegen

### Regels:
- geen technische details
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
- lijst stekkers
- aantallen per bron
- geplande acties

### Feedback:
- status per stekker (bezig / geslaagd / fout)
- visuele feedback (spinner / checkmark)

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
- bekijken
- downloaden

---

## 8.6 Dossier / Audit

### Toont:
- historie
- accorderingen
- wijzigingen
- logging
- aantekeningen

---

# 9. Objectniveau interactie

De UI moet ondersteunen:

- uitsluiten van objecten
- toevoegen van toelichting per object
- inzicht in status

Regels:
- status direct zichtbaar
- acties direct toepasbaar
- consistent gedrag per object

---

# 10. Aantekeningen en audit

De UI moet ondersteunen:

- taakniveau aantekeningen
- objectniveau aantekeningen

Regels:
- gekoppeld aan gebruiker en tijd
- zichtbaar in alle stappen
- onderdeel van audit trail

---

# 11. Bulkacties

De UI moet ondersteunen:

- multi-select
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
- secundaire acties

Regels:
- primaire actie is dominant
- reflecteert kernbeslissing
- secundaire acties zijn ondergeschikt

---

# 14. Taak als centrale context

De UI moet:

- alle interacties binnen taak houden
- context behouden tussen stappen
- consistente header en workflow tonen

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

# 16. Beheer (apart domein)

Toont:
- stekkers
- configuraties
- endpoints
- logging

Regels:
- niet zichtbaar voor recordmanager
- strikt gescheiden van taak UI

---

# 17. NL Design System integratie

## 17.1 Gebruik

De UI gebruikt NLDS voor:
- componenten (Button, Table, Input)
- tokens (kleur, spacing, typografie)
- toegankelijkheid

## 17.2 Regels

- gebruik standaard NLDS componenten
- geen custom component zonder motivatie
- gedrag uit dit document is leidend

---

# 18. React Component Architectuur

## 18.1 Hoofdstructuur

```plaintext
<App>
  <Sidebar />
  <MainLayout>
    <Header />
    <WorkflowBar />
    <ContextPanel />
    <ViewContainer />
    <ActionPanel />
  </MainLayout>
</App>
```

## 18.2 Taak (Dossier)

```plaintext
<TaskPage>
  <TaskHeader />
  <WorkflowBar />
  <ContextSummary />
  <TaskView />
  <ActionPanel />
</TaskPage>
```

## 18.3 Kandidaten view

```plaintext
<CandidateTable>
  <Table />
  <Filters />
  <BulkActions />
</CandidateTable>
```

## 18.4 Regels

- componenten zijn modulair
- state centraal beheerd
- UI reflecteert backend status

---

# 19. Implementatie en overdracht

Dit document is leidend voor:

- UX ontwerp
- frontend implementatie
- componentstructuur
- AI UI generatie

Afwijkingen alleen met expliciete motivatie.