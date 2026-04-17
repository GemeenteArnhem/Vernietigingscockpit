# STORY Dubbele bevestiging bij vernietigingsactie

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_044.

## User story
Als informatiebeheerder  
wil ik dat de applicatie vraagt om een dubbele bevestiging voordat een vernietigingsactie daadwerkelijk wordt uitgevoerd  
zodat er niets per ongeluk of onbedoeld wordt vernietigd.

## Toelichting
Vernietiging is een onomkeerbare en risicovolle handeling. Ondanks zorgvuldige accordering kan een verkeerde klik of misinterpretatie leiden tot ongewenste vernietiging.

Een expliciete dubbele bevestiging vormt een laatste controlemechanisme en dwingt de gebruiker bewust stil te staan bij de consequenties van de actie.

Deze bevestiging is geen extra accordering, maar een veiligheidsstap op uitvoeringsniveau.

## Functionele scope
Deze user story omvat

- Een eerste expliciete actie om vernietiging te starten
- Een tweede, afzonderlijke bevestiging voordat de vernietiging daadwerkelijk wordt uitgevoerd
- Duidelijke uitleg van de consequenties bij de bevestiging
- Technisch blokkeren van vernietiging zonder dubbele bevestiging
- Vastleggen dat de dubbele bevestiging is gegeven

De dubbele bevestiging geldt alleen bij daadwerkelijke vernietiging, niet bij voorbereidende stappen.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Extra accorderingslagen
- Organisatorische vier-ogen-principes
- Juridische toetsing buiten bestaande afspraken
- Herstelmogelijkheden na definitieve vernietiging

Deze onderwerpen worden elders behandeld.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Vernietiging niet kan starten zonder twee expliciete bevestigingen
- De gebruiker duidelijke informatie krijgt over de actie en gevolgen
- Bevestigingen niet automatisch of impliciet kunnen plaatsvinden
- De dubbele bevestiging traceerbaar wordt vastgelegd
- Omzeilen van deze stap technisch onmogelijk is

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over zorgvuldigheid en risicobeheersing
- EPIC Vernietigingsproces end to end
- FEATURE Uitvoeren vernietiging

UX-keuzes bepalen hoe bevestigingen worden vormgegeven en ervaren.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Frontend task voor bevestigingsdialogen
- Backend task voor afdwingen van dubbele bevestiging
- Validatie dat vernietiging pas start na bevestiging
- Logging en audit van bevestigingsmomenten