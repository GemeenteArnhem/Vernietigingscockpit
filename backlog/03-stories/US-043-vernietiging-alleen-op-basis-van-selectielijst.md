# STORY Vernietiging alleen op basis van selectielijst

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_043.

## User story
Als informatiebeheerder  
wil ik dat vernietigen alleen mogelijk is wanneer dit expliciet is gebaseerd op een selectielijst  
zodat altijd aantoonbaar is op basis van welke selectieregel informatie is vernietigd.

## Toelichting
Vernietiging van informatie mag nooit ad hoc of los van vastgestelde archiefregels plaatsvinden.

De selectielijst vormt de juridische en inhoudelijke grondslag voor vernietiging. Zonder expliciete koppeling aan een selectieregel kan vernietiging niet verantwoord worden richting toezicht, audit of samenleving.

Deze user story borgt dat elke vernietigingsactie aantoonbaar herleidbaar is tot een selectielijstitem.

## Functionele scope
Deze user story omvat

- Verplicht koppelen van vernietiging aan een selectielijstitem
- Vastleggen van het gebruikte selectielijstitem bij vernietiging
- Blokkeren van vernietiging zonder selectielijstkoppeling
- Zichtbaar maken van de selectieregel in overzichten en audittrail
- Herleidbaarheid van vernietiging tot selectielijst en bewaartermijn

De cockpit valideert de koppeling, maar beheert de selectielijst niet inhoudelijk.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Beheer of wijziging van selectielijsten
- Interpretatie van selectielijstregels
- Opleiding of instructie over selectielijsten
- Organisatorische besluitvorming over uitzonderingen

Deze aspecten worden elders of organisatorisch behandeld.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Vernietiging niet mogelijk is zonder selectielijstkoppeling
- Het gebruikte selectielijstitem expliciet wordt vastgelegd
- De selectieregel zichtbaar is voor inzage en audit
- Vernietiging herleidbaar is tot wettelijke grondslag
- Omzeilen van de selectielijst technisch onmogelijk is

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- DESIGN API Standaard Vernietiging
- EPIC Vernietigingsproces end to end
- EPIC Overzicht rapportage en audittrail
- FEATURE Uitvoeren vernietiging

Besluiten over juridische grondslag en compliance zijn hierin leidend.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor afdwingen van selectielijstkoppeling
- Validatietask voor vernietigingsacties zonder selectieregel
- Frontend task voor tonen van selectielijstinformatie
- Logging en audit van gebruikte selectieregels