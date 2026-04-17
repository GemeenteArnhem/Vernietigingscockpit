# STORY Vernietigen onafhankelijk van bestandsformaat

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_032.

## User story
Als informatiebeheerder  
wil ik dat vernietiging van informatieobjecten mogelijk is ongeacht het bestandsformaat  
zodat ik zeker weet dat alle bestanden daadwerkelijk worden meegenomen in de vernietiging.

## Toelichting
Gemeentelijke informatiesystemen bevatten informatie in uiteenlopende bestandsformaten, zoals tekst, afbeeldingen, audio, video en gestructureerde data.

Vernietiging mag niet afhankelijk zijn van het type bestand of technische eigenschappen daarvan. De Vernietigingscockpit moet daarom format-onafhankelijk functioneren en geen inhoudelijke aannames doen over bestanden.

Deze user story borgt volledigheid en voorkomt schijnvernietiging.

## Functionele scope
Deze user story omvat

- Ondersteunen van vernietiging voor alle bestandsformaten die door bronsystemen worden aangeboden
- Geen uitsluiting op basis van bestandstype of extensie
- Functionele gelijkwaardigheid van vernietiging ongeacht formaat
- Vastleggen dat vernietiging is uitgevoerd zonder onderscheid naar type

De cockpit beoordeelt of stuurt niet op inhoud of formaat.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Technische implementatie van bestandsverwijdering in bronsystemen
- Validatie of inhoud leesbaar of reproduceerbaar is
- Conversie of transformatie van bestanden
- Specifieke rich media optimalisaties

Deze aspecten zijn verantwoordelijkheid van de bron.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Vernietigingsacties niet afhankelijk zijn van bestandsformaat
- Alle door bronnen aangeboden objecten gelijkwaardig worden behandeld
- Er geen uitzonderingen zijn op basis van extensie of type
- Vernietiging aantoonbaar en herleidbaar is vastgelegd
- Gebruikers geen extra handelingen hoeven te verrichten per formaat

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN API Standaard Vernietiging
- DESIGN Technische architectuur Vernietigingscockpit
- EPIC Vernietigingsproces end to end
- EPIC Integratie en API
- FEATURE Uitvoeren vernietiging

Architectuurkeuzes bepalen hoe format-onafhankelijkheid technisch wordt afgedwongen.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Validatie dat alle objecttypes via API worden verwerkt
- Integratietask om bestandsmetadata generiek te behandelen
- Testtask met verschillende bestandstypen
- Audit en logging van vernietiging zonder onderscheid naar formaat