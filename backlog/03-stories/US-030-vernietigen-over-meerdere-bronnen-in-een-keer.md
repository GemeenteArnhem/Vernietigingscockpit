# STORY Vernietigen van informatieobjecten over meerdere bronnen in één keer

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_030.

## User story
Als informatiebeheerder  
wil ik informatieobjecten in één keer kunnen vernietigen in alle aangesloten bronsystemen  
zodat ik zeker weet dat alle samenhangende informatie van een dossier of zaak volledig is vernietigd.

## Toelichting
Informatie die logisch bij elkaar hoort, zoals een dossier of zaak, kan technisch verspreid zijn over meerdere bronsystemen.

Als vernietiging per systeem afzonderlijk moet plaatsvinden, ontstaat het risico dat onderdelen worden vergeten of dat de samenhang verloren gaat. Deze user story ondersteunt centrale regie op vernietiging, waarbij de Vernietigingscockpit zorgt voor volledige en consistente uitvoering over alle betrokken bronnen.

De gebruiker initieert vernietiging één keer, de cockpit zorgt voor coördinatie.

## Functionele scope
Deze user story omvat

- Initiëren van vernietiging over meerdere gekoppelde bronnen binnen één vernietigingstaak
- Coördineren van vernietigingsopdrachten per bron
- Bewaken van samenhang tussen objecten over bronnen heen
- Inzicht in voortgang en resultaat per bron
- Vastleggen van een integraal resultaat van de vernietigingsactie

De vernietiging blijft logisch één actie, ook al vindt uitvoering technisch per bron plaats.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Handmatige vernietiging per afzonderlijk bronsysteem
- Technische implementatiedetails binnen de bron
- Migratie van informatie tussen systemen
- Herstructureren van dossiers of zaken voorafgaand aan vernietiging

Deze aspecten worden als technisch of organisatorisch beschouwd.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- De gebruiker één vernietigingsactie kan starten voor meerdere bronnen
- Alle gekoppelde bronnen worden aangeroepen conform afspraken
- De voortgang per bron inzichtelijk is
- Het duidelijk is of vernietiging volledig of gedeeltelijk is uitgevoerd
- Het eindresultaat integraal kan worden verantwoord

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN API Standaard Vernietiging
- DESIGN Technische architectuur Vernietigingscockpit
- EPIC Vernietigingsproces end to end
- EPIC Integratie en API
- FEATURE Uitvoeren vernietiging

Besluiten over regie en samenhang zijn hierin leidend.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor coördinatie van vernietigingsopdrachten per bron
- Aggregatie van resultaten en foutafhandeling
- Frontend task voor inzicht in multi-bron uitvoering
- Logging en audit van de vernietigingsactie over bronnen heen