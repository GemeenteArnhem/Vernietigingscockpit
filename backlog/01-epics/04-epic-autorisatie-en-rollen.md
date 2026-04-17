# EPIC Autorisatie en rollen

## Doel
Deze epic richt zich op het borgen van juiste autorisaties en rollen binnen de Vernietigingscockpit, zodat alleen bevoegde gebruikers handelingen kunnen uitvoeren die passen bij hun verantwoordelijkheid.

Het doel is te voorkomen dat vernietiging of besluitvorming onbevoegd plaatsvindt, en om verantwoordelijkheid altijd expliciet te kunnen herleiden.

## Context
Vernietiging van informatie is een risicovolle handeling met juridische en bestuurlijke gevolgen. Daarom mogen niet alle gebruikers dezelfde rechten hebben.

De Vernietigingscockpit moet aansluiten op bestaande autorisatiestructuren en rollen binnen gemeenten, en deze consistent toepassen in alle processtappen.

## Scope
Deze epic omvat

- Rollen en verantwoordelijkheden binnen de Vernietigingscockpit
- Koppeling met externe identity en access management oplossingen
- Autorisatie op functies en acties, niet alleen op data
- Scheiding tussen beoordelen, accorderen en uitvoeren
- Vastlegging van wie welke actie heeft uitgevoerd

Autorisatie is van toepassing op zowel gebruikersinterfaces als API-acties.

## Buiten scope
De volgende onderwerpen vallen buiten deze epic

- Inrichting van IAM systemen zelf
- Beheer van gebruikersaccounts in bronsystemen
- Organisatorisch mandaat en werkafspraken buiten de applicatie
- Autorisatiebeheer in legacy systemen

Deze onderwerpen worden als randvoorwaardelijk beschouwd.

## Rollen
Binnen deze epic worden in ieder geval de volgende rollen onderscheiden

- Informatiebeheerder of recordmanager
- Proceseigenaar
- Gemeentelijk archivaris
- Technisch beheerder
- Auditor of toezichthouder

Niet iedere rol heeft toegang tot alle functionaliteit.

## Relatie met design sprints
Deze epic is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Ontwerpkeuzes rondom accordering en verantwoordelijkheid
- Architecturale keuzes over IAM integratie

Rollen en autorisaties moeten aansluiten op de UX en niet andersom.

## Belangrijkste functionaliteiten
Binnen deze epic worden onder andere de volgende capabilities gerealiseerd

- Rolgebaseerde toegang tot functionaliteit
- Afdwingen van volgorde in accorderingsstappen