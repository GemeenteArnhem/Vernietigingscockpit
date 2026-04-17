# STORY Autorisatie op basis van extern Identity en Access Management

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_016.

## User story
Als informatiebeheerder  
wil ik dat vernietigingshandelingen plaatsvinden op basis van een extern aangewezen Identity en Access Management oplossing  
zodat alleen geautoriseerde gebruikers daadwerkelijk vernietiging kunnen uitvoeren.

## Toelichting
Vernietiging van informatie is een kritieke handeling die alleen door bevoegde rollen mag worden uitgevoerd.

Gemeenten maken doorgaans gebruik van centrale IAM-oplossingen, zoals Active Directory of vergelijkbare voorzieningen. De Vernietigingscockpit moet hierop aansluiten en geen eigen, losstaand autorisatiemodel introduceren.

Deze user story borgt dat autorisaties herleidbaar, controleerbaar en consistent zijn met de bestaande organisatie-inrichting.

## Functionele scope
Deze user story omvat

- Koppeling met een extern IAM-systeem
- Gebruiken van bestaande rollen en autorisatiestructuren
- Afdwingen dat vernietiging alleen door geautoriseerde rollen kan plaatsvinden
- Ondersteunen van rolgebaseerde toegang tot functionaliteit
- Geen mogelijkheid tot lokale omzeiling van autorisatie

De cockpit valideert autorisaties, maar beheert deze niet zelf.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Beheer of inrichting van IAM-systemen
- Aanmaken of wijzigen van gebruikersaccounts
- Organisatorische mandaatafspraken
- Migratie van bestaande autorisatiestructuren

Deze aspecten liggen bij de organisatie en haar IAM-beheer.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- De cockpit werkt met een extern IAM-systeem
- Alleen gebruikers met de juiste rol vernietigingshandelingen kunnen uitvoeren
- Autorisaties consistent worden toegepast in UI en API
- Pogingen tot ongeautoriseerde acties worden geblokkeerd
- Autorisatiebesluiten herleidbaar zijn voor auditdoeleinden

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN Technische architectuur Vernietigingscockpit
- Besluiten over rolverdeling en verantwoordelijkheid
- EPIC Autorisatie en rollen
- FEATURE Accorderingsflow vernietigingslijst
- FEATURE Uitvoeren vernietiging

Architectuurkeuzes bepalen hoe IAM-koppeling wordt gerealiseerd.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Integratietask met extern IAM-systeem
- Backend task voor autorisatievalidatie
- Frontend task voor rolgebaseerde toegang
- Testtask voor positieve en negatieve autorisatiescenario’s