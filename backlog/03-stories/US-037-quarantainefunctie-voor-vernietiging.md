# STORY Quarantainefunctie voor te vernietigen informatieobjecten

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_037.

## User story
Als informatiebeheerder  
wil ik een quarantainefunctie hebben voor informatieobjecten die in aanmerking komen voor vernietiging  
zodat ik foutieve vernietigingen binnen een beperkte periode kan voorkomen of herstellen.

## Toelichting
Vernietiging is een onomkeerbare handeling, maar in de praktijk kan het voorkomen dat kort na accordering of uitvoering blijkt dat een object onterecht is meegenomen.

Een quarantainefunctie biedt een gecontroleerd tussenstation waarin vernietiging wel is voorbereid of logisch afgerond, maar nog niet definitief onherstelbaar is gemaakt.

Deze functionaliteit ondersteunt zorgvuldigheid en risicobeheersing, zonder het vernietigingsproces onnodig te vertragen.

## Functionele scope
Deze user story omvat

- Markeren van objecten als “in quarantaine” vóór definitieve vernietiging
- Tijdelijk blokkeren van onomkeerbare vernietiging
- Inzicht in quarantaine-items en resterende termijn
- Mogelijkheid voor bevoegde rollen om vernietiging binnen de quarantaineperiode tegen te houden
- Automatische overgang naar definitieve vernietiging na afloop van de quarantaineperiode

De quarantaineperiode is vast of configureerbaar volgens vastgestelde afspraken.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Volledige herstelmogelijkheden na definitieve vernietiging
- Technische rollback in bronsystemen buiten afgesproken kaders
- Juridische uitzonderingen op vernietigingsplicht
- Opschoning van back-ups

De quarantainefunctie is geen alternatief voor correcte accordering.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Informatieobjecten tijdelijk in quarantaine worden geplaatst vóór definitieve vernietiging
- De status “quarantaine” duidelijk zichtbaar is
- Alleen bevoegde rollen kunnen ingrijpen tijdens quarantaine
- Na afloop van de quarantaineperiode vernietiging automatisch definitief wordt
- Alle stappen herleidbaar zijn in audittrail en logging

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN Technische architectuur Vernietigingscockpit
- Besluiten over risicobeheersing en zorgvuldigheid
- EPIC Vernietigingsproces end to end
- EPIC Afwijkingen bewaartermijnen
- FEATURE Uitvoeren vernietiging

Architectuurkeuzes bepalen of quarantaine functioneel of technisch wordt vormgegeven.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor quarantaine-status en termijnbewaking
- Validatie dat definitieve vernietiging wordt uitgesteld
- Frontend task voor inzicht en beheer van quarantaine
- Logging en audit van quarantainehandelingen