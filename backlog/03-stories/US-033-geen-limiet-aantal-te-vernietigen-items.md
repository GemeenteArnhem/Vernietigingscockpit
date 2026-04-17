# STORY Geen limiet aan het aantal te vernietigen items

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_033.

## User story
Als informatiebeheerder  
wil ik dat er geen functionele limiet is aan het aantal items dat ik in één vernietigingstaak kan verwerken  
zodat er geen wachtrijen of opstoppingen ontstaan en de vernietiging continu kan doorlopen.

## Toelichting
In de praktijk kunnen vernietigingscycli grote aantallen informatieobjecten omvatten, soms tienduizenden per jaar of per domein.

De Vernietigingscockpit moet deze aantallen aankunnen zonder functionele blokkades, zoals harde maxima die het proces vertragen of onnodig complex maken.

Deze user story richt zich op functionele schaalbaarheid, niet op onbeperkte technische resources.

## Functionele scope
Deze user story omvat

- Ondersteuning van grote aantallen objecten binnen één vernietigingstaak
- Geen functioneel maximum op het aantal te vernietigen items
- Mogelijkheid tot gefaseerde of batchgewijze verwerking achter de schermen
- Signalen of waarschuwingen bij uitzonderlijk grote aantallen
- Behoud van overzicht en statusinformatie bij grote sets

De gebruiker hoeft geen technische kennis te hebben van batchverwerking.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Garanties over maximale prestaties of doorlooptijden
- Infrastructuurschaal of cloudconfiguraties
- Optimalisaties in bronsystemen zelf
- Kostenafwegingen tussen verschillende verwerkingsstrategieën

Deze aspecten worden technisch of organisatorisch bepaald.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Er geen functioneel maximum is op het aantal items per vernietigingstaak
- Grote aantallen niet leiden tot fouten of blokkades in de cockpit
- De gebruiker inzicht houdt in voortgang en status
- Het systeem verantwoord omgaat met grote datasets
- Eventuele batchverwerking transparant is voor de gebruiker

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN Technische architectuur Vernietigingscockpit
- Besluiten over schaalbaarheid en robuustheid
- EPIC Vernietigingsproces end to end
- EPIC Integratie en API
- FEATURE Uitvoeren vernietiging

Architectuurkeuzes bepalen hoe schaalbaarheid technisch wordt ondersteund.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor batchgewijze verwerking van vernietiging
- Monitoring en statusrapportage bij grote aantallen
- Frontend task voor voortgangsinzicht
- Testtask voor grote datasets en stressscenario’s