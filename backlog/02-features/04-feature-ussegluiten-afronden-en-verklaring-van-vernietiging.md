# FEATURE Afronden en verklaring van vernietiging

## Doel
Deze feature beschrijft het afronden van een vernietigingstaak en het vastleggen van de formele verklaring van vernietiging, inclusief alle relevante context voor verantwoording en toezicht.

Het doel is dat na uitvoering van vernietiging een juridisch en organisatorisch bruikbaar bewijs ontstaat dat de vernietiging correct, volledig en rechtmatig is uitgevoerd.

## Context
Na vernietiging is het cruciaal dat gemeenten kunnen aantonen wat is vernietigd, wanneer, door wie en op basis van welke besluiten.

De verklaring van vernietiging vormt een essentieel onderdeel van de archiefverantwoording en moet reproduceerbaar en controleerbaar zijn, ook jaren later.

Deze feature sluit het primaire vernietigingsproces formeel af.

## Scope
Deze feature omvat

- Vastleggen van afgeronde vernietigingstaken
- Genereren van een verklaring van vernietiging
- Vastleggen van relevante metadata en besluiten
- Overzicht van succesvol en niet succesvol vernietigde objecten
- Exporteren of opslaan van verklaringen
- Markeren van taken als definitief afgerond

Na afronding is de taak niet meer wijzigbaar.

## Buiten scope
De volgende onderwerpen vallen buiten deze feature

- Langdurige archivering van verklaringen buiten de cockpit
- Externe documentmanagementsystemen
- Fysieke ondertekening of natte handtekeningen
- Juridische toetsing buiten vastgelegde criteria

Deze onderwerpen worden als organisatorisch of randvoorwaardelijk beschouwd.

## Gebruikers en rollen
Binnen deze feature zijn betrokken

- Informatiebeheerder of recordmanager
- Archivaris
- Auditor of toezichthouder (inzage)

De rol van de recordmanager is leidend bij afronding.

## Functionele beschrijving
Na succesvolle uitvoering van vernietiging ontvangt de informatiebeheerder een overzicht van de resultaten.

De Vernietigingscockpit stelt op basis van vastgelegde besluiten, accorderingen en uitvoeringsresultaten automatisch een verklaring van vernietiging samen.

Deze verklaring bevat onder andere

- Identificatie van de vernietigingstaak
- Datum en tijd van vernietiging
- Betrokken bronnen
- Rollen en accorderingen
- Eventuele uitzonderingen of afwijkingen

Na bevestiging wordt de taak als afgerond gemarkeerd.

## Relatie met design sprints
Deze feature is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over verantwoording en uitlegbaarheid
- Architectuurkeuzes rondom logging en audittrail

De vorm en inhoud van de verklaring zijn expliciet onderdeel van de UX-ontwerpkeuzes.

## Acceptatiecriteria op feature-niveau
Deze feature kan als afgerond worden beschouwd wanneer

- Vernietigingstaken definitief kunnen worden afgesloten
- Verklaringen automatisch en reproduceerbaar worden gegenereerd
- Alle relevante besluiten en handelingen zijn opgenomen
- Verklaringen geschikt zijn voor toezicht en auditing
- Taken na afronding niet meer wijzigbaar zijn

## Relatie met vervolgwerk
Deze feature wordt verder uitgewerkt in user stories zoals

- Overzicht afgeronde vernietigingstaken
- Genereren verklaring van vernietiging
- Exporteren of opslaan van verklaringen
- Inzage voor toezichthouders