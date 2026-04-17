# STORY Aanpassen bewaartermijnen op basis van input van de proceseigenaar

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_039.

## User story
Als informatiebeheerder  
wil ik op basis van de input van de proceseigenaar bewaartermijnen kunnen aanpassen  
zodat zaken die niet vernietigd mogen worden niet onterecht op de uiteindelijke vernietigingslijst terechtkomen.

## Toelichting
Tijdens het accorderingsproces kan de proceseigenaar constateren dat een zaak of dossier niet vernietigd mag worden, ondanks dat deze op basis van standaard criteria wel voor vernietiging is geselecteerd.

De informatiebeheerder moet deze input kunnen verwerken door de bewaartermijn of vernietigingsstatus aan te passen, zodat het object structureel wordt uitgesloten van vernietiging.

Deze aanpassing is expliciet, gemotiveerd en herleidbaar.

## Functionele scope
Deze user story omvat

- Ontvangen van inhoudelijke input van de proceseigenaar
- Aanpassen van bewaartermijn of vernietigingsstatus op basis van deze input
- Vastleggen van de reden en herkomst van de aanpassing
- Automatisch verwijderen van het object uit de actieve vernietigingslijst
- Zichtbaarheid van de aanpassing in overzichten en audittrail

De aanpassing wordt uitgevoerd door de informatiebeheerder.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Rechtstreekse wijziging van bewaartermijnen door proceseigenaren
- Structurele wijziging van selectielijsten
- Organisatorische besluitvorming over bewaarbeleid
- Bulkmatige aanpassingen zonder individuele beoordeling

Deze aspecten worden elders of organisatorisch geregeld.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Input van de proceseigenaar kan worden vastgelegd
- De informatiebeheerder een bewaartermijnaanpassing kan doorvoeren
- De aanpassing automatisch effect heeft op de vernietigingslijst
- De reden en herkomst van de aanpassing herleidbaar zijn
- De aanpassing zichtbaar is voor audit en verantwoording

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over rolverdeling en verantwoordelijkheid
- EPIC Afwijkingen bewaartermijnen
- EPIC Vernietigingsproces end to end

UX-ontwerp bepaalt hoe feedback en verwerking inzichtelijk zijn.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor verwerken van proceseigenaar-input
- Backend task voor aanpassen bewaartermijnen of status
- Frontend task voor tonen van feedback en verwerking
- Logging en audit van de aangebrachte aanpassing