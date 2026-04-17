# STORY Overzicht op verschillende aggregatieniveaus

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_011.

## User story
Als informatiebeheerder  
wil ik een overzicht kunnen opstellen van te vernietigen informatieobjecten op verschillende aggregatieniveaus, zoals dossiers, datacollecties en documenten  
zodat ik op basis van risicomanagement kan beoordelen op een passend abstractieniveau.

## Toelichting
De informatiebeheerder heeft niet altijd behoefte aan detailniveau tot op documentniveau. Afhankelijk van risico, omvang of type informatie is beoordeling op hoger aggregatieniveau wenselijk.

Deze functionaliteit maakt het mogelijk om hetzelfde vernietigingsvoorstel te bekijken op verschillende niveaus van abstractie, zonder de samenhang te verliezen.

## Functionele scope
Deze user story omvat

- Weergave van informatieobjecten op meerdere aggregatieniveaus
- Mogelijkheid om te schakelen tussen bijvoorbeeld  
  - zaak of dossierniveau  
  - collectie niveau  
  - documentniveau
- Behoud van inhoudelijke samenhang tussen objecten
- Ondersteuning van risicogerichte beoordeling

De story omvat geen wijziging van gegevens in de bron.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- De gebruiker kan kiezen op welk aggregatieniveau het overzicht wordt getoond
- Aggregatieniveaus logisch en consistent zijn opgebouwd
- Onderliggende objecten herleidbaar blijven
- Het overzicht geschikt is voor inhoudelijke beoordeling
- De functionaliteit aansluit op de accorderingsflow

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over overzicht en transparantie
- EPIC Vernietigingsproces end to end
- FEATURE Selecteren en opstellen vernietigingslijst

UX-keuzes bepalen hoe niveaus worden gepresenteerd en gewisseld.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor ophalen en groeperen van objecten
- Logica voor aggregatie en de-aggregatie
- Frontend task voor weergave en navigatie tussen niveaus
- Validatie van samenhang en consistentie