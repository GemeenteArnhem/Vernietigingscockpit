# STORY Vernietigen op basis van ordeningsmechanismen

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_006.

## User story
Als informatiebeheerder  
wil ik op basis van een gekozen ordeningsmechanisme de samenhang tussen informatieobjecten kunnen borgen  
zodat ik vernietiging kan uitvoeren op basis van een selectielijst en zeker weet dat samenhang behouden blijft.

## Toelichting
Informatieobjecten zijn in gemeentelijke omgevingen geordend volgens verschillende mechanismen, zoals zaak, proces, persoon, object, tijd of combinatie daarvan.

Bij vernietiging is het essentieel dat deze ordening en samenhang wordt gerespecteerd, zodat vernietiging logisch en volledig plaatsvindt en er geen losse of incomplete resten achterblijven.

Deze user story maakt het mogelijk om vernietiging te baseren op een gekozen ordeningsprincipe, zonder handmatig samenhang te hoeven reconstrueren.

## Functionele scope
Deze user story omvat

- Ondersteuning van verschillende ordeningsmechanismen
- Vernietigen van samenhangende informatieobjecten als geheel
- Borging dat objecten die tot dezelfde ordening behoren gezamenlijk worden beoordeeld
- Aansluiting op selectielijsten en archiefclassificaties
- Transparantie over welk ordeningsmechanisme is toegepast

De cockpit gebruikt ordeningsinformatie, maar beheert deze niet inhoudelijk.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Automatische herordening van informatie
- Wijzigen van ordeningsstructuren in bronsystemen
- Definiëren van selectielijsten zelf
- Oplossen van ontbrekende of foutieve ordening in de bron

Deze aspecten zijn randvoorwaardelijk of organisatorisch.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- De gebruiker een ordeningsmechanisme kan kiezen
- Vernietiging plaatsvindt op basis van deze ordening
- Samenhang binnen de gekozen ordening behouden blijft
- De toegepaste ordening inzichtelijk en herleidbaar is
- Vernietiging aansluit op geldende selectielijsten

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN API Standaard Vernietiging
- DESIGN Technische architectuur Vernietigingscockpit
- EPIC Integratie en API
- EPIC Vernietigingsproces end to end

Besluiten over ordening en samenhang zijn hierin bepalend.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Definitie van ondersteunde ordeningsmechanismen
- Integratietask voor ophalen van ordeningsinformatie
- Backend task voor toepassen van ordening bij selectie en vernietiging
- Frontend task voor inzicht in gehanteerde ordening
- Logging en audit van het toegepaste mechanisme