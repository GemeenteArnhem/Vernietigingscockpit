# STORY Logging van gebruikershandelingen en audittrail

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_018.

## User story
Als informatiebeheerder  
wil ik dat alle relevante gebruikershandelingen in het vernietigingsproces worden gelogd  
zodat ik verantwoording kan afleggen over het correct en zorgvuldig uitvoeren van de procedure.

## Toelichting
Vernietiging van informatie vereist een hoge mate van transparantie en controleerbaarheid. Daarom moeten alle kritieke handelingen binnen de Vernietigingscockpit worden vastgelegd in een audittrail.

De audittrail dient zowel intern verantwoording af te ondersteunen als extern toezicht mogelijk te maken.

Logging is geen bijvangst, maar een essentieel onderdeel van het proces.

## Functionele scope
Deze user story omvat

- Vastleggen van gebruikershandelingen met betrekking tot  
  - selectie  
  - uitsluiten en motiveren  
  - accordering  
  - uitvoeren van vernietiging  
  - afronden van taken
- Vastleggen van datum en tijd van handelingen
- Vastleggen van uitvoerende gebruiker en rol
- Vastleggen van context van de handeling

Logging vindt plaats binnen de cockpit en is onafhankelijk van bronsystemen.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Technische logging voor debugging of performance
- Logs binnen bronsystemen
- Centrale logging infrastructuur buiten de applicatie
- Analyse of rapportage op logdata

Deze story richt zich uitsluitend op functionele audittrail.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Alle relevante gebruikershandelingen worden gelogd
- Logs herleidbaar zijn tot gebruiker en rol
- Datum, tijd en type handeling worden vastgelegd
- Logs niet handmatig kunnen worden aangepast of verwijderd
- Auditinformatie beschikbaar is voor inzage door bevoegde rollen

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN Technische architectuur Vernietigingscockpit
- DESIGN UX Vernietigingscockpit kernflow
- EPIC Overzicht rapportage en audittrail
- FEATURE Afronden en verklaring van vernietiging

Architectuurkeuzes bepalen waar en hoe logging plaatsvindt.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor vastleggen van audit events
- Structureren van auditlog records
- Frontend task voor inzage in auditinformatie
- Beveiliging tegen manipulatie of verlies van logs