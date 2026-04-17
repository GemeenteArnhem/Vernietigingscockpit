# STORY Toegang proceseigenaar tot overzicht en doorklikken

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_014.

## User story
Als proceseigenaar  
wil ik toegang hebben tot (delen van) de vernietigingslijst en via links kunnen doorklikken naar onderliggende informatie  
zodat ik kan beoordelen of vernietiging binnen mijn verantwoordelijkheid is toegestaan.

## Toelichting
De proceseigenaar is verantwoordelijk voor de inhoudelijke beoordeling van vernietiging binnen zijn of haar domein.

Daarvoor is het noodzakelijk dat de proceseigenaar inzicht heeft in de voorgestelde vernietiging, zonder toegang te krijgen tot beheermogelijkheden die niet bij de rol passen.

De Vernietigingscockpit faciliteert dit door een specifiek overzicht aan te bieden, afgestemd op de rol van proceseigenaar.

## Functionele scope
Deze user story omvat

- Toegang tot een geaggregeerd overzicht van de vernietigingslijst
- Inzien van relevante metadata per zaak of dossier
- Doorklikken naar onderliggende informatieobjecten in bronsystemen
- Inzage zonder wijzigingsrechten

De proceseigenaar kan geen selectie aanpassen of uitzonderingen toevoegen.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Wijzigen of uitsluiten van objecten
- Technische autorisatie in bronsystemen
- Beheren van vernietigingstermijnen

Deze handelingen blijven voorbehouden aan de informatiebeheerder.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- De proceseigenaar toegang heeft tot een overzicht passend bij zijn rol
- Het overzicht voldoende context bevat voor beoordeling
- Doorklikken naar onderliggende objecten mogelijk is
- De proceseigenaar geen mutatierechten heeft
- Inzage traceerbaar is voor auditdoeleinden

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over rolverdeling en autorisatie
- EPIC Vernietigingsproces end to end
- FEATURE Accorderingsflow vernietigingslijst

UX-keuzes bepalen welke informatie zichtbaar is voor de proceseigenaar.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Autorisatietask voor proceseigenaarrol
- Backend task voor gefilterde gegevenslevering
- Frontend task voor overzicht en navigatie
- Logging van inzage door proceseigenaar