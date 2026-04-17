# STORY Metadata-randvoorwaarden voor samenhang en vernietiging

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_013.

## User story
Als informatiebeheerder  
wil ik dat bronsystemen beschikken over voldoende metadata om de onderlinge samenhang tussen informatieobjecten te borgen  
zodat vernietiging gecontroleerd en in samenhang kan plaatsvinden.

## Toelichting
Voor het correct en compleet vernietigen van informatie is het essentieel dat bronsystemen metadata vastleggen die relaties tussen informatieobjecten inzichtelijk maken.

Zonder deze metadata is het niet mogelijk om samenhang te bepalen, waardoor het risico ontstaat op onvolledige vernietiging of het ten onrechte vernietigen van objecten die nog functioneel worden gebruikt.

Deze user story beschrijft de randvoorwaarden die nodig zijn om vernietiging verantwoord te kunnen uitvoeren.

## Functionele scope
Deze user story omvat

- Vaststellen van minimale metadata-eisen voor bronnen
- Borging dat samenhang tussen informatieobjecten kan worden herleid
- Validatie of een bron voldoet aan de minimale metadata-randvoorwaarden
- Blokkeren of beperken van vernietiging als onvoldoende metadata beschikbaar is
- Transparantie over ontbrekende of onvoldoende metadata

De Vernietigingscockpit voert geen metadatering uit, maar toetst randvoorwaarden.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Technische implementatie van metadata-opslag in bronsystemen
- Migratie of opschoning van bestaande metadata
- Aanpassen van bedrijfsprocessen in de organisatie
- Automatische verrijking of correctie van metadata

Deze onderwerpen liggen bij de leverancier of organisatie van de bron.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Duidelijk is welke metadata minimaal vereist is voor vernietiging
- De cockpit kan vaststellen of een bron hieraan voldoet
- Vernietiging wordt geblokkeerd of gemarkeerd als randvoorwaarden ontbreken
- De gebruiker inzicht heeft in ontbrekende metadata
- Besluiten hierover herleidbaar zijn vastgelegd

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN Technische architectuur Vernietigingscockpit
- DESIGN API Standaard Vernietiging
- EPIC Integratie en API
- EPIC Vernietigingsproces end to end

Besluiten over randvoorwaarden en verantwoordelijkheid zijn hierin leidend.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Definitie van minimale metadata-eisen
- Validatietask voor toetsen van bronmetadata
- Backend task voor blokkering of signalering bij ontbrekende metadata
- Frontend task voor inzicht in randvoorwaardelijke problemen
- Logging en audit van besluiten rondom metadata