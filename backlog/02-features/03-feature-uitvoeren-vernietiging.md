# FEATURE Uitvoeren vernietiging

## Doel
Deze feature beschrijft het gecontroleerd en aantoonbaar uitvoeren van vernietiging van informatieobjecten in bronsystemen, nadat de vernietigingslijst volledig is geaccordeerd.

Het doel is om vernietiging technisch uit te voeren op een manier die onherstelbaar is, maar tegelijk transparant, controleerbaar en herleidbaar blijft.

## Context
Vernietiging is een onomkeerbare handeling met juridische en maatschappelijke impact. Daarom mag deze stap alleen plaatsvinden na volledige accordering en moet de uitvoering strikt worden geregisseerd door de Vernietigingscockpit.

Deze feature vertaalt accordering naar feitelijke uitvoering, zonder dat inhoudelijke beslissingen opnieuw worden genomen.

## Scope
Deze feature omvat

- Initiëren van vernietigingsopdrachten naar bronsystemen
- Uitvoeren van vernietiging per bron conform API-afspraken
- Verwerken van succesvolle en foutieve terugmeldingen
- Vastleggen van uitvoeringsresultaten
- Signaleren van incomplete of deels mislukte vernietiging
- Blokkeren van heruitvoering zonder expliciet besluit

Vernietiging vindt plaats op basis van geaccordeerde lijsten.

## Buiten scope
De volgende onderwerpen vallen buiten deze feature

- Technische details van vernietiging binnen de bron
- Herstel of rollback buiten vastgestelde quarantaineafspraken
- Fysieke vernietiging van dragers
- Opschoning van back-ups

Deze onderwerpen worden gezien als randvoorwaardelijk of organisatorisch.

## Gebruikers en rollen
Binnen deze feature zijn primair betrokken

- Informatiebeheerder of recordmanager

Secundair betrokken

- Technisch beheerder (monitoring en ondersteuning)
- Archivaris (toezicht achteraf)

## Functionele beschrijving
Na volledige accordering kan de informatiebeheerder de vernietiging initiëren.

De Vernietigingscockpit stuurt per gekoppelde bron een vernietigingsopdracht op basis van de vastgestelde API-standaard. De cockpit blijft verantwoordelijk voor regie en vastlegging, niet voor de feitelijke data-operatie.

Tijdens uitvoering wordt per bron inzichtelijk gemaakt

- Of vernietiging is gestart
- Of vernietiging succesvol is afgerond
- Of fouten zijn opgetreden

Bij fouten wordt vernietiging stilgezet en volgt expliciete opvolging.

## Relatie met design sprints
Deze feature is gebaseerd op

- DESIGN API Standaard Vernietiging
- DESIGN Technische architectuur Vernietigingscockpit
- Besluiten over onherstelbaarheid en foutafhandeling

Zonder expliciete besluiten uit deze design sprints kan uitvoering niet plaatsvinden.

## Acceptatiecriteria op feature-niveau
Deze feature kan als afgerond worden beschouwd wanneer

- Vernietiging alleen mogelijk is na volledige accordering
- Vernietigingsopdrachten aantoonbaar worden uitgevoerd
- Resultaten per bron zichtbaar en herleidbaar zijn
- Fouten expliciet worden vastgelegd en gesignaleerd
- Vernietiging niet onbedoeld opnieuw kan worden uitgevoerd

## Relatie met vervolgwerk
Deze feature wordt verder uitgewerkt in user stories zoals

- Initiëren vernietiging per taak
- Verwerken van terugmeldingen per bron
- Blokkeren bij fouten
- Vastleggen uitvoeringsresultaat