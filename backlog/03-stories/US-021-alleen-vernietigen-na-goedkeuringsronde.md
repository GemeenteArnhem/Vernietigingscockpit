# STORY Alleen vernietigen na volledige goedkeuringsronde

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_021.

## User story
Als informatiebeheerder  
wil ik alleen zaken kunnen vernietigen die de volledige goedkeuringsronde hebben doorlopen  
zodat ik geen informatie vernietig waar nog geen expliciet akkoord voor is gegeven.

## Toelichting
Vernietiging mag alleen plaatsvinden nadat bevoegde rollen expliciet hebben ingestemd met de voorgestelde vernietigingslijst.

Deze user story borgt dat de Vernietigingscockpit vernietiging technisch onmogelijk maakt zolang niet aan alle goedkeuringsvoorwaarden is voldaan.

De story richt zich op het afdwingen van beslissingen, niet op het beoordelen ervan.

## Functionele scope
Deze user story omvat

- Technisch blokkeren van vernietiging zonder volledige accordering
- Controleren of alle vereiste goedkeuringen zijn verleend
- Blokkeren van vernietiging bij afwijzing of ontbrekend akkoord
- Duidelijke statusindicatie van de goedkeuringsfase

De story omvat geen inhoudelijke beoordeling of accorderingsfunctionaliteit zelf.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Het proces van accordering zelf
- Organisatorische afspraken over mandaat
- Escalatie buiten de cockpit
- Wijzigingen aan vernietigingslijsten na accordering

Deze onderwerpen worden behandeld in andere user stories en features.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Vernietiging technisch onmogelijk is zonder volledige accordering
- De cockpit controleert of alle vereiste rollen akkoord hebben gegeven
- Afwijzing of ontbrekend akkoord automatisch leidt tot blokkade
- De gebruiker duidelijk ziet waarom vernietiging niet kan plaatsvinden
- Geen omwegen bestaan om vernietiging toch te starten

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- DESIGN Technische architectuur Vernietigingscockpit
- EPIC Vernietigingsproces end to end
- FEATURE Accorderingsflow vernietigingslijst
- FEATURE Uitvoeren vernietiging

Besluiten over rolverdeling en verantwoordelijkheden zijn leidend.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor validatie van accorderingsstatus
- Blokkadelogica bij ontbreken van akkoord
- Frontend task voor status en foutmeldingen
- Testtask voor negatieve scenario’s