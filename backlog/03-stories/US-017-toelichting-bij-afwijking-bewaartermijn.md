# STORY Toelichting vastleggen bij afwijking op bewaartermijn

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_017.

## User story
Als informatiebeheerder  
wil ik bij een afwijking op de bewaartermijn een toelichting kunnen vastleggen  
zodat ik achteraf kan verantwoorden waarom informatie niet is vernietigd.

## Toelichting
Elke afwijking op een vastgestelde bewaartermijn vormt een expliciete beslissing die juridisch en organisatorisch verantwoord moet kunnen worden.

Zonder vastgelegde toelichting ontstaat onduidelijkheid bij audits, toezicht of overdracht van werkzaamheden.

Deze user story borgt dat afwijkingen nooit stilzwijgend plaatsvinden, maar altijd worden voorzien van context en motivatie.

## Functionele scope
Deze user story omvat

- Verplicht vastleggen van een toelichting bij afwijkingen
- Koppelen van de toelichting aan het specifieke object of dossier
- Inzichtelijk maken van toelichtingen in overzichten en audittrail
- Alleen beschikbaar maken van deze functionaliteit voor bevoegde rollen

De toelichting maakt onderdeel uit van de verantwoording.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Vrije annotaties zonder relatie tot bewaartermijn
- Organisatorische besluitvorming buiten de cockpit
- Wijzigen van wettelijke kaders of selectielijsten
- Automatische gegenereerde toelichtingen

Deze aspecten worden bestuurskundig of elders geregeld.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Een afwijking niet kan worden opgeslagen zonder toelichting
- De toelichting duidelijk wordt gekoppeld aan de afwijking
- De toelichting zichtbaar is voor inzage en audit
- Alleen bevoegde gebruikers toelichtingen kunnen vastleggen of wijzigen
- De toelichting niet stilzwijgend kan worden verwijderd

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over uitzonderingen en transparantie
- EPIC Afwijkingen bewaartermijnen
- EPIC Overzicht rapportage en audittrail

UX-ontwerp bepaalt hoe toelichtingen worden ingevoerd en getoond.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor opslag van toelichtingen
- Validatie dat toelichting verplicht is bij afwijkingen
- Frontend task voor invoer en weergave van toelichting
- Logging en audit van vastgelegde toelichtingen