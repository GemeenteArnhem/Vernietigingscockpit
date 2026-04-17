# STORY Exporteren vernietigingslijsten naar meerdere formaten

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_025.

## User story
Als informatiebeheerder  
wil ik vernietigingslijsten naar verschillende bestandsformaten kunnen exporteren  
zodat ik de informatie voor verschillende doeleinden, zoals archivering, controle of openbaarmaking, kan gebruiken.

## Toelichting
Verschillende belanghebbenden hebben verschillende eisen aan de vorm waarin vernietigingsinformatie wordt aangeleverd.  
Waar de archivaris vaak behoefte heeft aan een Archiefwaardige vastlegging, kan voor openbaarmaking of interne controle een ander formaat nodig zijn.

Deze user story breidt de exportfunctionaliteit uit met meerdere doelgerichte formaten, zonder dat de inhoud van de lijst verandert.

## Functionele scope
Deze user story omvat

- Ondersteuning van meerdere exportformaten
- Consistente inhoud over alle formaten heen
- Uitsluiting van niet-toegestane of privacygevoelige gegevens per formaat indien nodig
- Gebruik van exports voor verschillende vervolgstappen

De selectie van vernietigingsobjecten zelf wordt niet beïnvloed.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Vormgeving of opmaak buiten standaard layouts
- Dynamisch samenstellen van exports door eindgebruikers
- Externe rapportagetooling
- Automatische publicatie van exports

Deze aspecten worden als aanvullende of organisatorische wensen beschouwd.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Vernietigingslijsten in ten minste meerdere gangbare formaten kunnen worden geëxporteerd
- De inhoud van de export overeenkomt met de geaccordeerde vernietigingslijst
- Elk formaat geschikt is voor zijn beoogde doel
- Export geen invloed heeft op de status van de vernietigingstaak
- Export reproduceerbaar is bij gelijke invoer

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over verantwoording en transparantie
- EPIC Overzicht rapportage en audittrail
- FEATURE Afronden en verklaring van vernietiging

UX-keuzes bepalen hoe en voor wie exportopties zichtbaar zijn.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor genereren van verschillende exportformaten
- Vaststellen van inhoud per formaat
- Frontend task voor kiezen en starten van export
- Validatie van consistentie en volledigheid per formaat