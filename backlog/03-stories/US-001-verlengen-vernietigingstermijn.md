# STORY Verlengen van de vernietigingstermijn

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_001.

## User story
Als informatiebeheerder  
wil ik de vernietigingstermijn van informatieobjecten kunnen verlengen  
zodat ik voorkom dat informatie wordt vernietigd terwijl het proces nog loopt of andere belangen spelen.

## Toelichting
In de praktijk zijn er situaties waarin de standaard vernietigingstermijn niet passend is, bijvoorbeeld door lopende procedures, bezwaar- of beroepszaken, of bestuurlijke afwegingen.

Deze user story maakt het mogelijk om vernietiging tijdelijk uit te stellen, zonder de onderliggende archiefnominatie te wijzigen.

De verlenging is altijd een expliciete handeling en vereist motivatie.

## Functionele scope
Deze user story omvat

- Het instellen van een verlenging op een bestaande vernietigingstermijn
- Vastleggen van de duur of einddatum van de verlenging
- Verplicht vastleggen van een toelichting of motivatie
- Zichtbaar maken van de verlenging in overzichten en lijsten
- Automatisch uitsluiten van verlengde objecten uit vernietiging

De verlenging geldt tot een expliciet vastgestelde einddatum.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Wijzigen van archiefnominatie of selectielijst
- Structurele aanpassing van bewaartermijnen in de bron
- Organisatorische goedkeuringen buiten de cockpit
- Automatische verlengingen zonder expliciet besluit

Deze onderwerpen worden elders behandeld.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Een vernietigingstermijn door een bevoegde rol kan worden verlengd
- Een toelichting verplicht is bij het instellen van de verlenging
- Verlengde objecten niet op vernietigingslijsten verschijnen
- De verlenging zichtbaar en herleidbaar is
- De verlenging geen stilzwijgend permanent effect heeft

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over uitzonderingen en blokkades
- EPIC Afwijkingen bewaartermijnen
- EPIC Vernietigingsproces end to end

UX-ontwerp bepaalt hoe verlengingen worden ingesteld en getoond.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor registreren van verlenging
- Validatie dat verlengingen vernietiging blokkeren
- Frontend task voor invoer en weergave van verlenging
- Logging en audit van ingestelde verlengingen