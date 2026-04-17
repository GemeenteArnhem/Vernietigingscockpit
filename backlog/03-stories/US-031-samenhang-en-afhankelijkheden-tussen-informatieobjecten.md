# STORY Vastleggen van samenhang en afhankelijkheden tussen informatieobjecten

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_031.

## User story
Als informatiebeheerder  
wil ik in de bron kunnen vastleggen welke processen of systemen gebruik maken van een informatieobject en welke relaties er zijn met andere informatieobjecten  
zodat ik geen informatie vernietig die elders nog nodig is, maar wel de juiste koppelingen kan verwijderen.

## Toelichting
Informatieobjecten staan zelden op zichzelf. Ze worden gebruikt in processen, gekoppeld aan andere objecten of gedeeld tussen systemen.

Bij vernietiging is het essentieel om te weten of een object nog functioneel wordt gebruikt. In sommige gevallen mag het object zelf worden vernietigd, maar moet een verwijzing of relatie behouden blijven, of juist andersom.

Deze user story ondersteunt het zorgvuldig omgaan met samenhang, zodat vernietiging niet leidt tot verstoring van lopende processen of informatieverlies elders.

## Functionele scope
Deze user story omvat

- Vastleggen van relaties tussen informatieobjecten
- Vastleggen van gebruik van objecten door processen of systemen
- Inzicht in afhankelijkheden bij vernietiging
- Ondersteunen van het verwijderen van relaties zonder het object zelf te vernietigen
- Transparantie over waarom vernietiging wordt geblokkeerd of beperkt

De cockpit gebruikt deze informatie voor besluitvorming, niet voor procesuitvoering.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Automatische detectie van afhankelijkheden
- Technische implementatie van relationele data in bronsystemen
- Procesmodellering of workflowbeheer
- Herstructurering van processen

Deze aspecten zijn verantwoordelijkheid van de bron of organisatie.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Afhankelijkheden tussen informatieobjecten inzichtelijk zijn
- Het duidelijk is of een object nog functioneel gebruikt wordt
- Vernietiging wordt geblokkeerd of aangepast als afhankelijkheden bestaan
- Het mogelijk is om alleen relaties te verwijderen waar passend
- Besluiten over samenhang herleidbaar zijn

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN Technische architectuur Vernietigingscockpit
- DESIGN API Standaard Vernietiging
- EPIC Integratie en API
- EPIC Vernietigingsproces end to end

Besluiten over samenhang en verantwoordelijkheid zijn hierin bepalend.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Definitie van relaties en afhankelijkheden
- Integratietask voor ontsluiten van relatie-informatie
- Backend task voor verwerken van afhankelijkheden bij vernietiging
- Frontend task voor inzicht in samenhang
- Logging en audit van besluiten rond samenhang