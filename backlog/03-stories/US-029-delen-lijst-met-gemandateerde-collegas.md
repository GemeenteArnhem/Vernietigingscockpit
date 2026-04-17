# STORY Delen vernietigingslijst met gemandateerde collega’s

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_029.

## User story
Als proceseigenaar  
wil ik (delen van) de vernietigingslijst kunnen voorleggen aan één of meerdere gemandateerde collega’s  
zodat inhoudsdeskundigen een vakkundig oordeel kunnen geven voordat ik zelf akkoord geef.

## Toelichting
De proceseigenaar draagt eindverantwoordelijkheid voor inhoudelijke accordering, maar beschikt niet altijd over alle inhoudelijke kennis.

Daarom moet het mogelijk zijn om beoordelingsrechten te delegeren aan gemandateerde collega’s, zonder de eindverantwoordelijkheid over te dragen.

Deze user story ondersteunt inhoudelijke toetsing binnen het accorderingsproces.

## Functionele scope
Deze user story omvat

- Delen van de vernietigingslijst met geselecteerde collega’s
- Inzage in relevante delen van de lijst
- Vastleggen van het oordeel van gemandateerde collega’s
- Geen overdracht van accorderingsbevoegdheid

De eindbeslissing blijft altijd bij de proceseigenaar.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Organisatorische mandaatregelingen
- Beheer van gebruikersaccounts
- Wijzigen van de vernietigingslijst door gemandateerden
- Autonome accordering door gemandateerde collega’s

Dit betreft uitsluitend ondersteuning van de beoordeling.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- De proceseigenaar collega’s kan uitnodigen voor beoordeling
- Gemandateerde collega’s inzage krijgen in relevante informatie
- Oordelen of opmerkingen kunnen worden vastgelegd
- De proceseigenaar deze input kan raadplegen
- De eindverantwoordelijkheid technisch bij de proceseigenaar blijft

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over rolverdeling en verantwoordelijkheid
- EPIC Vernietigingsproces end to end
- FEATURE Accorderingsflow vernietigingslijst

UX-keuzes bepalen hoe delegatie en terugkoppeling zichtbaar zijn.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Autorisatietask voor gemandateerde inzage
- Backend task voor vastleggen van oordelen
- Frontend task voor delen en terugkoppeling
- Logging van betrokkenheid per gebruiker