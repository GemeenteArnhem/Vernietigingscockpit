# STORY Specifieke RM-rollen voor risicovolle informatiebeheeractiviteiten

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_040.

## User story
Als informatiebeheerder  
wil ik dat er specifieke rollen beschikbaar zijn voor risicovolle informatiebeheeractiviteiten zoals verwijderen, vernietigen en overschrijven  
zodat niet alle gebruikers met algemene beheerrechten deze handelingen kunnen uitvoeren.

## Toelichting
Niet iedere gebruiker met beheerrechten mag automatisch alle risicovolle handelingen uitvoeren. Vanuit informatiebeveiliging en governance is het gebruikelijk om voor dit type acties aparte rollen of accounts te hanteren.

Deze user story ondersteunt een fijnmazige rollenstructuur waarin risicovolle acties expliciet zijn afgeschermd en traceerbaar.

Het doel is het verkleinen van risico’s op misbruik, fouten of ongewenste escalatie van bevoegdheden.

## Functionele scope
Deze user story omvat

- Beschikbaar maken van specifieke rollen voor RM-activiteiten
- Afzonderen van risicovolle acties zoals vernietigen en overschrijven
- Afdwingen dat alleen gebruikers met expliciete bevoegdheid deze acties kunnen uitvoeren
- Vastleggen van rol en identiteit bij iedere risicovolle handeling
- Ondersteuning van scheiding tussen dagelijks beheer en uitzonderlijke acties

De cockpit gebruikt deze rollen uitsluitend voor autorisatie, niet voor personeelsbeheer.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Organisatorische toewijzing van rollen
- Beheer van accounts of personeelsgegevens
- Opleiding of instructie van gebruikers
- Controle op werkprocedures buiten de applicatie

Deze aspecten vallen onder verantwoordelijkheden van de organisatie.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Risicovolle acties alleen uitvoerbaar zijn met specifieke RM-rollen
- Algemene beheerrollen deze acties niet kunnen uitvoeren
- Rollen consistent worden toegepast in UI en API
- Elke risicovolle actie herleidbaar is tot gebruiker en rol
- Pogingen tot ongeautoriseerde uitvoering worden geblokkeerd en gelogd

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN Technische architectuur Vernietigingscockpit
- Besluiten over rolverdeling en informatiebeveiliging
- EPIC Autorisatie en rollen
- EPIC Vernietigingsproces end to end

Architectuurkeuzes rondom IAM en roltoepassing zijn hierin bepalend.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Definitie van RM-specifieke rollen
- Backend task voor afdwingen van rolgebaseerde autorisatie
- Frontend task voor tonen of verbergen van risicovolle acties
- Logging en audit van rolgebruik bij risicohandelingen