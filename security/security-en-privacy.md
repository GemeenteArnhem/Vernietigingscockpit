# Security en privacy – Vernietigingscockpit ecosysteem

## 1. Doel en scope

Dit document beschrijft de security en privacy kaders voor het Vernietigingscockpit ecosysteem.
Het document **is normerend bedoeld** en vormt een bindend kader voor ontwerp, implementatie en gebruik.

Het document beschrijft:
- informatiebeveiliging
- privacybescherming
- verantwoordelijkheden en borging
- relatie tot geldende normen en wetgeving

Dit document beschrijft **wat geborgd moet zijn**, niet **hoe** dit technisch wordt geïmplementeerd.
Implementaties **moeten** aantoonbaar aansluiten op dit kader.

## 2. Kernuitgangspunten

Security en privacy **zijn integraal onderdeel** van de architectuur.
Ze zijn geen optionele of aanvullende eisen.

De volgende uitgangspunten **zijn verplicht**:
- security by default
- privacy by design en by default
- functiescheiding is verplicht
- minimale bevoegdheden
- volledige traceerbaarheid
- transparantie richting toezicht

Deze uitgangspunten **gelden voor alle componenten** binnen het ecosysteem.

## 3. Normenkaders en wettelijke context

De security en privacy architectuur **moet** aansluiten bij relevante kaders en wetgeving.
De cockpit en stekkers **faciliteren aantoonbare naleving**, zonder verantwoordelijkheden over te nemen.

De borging is architecturaal en procesmatig.
De technische invulling blijft verantwoordelijkheid van implementaties.

## 4. Common Ground en NeRDS

### 4.1 Common Ground

De architectuur **moet** voldoen aan Common Ground uitgangspunten:
- losse koppeling
- duidelijke verantwoordelijkheden
- dataminimalisatie
- API first integratie

De cockpit:
- **mag geen** brondata bevatten
- **mag geen** systeem van records zijn
- **mag geen** technische uitvoering bevatten

Stekkers **vormen** de enige koppeling met bronnen.

### 4.2 NeRDS leidraad

De architectuur **moet** aansluiten bij de NeRDS leidraad.
Dit betekent:
- expliciete architectuurdocumentatie
- toetsbare kwaliteitseisen
- iteratieve doorontwikkeling
- herbruikbare componenten

Architectuur, governance en documentatie **zijn leidend**.

## 5. BIO

De Baseline Informatiebeveiliging Overheid **is van toepassing** op het ecosysteem.

De architectuur **moet** BIO‑compliance ondersteunen door:
- rolgebaseerde autorisatie
- verplichte functiescheiding
- logging en audittrail
- expliciete verantwoordelijkheden

De cockpit **faciliteert** BIO‑compliance.
Technische maatregelen **liggen bij implementaties**.

## 6. Cybersecuritywet en NIS2

De architectuur **moet** ondersteuning bieden voor naleving van:
- beschikbaarheid
- integriteit
- vertrouwelijkheid
- incidentafhandeling

De ketenverantwoordelijkheid:
- **moet** expliciet zijn
- **mag niet** impliciet of verborgen zijn

Incidenten **moeten** traceerbaar en herleidbaar zijn.

## 7. Privacy en AVG

### 7.1 Dataminimalisatie

De cockpit:
- **mag geen** inhoud van informatieobjecten verwerken
- **mag alleen** noodzakelijke metadata verwerken

Privacygevoelige data **blijft in de bron**.

### 7.2 Doelbinding

Persoonsgegevens **mogen alleen** worden verwerkt voor:
- selectie ter vernietiging
- beoordeling en accordering
- audit en verantwoording

Herbruik voor andere doelen **is niet toegestaan**.

### 7.3 Bewaartermijnen

- Dossiers **mogen niet** langer worden bewaard dan noodzakelijk
- Bewaartermijnen **moeten** expliciet zijn
- Dossiervernietiging **maakt onderdeel uit** van het ontwerp

## 8. Logging en audit

Alle normatieve handelingen:
- **moeten** worden gelogd
- **moeten** onveranderbaar zijn
- **moeten** herleidbaar zijn tot rol en identiteit

Auditlogs **vormen** een primair controlemiddel.

## 9. Verantwoordelijkheden

### 9.1 Organisatorisch

- Gebruikersorganisatie **is verwerkingsverantwoordelijke**
- Leveranciers **zijn verwerkers**
- Rolhouders **zijn verantwoordelijk voor hun besluiten**

Verantwoordelijkheden **mogen niet** impliciet verschuiven.

### 9.2 Technisch

- Cockpit **borgt procesmatige security**
- Stekkers **borgen bron specifieke maatregelen**
- Bronsystemen **blijven verantwoordelijk voor data**

## 10. Incidenten en fouten

- Incidenten **moeten** worden gelogd en onderzocht
- Fouten **mogen niet** leiden tot datalekken
- Retries **moeten** gecontroleerd plaatsvinden

Incidentafhandeling **maakt onderdeel uit** van governance.

## 11. Compliance en toezicht

Het ecosysteem **moet** aantoonbaarheid ondersteunen richting:
- AVG
- BIO
- Cybersecuritywet en NIS2
- Archiefwet

Documentatie, logs en dossiers **vormen samen het bewijs**.