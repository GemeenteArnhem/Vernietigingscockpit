# STORY Doorklikken naar onderliggende informatieobjecten

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_012.

## User story
Als informatiebeheerder  
wil ik vanuit het overzicht een link naar de vermelde informatieobjecten kunnen openen  
zodat ik indien nodig een inhoudelijke controle kan uitvoeren voordat ik de lijst aanbied ter accordering.

## Toelichting
Bij twijfel of bij risicovolle dossiers moet de informatiebeheerder kunnen controleren wat de aard en inhoud van een informatieobject is.

Deze controle vindt altijd plaats in het bronsysteem zelf. De Vernietigingscockpit faciliteert uitsluitend het doorklikken, niet het bekijken of beheren van de inhoud.

## Functionele scope
Deze user story omvat

- Tonen van links naar onderliggende informatieobjecten
- Doorklikken naar het betreffende bronsysteem
- Ondersteuning van Single Sign On waar mogelijk
- Behoud van context bij het openen van het object

De cockpit toont geen inhoud van documenten.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Inhoudelijk openen of bewerken van documenten in de cockpit
- Autorisatiebeheer in het bronsysteem
- Validatie van inhoud door de cockpit

De cockpit blijft een regie en controlelaag.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- De gebruiker vanuit het overzicht kan doorklikken naar een informatieobject
- De link leidt naar het juiste object in het juiste bronsysteem
- De gebruiker ziet geen inhoud als hij daar geen rechten voor heeft
- De context van de vernietigingslijst behouden blijft
- Het doorklikken geen wijziging veroorzaakt in de vernietigingsstatus

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- DESIGN API Standaard Vernietiging
- EPIC Vernietigingsproces end to end
- FEATURE Selecteren en opstellen vernietigingslijst

De UX design sprint bepaalt hoe en wanneer links getoond worden.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor genereren van objectlinks
- Afhandeling van bronidentificatie en routing
- Frontend task voor tonen en openen van links
- Validatie van autorisatie-afhandeling