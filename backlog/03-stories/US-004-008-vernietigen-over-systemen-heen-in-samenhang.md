# STORY Vernietigen over systemen heen in samenhang

## Oorsprong
Deze user story is gebaseerd op twee verwante user stories uit het overzicht van functionele eisen, oorspronkelijk opgenomen als US_004 en US_008.

## User story
Als informatiebeheerder  
wil ik over meerdere systemen heen in samenhang kunnen vernietigen  
zodat ik zeker weet dat alle onderdelen van een dossier of zaak volledig worden vernietigd en ik dit niet per systeem afzonderlijk hoef te doen.

## Toelichting
Informatie die logisch bij elkaar hoort, zoals een dossier of zaak, bevindt zich in de praktijk vaak verspreid over meerdere applicaties en databronnen.

Wanneer vernietiging per systeem afzonderlijk moet worden uitgevoerd, ontstaat het risico op onvolledige vernietiging, fouten of forse administratieve lasten. De Vernietigingscockpit moet daarom fungeren als centrale regievoorziening die samenhang bewaakt en vernietiging gecoördineerd uitvoert.

Deze user story benadrukt de noodzaak van één centraal aangestuurde vernietigingsactie over meerdere bronnen.

## Functionele scope
Deze user story omvat

- Centrale aansturing van vernietiging over meerdere bronsystemen
- Bewaken van samenhang tussen informatieobjecten over systemen heen
- Initiëren van vernietiging via één gebruikershandeling
- Inzicht in voortgang en resultaat per bronsysteem
- Vastleggen van een integraal vernietigingsresultaat

De gebruiker hoeft vernietiging niet afzonderlijk per systeem te starten.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Handmatig vernietigen in individuele applicaties
- Technische details van koppelingen per leverancier
- Migratie of consolidatie van informatie voorafgaand aan vernietiging
- Functioneel beheer van bronsystemen

Deze aspecten worden als randvoorwaardelijk beschouwd.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Vernietiging centraal kan worden gestart voor meerdere systemen
- Alle relevante systemen deelnemen aan dezelfde vernietigingstaak
- De samenhang tussen objecten behouden blijft
- Het resultaat per systeem zichtbaar en herleidbaar is
- De informatiebeheerder één integraal vernietigingsresultaat ontvangt

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN API Standaard Vernietiging
- DESIGN Technische architectuur Vernietigingscockpit
- EPIC Integratie en API
- EPIC Vernietigingsproces end to end
- FEATURE Uitvoeren vernietiging

Besluiten over regie en samenhang zijn hierin leidend.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor coördinatie van vernietiging over systemen
- Integratietasks per aangesloten bron
- Frontend task voor inzicht in multi-systeem voortgang
- Logging en audit van vernietiging over systemen heen