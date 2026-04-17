# STORY Niet-geanonimiseerde versie van het vernietigingsoverzicht

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_023.

## User story
Als informatiebeheerder  
wil ik een niet-geanonimiseerde versie van het overzicht van te vernietigen en vernietigde informatie kunnen gebruiken  
zodat ik op basis van volledige informatie inhoudelijk correcte selectiebeslissingen kan nemen.

## Toelichting
Tijdens het uitvoeren en beoordelen van het vernietigingsproces is volledige informatie noodzakelijk. De informatiebeheerder moet inzicht hebben in alle relevante metadata, inclusief mogelijk privacygevoelige gegevens, om een zorgvuldige en juiste beoordeling te kunnen doen.

De niet-geanonimiseerde versie is uitsluitend bedoeld voor intern gebruik door bevoegde rollen en vormt de primaire werklijst binnen de Vernietigingscockpit.

## Functionele scope
Deze user story omvat

- Tonen en gebruiken van een volledig, niet-geanonimiseerd overzicht
- Inzicht in alle relevante metadata zoals namen, identifiers en context
- Gebruik van het overzicht voor selectie, beoordeling en accordering
- Duidelijke scheiding tussen interne en externe weergaven
- Borging dat deze versie alleen beschikbaar is voor bevoegde rollen

De inhoud van dit overzicht vormt de basis voor alle verdere stappen in het proces.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Openbaarmaking of externe verstrekking van deze versie
- Automatische anonimisering of pseudonimisering
- Juridische toetsing van inzagerechten
- Gebruik door niet-bevoegde rollen of systemen

Deze aspecten worden afgedwongen via autorisatie en beleid.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- De informatiebeheerder toegang heeft tot een volledig overzicht
- Alle relevante metadata zichtbaar en correct is
- De niet-geanonimiseerde versie niet toegankelijk is voor onbevoegde rollen
- Er geen verwarring kan ontstaan tussen geanonimiseerde en volledige weergaven
- Het overzicht effectief gebruikt kan worden voor selectiebeslissingen

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over rolgebaseerde toegang en privacy
- EPIC Overzicht rapportage en audittrail
- FEATURE Selecteren en opstellen vernietigingslijst

UX-ontwerp bepaalt hoe duidelijk onderscheid wordt gemaakt tussen varianten.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Autorisatietask voor toegang tot volledige overzichten
- Backend task voor leveren van volledige datasets
- Frontend task voor duidelijke labeling van niet-geanonimiseerde weergave
- Logging van inzage in privacygevoelige informatie