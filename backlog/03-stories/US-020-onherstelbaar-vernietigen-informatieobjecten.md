# STORY Onherstelbaar vernietigen van informatieobjecten

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_020.

## User story
Als informatiebeheerder  
wil ik informatieobjecten onherstelbaar kunnen vernietigen  
zodat ik zeker weet dat ik voldoe aan de wettelijke vernietigingsplicht en dat informatie niet opnieuw beschikbaar kan worden.

## Toelichting
Na accordering en uitvoering mag vernietigde informatie niet meer toegankelijk of reconstrueerbaar zijn voor gebruikers, toepassingen of wettelijke verzoeken.

Onherstelbaar vernietigen wordt hierbij functioneel benaderd als het definitief onttrekken van informatie aan gebruik, inzage en verwerking, overeenkomstig de geldende wet- en regelgeving.

De vernietigingshandeling moet aantoonbaar en verifieerbaar zijn.

## Functionele scope
Deze user story omvat

- Initiëren van een vernietigingsactie op geaccordeerde objecten
- Functionele onbeschikbaarheid van vernietigde informatie
- Vastleggen dat vernietiging is uitgevoerd
- Uitsluiting van vernietigde objecten bij toekomstige verzoeken, zoals Woo of inzage
- Borging dat vernietigde objecten niet opnieuw worden aangeboden via de cockpit

De cockpit stuurt vernietiging aan, maar voert geen data-operaties uit in bronsystemen.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Technische implementatie van dataverwijdering binnen bronsystemen
- Beheer of opschoning van back-ups
- Cryptografische vernietigingstechnieken
- Beleid rondom datarecovery na incidenten

Deze aspecten worden beschouwd als randvoorwaardelijk of leverancier specifiek.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Vernietigde informatie niet meer toegankelijk is voor gebruikers
- Vernietigde informatie niet meer wordt getoond in overzichten of selecties
- Vernietiging wordt vastgelegd als definitief uitgevoerd
- Het aantoonbaar is dat de wettelijke vernietigingsplicht is nageleefd
- Vernietigde informatie niet kan worden hersteld via de cockpit

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN API Standaard Vernietiging
- DESIGN Technische architectuur Vernietigingscockpit
- EPIC Vernietigingsproces end to end
- FEATURE Uitvoeren vernietiging

Besluiten over wat functioneel geldt als onherstelbaar zijn hierin leidend.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor markeren van objecten als vernietigd
- Integratietask voor bevestiging vanuit bronsystemen
- Validatie dat vernietigde objecten niet opnieuw verschijnen
- Logging en audit van de vernietigingsactie