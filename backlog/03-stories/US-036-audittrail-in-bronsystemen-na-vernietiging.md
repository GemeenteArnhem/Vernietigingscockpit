# STORY Vastleggen vernietiging in audittrail van bronsystemen

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_036.

## User story
Als informatiebeheerder  
wil ik dat na het uitvoeren van vernietiging in de bronsystemen vastligt dat deze vernietiging heeft plaatsgevonden in de audittrail  
zodat verantwoording en controle over de uitvoering geborgd zijn.

## Toelichting
Naast logging binnen de Vernietigingscockpit is het noodzakelijk dat bronsystemen zelf vastleggen dat vernietiging daadwerkelijk is uitgevoerd.

Deze vastlegging ondersteunt technische, juridische en auditdoeleinden en maakt het mogelijk om vernietiging end to end te verantwoorden, ook buiten de cockpit om.

De cockpit blijft regie voeren, maar de bron is verantwoordelijk voor bevestiging van uitvoering.

## Functionele scope
Deze user story omvat

- Terugmelding vanuit bronsystemen over uitgevoerde vernietiging
- Vastlegging van vernietiging in de audittrail van het bronsysteem
- Koppeling tussen cockpitactie en bronregistratie
- Herleidbaarheid van vernietiging tot moment en uitvoerende context
- Inzicht dat vernietiging is uitgevoerd door of namens de cockpit

De cockpit leest en verwerkt deze terugmelding, maar schrijft geen logs in de bron.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Interne logstructuur van bronsystemen
- Technische implementatie van auditlogging in de bron
- Aanpassen of standaardiseren van bestaande bronlogs
- Audits of controles buiten het proces om

Deze aspecten zijn leverancier- of systeemspecifiek.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Bronsystemen aantonen dat vernietiging is uitgevoerd
- Er een expliciete terugmelding beschikbaar is voor de cockpit
- Auditinformatie herleidbaar is tot een vernietigingstaak
- Onduidelijkheid over uitvoerder of moment wordt voorkomen
- Vernietiging in de bron niet onzichtbaar of impliciet blijft

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN API Standaard Vernietiging
- DESIGN Technische architectuur Vernietigingscockpit
- EPIC Integratie en API
- EPIC Overzicht rapportage en audittrail
- FEATURE Uitvoeren vernietiging

Afspraken over regie en verantwoordelijkheid zijn hierin leidend.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Definitie van terugmeldingen vanuit bronsystemen
- Integratietask voor ontvangen en verwerken van auditbevestiging
- Mapping tussen cockpitactie en bronregistratie
- Validatie en logging van ontvangen auditinformatie