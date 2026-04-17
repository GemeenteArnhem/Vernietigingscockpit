# STORY Genereren en downloaden verklaring van vernietiging

## Oorsprong
Deze user story vloeit voort uit de wettelijke en archieftechnische verplichting om vernietiging van informatie formeel te kunnen verantwoorden.
De story is expliciet toegevoegd om te borgen dat afronding van een vernietigingstaak altijd resulteert in een officiële verklaring van vernietiging.

## User story
Als informatiebeheerder  
wil ik dat na afronding van een vernietigingstaak automatisch een verklaring van vernietiging wordt gegenereerd en kan worden gedownload  
zodat deze verklaring kan worden opgeslagen in het zaaksysteem als formeel verantwoordingsdocument.

## Toelichting
De verklaring van vernietiging is het formele bewijs dat vernietiging rechtmatig, zorgvuldig en conform geldende regelgeving is uitgevoerd.

Deze verklaring vormt een essentieel onderdeel van de archiefverantwoording en is vereist voor toezicht, audit en interne controle. Zonder verklaring is een vernietigingstaak niet inhoudelijk afgerond.

De verklaring moet volledig automatisch worden opgebouwd op basis van vastgelegde gegevens in de Vernietigingscockpit en mag geen handmatige nabewerking vereisen.

## Functionele scope
Deze user story omvat

- Automatisch genereren van een verklaring van vernietiging na succesvolle afronding van een vernietigingstaak
- Opnemen van alle relevante context in de verklaring, waaronder  
  - identificatie van de vernietigingstaak  
  - datum en tijd van vernietiging  
  - betrokken bronsystemen  
  - accorderingen door bevoegde rollen  
  - toegepaste selectielijst en bewaartermijnen  
  - samenvatting van vernietigde objecten  
- Vastleggen van de verklaring als zelfstandig document
- Beschikbaar stellen van de verklaring als downloadbaar bestand
- Geschiktheid van het bestand voor opslag in een zaaksysteem

De verklaring wordt gegenereerd door de cockpit en niet aangeleverd door gebruikers.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Vormgeving of huisstijl per gemeente
- Digitale of natte handtekeningen
- Meertalige verklaringen
- Juridische toetsing buiten vastgelegde kaders
- Automatische opslag in externe zaaksystemen

Deze aspecten kunnen in vervolgstappen of doorontwikkeling worden opgepakt.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Na afronding van een vernietigingstaak automatisch een verklaring wordt gegenereerd
- Afronden van een taak niet mogelijk is zonder verklaring
- De verklaring alle benodigde verantwoordingsinformatie bevat
- De verklaring kan worden gedownload als stabiel bestandsformaat, zoals PDF
- De verklaring geschikt is voor opname in een zaaksysteem
- Het duidelijk is bij welke vernietigingstaak de verklaring hoort
- De verklaring reproduceerbaar is bij dezelfde input

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over verantwoording en transparantie
- EPIC Overzicht rapportage en audittrail
- FEATURE Afronden en verklaring van vernietiging

Ontwerpkeuzes bepalen hoe en wanneer de verklaring zichtbaar en downloadbaar wordt.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor samenstellen van de verklaring op basis van vastgelegde gegevens
- Vaststellen van inhoud en structuur van de verklaring
- Backend task voor genereren van een PDF of vergelijkbaar document
- Frontend task voor downloaden van de verklaring
- Validatie dat afronding wordt geblokkeerd zonder verklaring
- Logging en audit van het genereren en downloaden van de verklaring