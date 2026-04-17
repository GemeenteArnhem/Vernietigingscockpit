# STORY Geanonimiseerde versie van het vernietigingsoverzicht

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_022.

## User story
Als informatiebeheerder  
wil ik een geanonimiseerde versie van het overzicht van te vernietigen en vernietigde informatie kunnen maken  
zodat ik AVG‑proof openbaar kan verantwoorden wat is vernietigd.

## Toelichting
Voor transparantie, verantwoording en eventuele openbaarmaking is het noodzakelijk dat overzichten kunnen worden gedeeld zonder persoonsgegevens of andere privacygevoelige informatie.

De geanonimiseerde versie moet inhoudelijk gelijkwaardig zijn aan het volledige overzicht, maar zodanig aangepast dat deze veilig extern kan worden gedeeld.

Deze functionaliteit voorkomt dat ad‑hoc bewerkingen of handmatige anonimisering nodig zijn.

## Functionele scope
Deze user story omvat

- Genereren van een geanonimiseerde variant van vernietigingsoverzichten
- Uitsluiten of maskeren van persoonsgegevens en gevoelige metadata
- Waarborgen dat de structuur en aantallen behouden blijven
- Gebruik van de geanonimiseerde versie voor publicatie of verantwoording
- Duidelijke scheiding tussen geanonimiseerde en niet‑geanonimiseerde weergaven

De anonimisering vindt plaats op basis van vastgestelde regels.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Vrij configureerbare anonimisatieregels door eindgebruikers
- Juridische beoordeling van wat wel of niet openbaar mag
- Automatische publicatie
- Pseudonimisering met herleidbaarheid

Deze aspecten worden bestuurlijk of via beleid bepaald.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Een geanonimiseerde versie van het overzicht kan worden gegenereerd
- Persoonsgegevens en gevoelige informatie niet zichtbaar zijn
- De geanonimiseerde versie inhoudelijk aansluit op het volledige overzicht
- De versie geschikt is voor openbaarmaking of externe verantwoording
- Gebruikers niet per ongeluk de niet‑geanonimiseerde versie delen

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over transparantie en privacy
- EPIC Overzicht rapportage en audittrail
- FEATURE Afronden en verklaring van vernietiging

UX‑ontwerp bepaalt hoe gebruikers tussen varianten schakelen.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Definitie van anonimisatieregels
- Backend task voor genereren van geanonimiseerde datasets
- Frontend task voor kiezen en bekijken van de geanonimiseerde versie
- Validatie op AVG‑conformiteit