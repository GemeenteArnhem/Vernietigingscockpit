# STORY Notificatie na uitgevoerde vernietiging

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_038.

## User story
Als informatiebeheerder  
wil ik dat na het uitvoeren van vernietiging een notificatie wordt gestuurd naar ingestelde betrokkenen  
zodat de vernietigingsprocedure zorgvuldig en aantoonbaar kan worden afgerond.

## Toelichting
Na afronding van vernietiging is het belangrijk dat betrokken rollen weten dat de vernietiging daadwerkelijk heeft plaatsgevonden en is afgesloten.

Deze notificatie ondersteunt de formele afronding van het proces en voorkomt onzekerheid over de status van de vernietigingstaak. Notificaties zijn informerend en hebben geen beslissende functie.

## Functionele scope
Deze user story omvat

- Verzenden van notificaties na succesvolle afronding van vernietiging
- Configuratie van ontvangers per vernietigingstaak of rol
- Verzenden van notificaties op taakniveau, niet per individueel object
- Vastleggen dat een notificatie is verstuurd

Notificaties hebben uitsluitend betrekking op afgeronde taken.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Notificaties per afzonderlijk informatieobject
- Escalatie bij fouten of mislukte vernietiging
- Technische notificatiemechanismen zoals sms
- Vervanging van formele archiefverklaringen

Notificaties zijn aanvullend op formele vastlegging.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Na afronding van vernietiging automatisch een notificatie wordt verstuurd
- Ontvangers configureerbaar zijn
- De notificatie een duidelijke samenvatting bevat van de uitgevoerde taak
- De notificatie geen nieuwe acties afdwingt
- Vastligt dat en wanneer een notificatie is verstuurd

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over afronding en communicatie
- EPIC Overzicht rapportage en audittrail
- FEATURE Afronden en verklaring van vernietiging

UX-keuzes bepalen wanneer en aan wie notificaties zichtbaar zijn.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor genereren en versturen van notificaties
- Configuratietask voor ontvangers
- Frontend task voor inzicht in verzonden notificaties
- Logging van notificatieverzending