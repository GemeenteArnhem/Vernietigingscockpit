# Begrippenlijst – Vernietigingscockpit ecosysteem

Deze glossary definieert kernbegrippen die gebruikt worden in de architectuurdocumentatie.
De definities zijn normerend bedoeld, om een eenduidig begrip te waarborgen binnen ontwerp, ontwikkeling en gebruik.

De begrippen zijn alfabetisch geordend.

---

## Accordering
Het expliciet goedkeuren van een vernietigingsactie door een bevoegde rol.
Accordering vindt plaats als onderdeel van de workflow, en is een normatieve daad.
Accordering wordt vastgelegd en maakt deel uit van het vernietigingsdossier.

---

## Logging
Technische registratie van systeemgebeurtenissen ten behoeve van monitoring, foutanalyse en beheer.
Logging is niet normatief, kan tijdelijk zijn en maakt geen onderdeel uit van het vernietigingsdossier.

---

## Auditlog
Auditlog is de onveranderbare en juridisch relevante vastlegging van gebeurtenissen, besluiten en acties binnen het vernietigingsproces.
De auditlog maakt onderdeel uit van het vernietigingsdossier en is leidend voor verantwoording.

- audit log is altijd gekoppeld aan een taak
- er is geen globale audit log in de UI
- audit is zichtbaar binnen taak-detail

---

## Besluitvorming
Het nemen van normatieve besluiten over selectie en vernietiging.
Besluitvorming vindt plaats in de Vernietigingscockpit, door mensen, ondersteund door het systeem.
Besluitvorming is te onderscheiden van technische uitvoering.

---

## Bronsysteem
Een applicatie of systeem waarin informatieobjecten daadwerkelijk zijn opgeslagen.
Het bronsysteem is systeem van record.
Fysieke vernietiging vindt plaats in het bronsysteem, aangestuurd via een stekker.

---

## Cockpit
Zie Vernietigingscockpit.

---

## Dossier
Het samenhangende geheel van informatie dat een vernietigingsproces beschrijft.
Het dossier bevat onder andere:
- vernietigingslijsten
- uitsluitingen en toelichtingen
- accorderingen
- uitvoeringsresultaten
- verklaring van vernietiging

Het dossier vormt het juridische en organisatorische bewijs.

---

## Executor
Het onderdeel van een stekker dat de daadwerkelijke technische vernietiging uitvoert.
De executor werkt idempotent en rapporteert per object een resultaat terug.

---

## Functiescheiding
Het principe dat verschillende stappen in het proces door verschillende rollen worden uitgevoerd.
Functiescheiding voorkomt belangenverstrengeling en is een essentieel compliance principe.

---

## Idempotentie
De eigenschap dat een actie meerdere keren kan worden uitgevoerd zonder extra effect op de gegevens.
Herhaalde aanroepen kunnen wel afzonderlijk worden vastgelegd in logging en audit.
In de context van vernietiging betekent dit dat dubbele aanroepen niet leiden tot dubbele vernietiging.

---

## Vernietigingslijst
De centrale lijst van informatieobjecten die binnen een taak beoordeeld en vernietigd worden.

De vernietigingslijst:
- ontstaat uit een selectie via een stekker
- wordt als snapshot vastgelegd binnen een taak
- krijgt een normatieve en juridische betekenis in de cockpit
- doorloopt de workflow van beoordeling tot uitvoering

---

## Vernietigingskandidaat
Een individueel informatieobject binnen een vernietigingslijst.

---

## Selectie
Het technische resultaat van een stekker-call (bijv. /selecties/latest).
Een selectie heeft geen normatieve betekenis totdat deze wordt vastgelegd in een vernietigingslijst.

---

## Landelijke Selectielijst (LSL)
De normatieve set van bewaartermijnen en selectiecriteria.
LSL-regels zijn abstract en normatief.
De operationele interpretatie van de LSL vindt plaats binnen de stekker.

---

## Normatief
Alles wat betrekking heeft op regels, kaders en besluiten.
Normatief betreft de vraag wat mag en moet.
Normatieve handelingen worden door mensen uitgevoerd en vastgelegd.

---

## Operationeel
Alles wat betrekking heeft op technische uitvoering.
Operationeel betreft de vraag hoe iets concreet wordt uitgevoerd.
Operationele logica bevindt zich in stekkers en ondersteunende componenten.

---

## Proceseigenaar
Een rol die verantwoordelijk is voor het proces waarin de informatie is ontstaan.
De proceseigenaar levert een inhoudelijke controle en accordering als onderdeel van de workflow.

---

## Recordmanager
De primaire gebruiker van de Vernietigingscockpit.
De recordmanager beheert taken, beoordeelt vernietigingslijsten en bewaakt het proces.

---

## Scheduler
Een mechanisme dat periodieke processen start.
Bijvoorbeeld het automatisch uitvoeren van een selectie op vaste momenten.

---

## Stekker
Een generiek, herbruikbaar component dat fungeert als schakel tussen cockpit en bron.
De stekker:
- bepaalt vernietigingskandidaten (via selectie)
- voert vernietiging technisch uit
- bevat bron- en domeinspecifieke logica
- exposeert een uniform contract

---

## Taak
Een gedefinieerde vernietigingscyclus binnen de cockpit.
Een taak beschrijft scope, stekkers en planning en bevat een vernietigingslijst.
- vertegenwoordigt een domein of context (bijv. Zorgdomein)
- kan meerdere stekkers (bronnen) bevatten
- bevat één vernietigingslijst per cyclus

Taken doorlopen de workflow:
- beoordeling
- accordering
- uitvoering
- resultaat
- archief

---

## Sjabloon
Een herbruikbare definitie voor taken.
Sjablonen bevatten instellingen zoals bronnen, frequentie en workflow.
Ze zorgen voor standaardisatie en herhaalbaarheid.

---

## Vernietiging
Het onomkeerbaar verwijderen van informatieobjecten.
Vernietiging is fysiek en onreconstrueerbaar.
Vernietiging vindt plaats in het bronsysteem.

---

## Vernietigingscockpit
De centrale applicatie voor regie, besluitvorming en verantwoording van vernietiging.

De cockpit:
- ondersteunt workflows en accordering
- beheert vernietigingslijsten en dossiers
- communiceert uitsluitend met stekkers
- voert zelf geen technische vernietiging uit

---

## Vernietigingsverklaring
Een formeel document dat verklaart welke informatie is vernietigd.
De verklaring bevat context, accorderingen en uitvoeringsresultaten.
De verklaring wordt gearchiveerd als juridisch bewijs.

---

## Workflow
De vastgelegde volgorde van stappen in een vernietigingsproces.
De workflow borgt functiescheiding en correcte besluitvorming.
Workflows zijn configureerbaar en herhaalbaar.

---

## Afwijking tussen selectie en uitvoering
Situatie waarin een object uit de vernietigingslijst niet (meer) vernietigbaar is op het moment van uitvoering, bijvoorbeeld door wijziging of verwijdering in het bronsysteem.