# STORY Eindgoedkeuring door proceseigenaar na gemandateerde beoordeling

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_034.

## User story
Als proceseigenaar  
wil ik de oordelen en opmerkingen van gemandateerde collega’s kunnen bekijken en op basis daarvan een eindbesluit nemen  
zodat de verantwoordelijkheid voor goedkeuring expliciet bij mijn rol blijft liggen.

## Toelichting
Hoewel inhoudelijke beoordeling kan worden gedelegeerd, blijft de proceseigenaar eindverantwoordelijk voor het akkoord op vernietiging.

Deze user story borgt dat de proceseigenaar alle relevante input kan betrekken bij het besluit, zonder dat gemandateerden zelfstandig kunnen accorderen.

De vastlegging van dit eindbesluit is cruciaal voor verantwoording en audit.

## Functionele scope
Deze user story omvat

- Inzage in oordelen en reacties van gemandateerde collega’s
- Overzicht van wie input heeft geleverd
- Mogelijkheid voor de proceseigenaar om akkoord te geven of af te wijzen
- Vastlegging van het eindbesluit inclusief context

Het eindbesluit vindt plaats op lijstniveau.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Delegatie van eindverantwoordelijkheid
- Wijzigen van de vernietigingslijst tijdens accordering
- Technische inrichting van mandaatstructuren
- Escalatie buiten de cockpit

Deze aspecten worden organisatorisch of elders geregeld.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- De proceseigenaar alle beoordelingen kan inzien
- Het duidelijk is welke input van welke collega afkomstig is
- De proceseigenaar expliciet akkoord kan geven of afwijzen
- Het eindbesluit en de motivatie worden vastgelegd
- Het akkoord kan worden gebruikt als formele stap richting volgende accorderingsfase

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over rolverdeling en verantwoordelijkheid
- EPIC Vernietigingsproces end to end
- FEATURE Accorderingsflow vernietigingslijst

UX-keuzes bepalen hoe input en eindbesluit worden gepresenteerd.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor ophalen en koppelen van beoordelingen
- Frontend task voor overzicht en besluitvorming
- Autorisatietask voor eindbesluit proceseigenaar
- Logging en audit van het eindbesluit