# STORY Exporteren vernietigingslijst

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_015.

## User story
Als archivaris  
wil ik een vernietigingslijst kunnen exporteren  
zodat ik deze kan opnemen in het archief als onderdeel van de formele verantwoording.

## Toelichting
De vernietigingslijst vormt een essentieel document binnen de archiefverantwoording. Naast inzicht in de cockpit is het noodzakelijk dat deze lijst kan worden vastgelegd en geraadpleegd buiten de applicatie.

De export ondersteunt zowel interne archivering als externe controle of inspectie.

## Functionele scope
Deze user story omvat

- Exporteren van de vernietigingslijst
- Ondersteuning van gangbare exportformaten
- Behoud van relevante metadata en context
- Gebruik van de lijst voor archivering en toezicht

De export is een representatie van de lijst en bevat geen bewerkingsfunctionaliteit.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Bewerken van geëxporteerde lijsten binnen de cockpit
- Externe archivering of opslag
- Juridische ondertekening van documenten

Deze aspecten worden als organisatorisch beschouwd.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- De vernietigingslijst geëxporteerd kan worden
- De export minimaal de relevante identificerende informatie bevat
- De inhoud overeenkomt met de geaccordeerde lijst
- De export geschikt is voor archivering
- De export reproduceerbaar is bijzelfde input

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over verantwoording en transparantie
- EPIC Overzicht rapportage en audittrail
- FEATURE Afronden en verklaring van vernietiging

UX-keuzes bepalen wanneer en door wie export mogelijk is.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor genereren van exportbestanden
- Vaststellen van exportformaten en inhoud
- Frontend task voor initiëren en downloaden van export
- Validatie van volledigheid en consistentie