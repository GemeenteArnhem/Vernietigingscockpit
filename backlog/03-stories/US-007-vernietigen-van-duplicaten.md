# STORY Vernietigen van duplicaten

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_007.

## User story
Als informatiebeheerder  
wil ik niet alleen broninformatie, maar ook duplicaten van informatieobjecten kunnen vernietigen  
zodat vernietigde informatie niet elders blijft bestaan en er geen schijnvernietiging optreedt.

## Toelichting
In een gemeentelijk informatielandschap kunnen informatieobjecten op meerdere plekken voorkomen, bijvoorbeeld door indexen, kopieën of afgeleide datasets.

Wanneer alleen de primaire bron wordt vernietigd, maar duplicaten blijven bestaan, ontstaat het risico dat informatie feitelijk nog beschikbaar is, ondanks formele vernietiging.

Deze user story richt zich op het functioneel borgen van volledige vernietiging, zonder dat andere dossiers of processen onbedoeld worden aangetast.

## Functionele scope
Deze user story omvat

- Meenemen van functionele duplicaten bij vernietiging
- Onderscheid tussen  
  - duplicaten zonder zelfstandige context  
  - informatieobjecten die deel uitmaken van andere dossiers
- Borging dat vernietiging van duplicaten geen andere dossiers incompleet maakt
- Transparantie over welke duplicaten zijn vernietigd

De cockpit stuurt vernietiging aan, bronnen bepalen hoe duplicaten technisch zijn vormgegeven.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Vernietigen van informatie die in andere dossiers functioneel nodig is
- Opschonen van back-ups of technische indexen buiten afspraken
- Detectie-algoritmen voor inhoudelijke overlap
- Organisatorische afspraken met leveranciers over opslagarchitectuur

Deze aspecten worden gezien als randvoorwaardelijk of leverancier specifiek.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Vernietigde informatie niet functioneel beschikbaar blijft via duplicaten
- Duplicaten zonder zelfstandige context worden meegenomen in vernietiging
- Informatie die nodig is voor andere dossiers intact blijft
- Het duidelijk is welke duplicaten zijn vernietigd
- Vernietiging volledig en aantoonbaar is uitgevoerd

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN API Standaard Vernietiging
- DESIGN Technische architectuur Vernietigingscockpit
- EPIC Vernietigingsproces end to end
- EPIC Integratie en API
- FEATURE Uitvoeren vernietiging

Besluiten over wat als duplicaat wordt beschouwd zijn hierin leidend.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Definitie van wat functioneel geldt als duplicaat
- Integratietask voor meenemen van duplicaten bij vernietigingsopdracht
- Validatie dat andere dossiers niet worden aangetast
- Logging en audit van vernietiging van duplicaten