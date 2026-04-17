# STORY Overzicht te vernietigen zaken per datum

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_010.

## User story
Als informatiebeheerder  
wil ik een overzicht kunnen opstellen van te vernietigen zaken op een vernietigingsdatum naar keuze  
zodat ik een lijst ter goedkeuring kan aanbieden aan betrokkenen.

## Toelichting
De informatiebeheerder moet op basis van een opgegeven vernietigingsdatum een overzicht kunnen genereren van zaken en dossiers die in aanmerking komen voor vernietiging.

Dit overzicht vormt de basis voor beoordeling, accordering en verdere stappen in het vernietigingsproces.

De lijst moet voldoende informatie bevatten om inhoudelijk te kunnen beoordelen of vernietiging is toegestaan.

## Functionele scope
Deze user story omvat

- Selecteren van zaken op basis van vernietigingsdatum
- Tonen van een overzichtslijst
- Mogelijkheid om de lijst te gebruiken als input voor accordering
- Geen uitvoering van vernietiging

Deze story beperkt zich tot het samenstellen en tonen van het overzicht.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- De gebruiker een vernietigingsdatum kan kiezen
- Zaken met een bijbehorende vernietigingsdatum worden getoond
- Het overzicht minimaal de volgende informatie bevat  
  - identificatie van de zaak  
  - zaak of procescontext  
  - startdatum en einddatum  
  - geldende selectielijst of bewaartermijn  
- De lijst doorgegeven kan worden aan de accorderingsflow

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- EPIC Vernietigingsproces end to end
- FEATURE Selecteren en opstellen vernietigingslijst

Ontwerpkeuzes uit de UX design sprint zijn leidend voor presentatie en interactie.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor selectie op vernietigingsdatum
- Frontend task voor weergave van overzicht
- Validatie of alleen relevante zaken worden getoond