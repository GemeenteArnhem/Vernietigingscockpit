# STORY Wijzigen van vernietiging naar blijvend bewaren

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_002.

## User story
Als informatiebeheerder  
wil ik de vernietigingstermijn van informatieobjecten kunnen wijzigen naar blijvend bewaren  
zodat informatie die blijvende waarde heeft niet per ongeluk wordt vernietigd.

## Toelichting
In sommige gevallen blijkt informatie niet tijdelijk, maar blijvend van waarde te zijn, bijvoorbeeld door historische, juridische of maatschappelijke betekenis, of door aanwijzing als hotspot.

In deze situaties moet vernietiging definitief worden uitgesloten en moet het informatieobject worden aangemerkt als blijvend te bewaren.

Deze wijziging is fundamenteel en vraagt daarom om een expliciete handeling met motivatie.

## Functionele scope
Deze user story omvat

- Het wijzigen van een vernietigingsnominatie naar blijvend bewaren
- Verplicht vastleggen van een motivatie voor deze wijziging
- Zichtbaar maken van de wijziging in overzichten en vernietigingslijsten
- Structureel uitsluiten van het object van alle toekomstige vernietiging
- Vastleggen van wie en wanneer de wijziging is doorgevoerd

De wijziging heeft permanent effect, tenzij later expliciet herzien.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Het opstellen of wijzigen van selectielijsten
- Organisatorische besluitvorming over bewaarbeleid
- Bulkconversies van bewaartermijnen
- Automatische detectie van hotspot-informatie

Deze onderwerpen worden elders of organisatorisch behandeld.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Een bevoegde rol vernietiging kan wijzigen naar blijvend bewaren
- Een motivatie verplicht wordt vastgelegd
- Het object niet meer verschijnt in vernietigingslijsten
- De wijziging zichtbaar en herleidbaar is
- De wijziging niet ongemerkt kan plaatsvinden

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over uitzonderingen en blijvende bewaring
- EPIC Afwijkingen bewaartermijnen
- EPIC Vernietigingsproces end to end

UX-ontwerp bepaalt hoe blijvend bewaren wordt ingesteld en gecommuniceerd.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor vastleggen van blijvend bewaren
- Validatie dat blijvend bewaarde objecten nooit voor vernietiging worden geselecteerd
- Frontend task voor instellen en tonen van deze status
- Logging en audit van de aangebrachte wijziging