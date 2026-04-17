# FEATURE Accorderingsflow vernietigingslijst

## Doel
Deze feature beschrijft de gestructureerde en expliciete accorderingsflow voor vernietigingslijsten, waarbij bevoegde rollen een inhoudelijke beoordeling uitvoeren voordat vernietiging wordt toegestaan.

Het doel is om verantwoordelijkheid, controle en transparantie te borgen door het accorderingsproces stap voor stap vast te leggen.

## Context
Vernietiging van informatie mag niet plaatsvinden zonder expliciete instemming van bevoegde rollen. In de gemeentelijke context zijn dit minimaal de proceseigenaar en de gemeentelijk archivaris.

Deze feature operationaliseert de accorderingsstappen zoals ontworpen in de UX design sprint en borgt deze technisch en functioneel.

## Scope
Deze feature omvat

- Het aanbieden van een vernietigingslijst ter accordering
- Accordering door proceseigenaar
- Accordering door archivaris
- Vastleggen van akkoord of afwijzing per lijst
- Vastleggen van datum, tijd en identiteit bij accordering
- Volgorde afdwingen in accorderingsstappen
- Terugkoppeling van afwijzing aan de informatiebeheerder

Accordering vindt plaats op lijstniveau, niet op individueel objectniveau.

## Buiten scope
De volgende onderwerpen vallen buiten deze feature

- Het selecteren of aanpassen van de vernietigingslijst
- Het uitvoeren van vernietiging
- Mandaatafspraken buiten de applicatie
- Escalatie buiten de cockpit om

Deze onderwerpen worden elders uitgewerkt.

## Gebruikers en rollen
Binnen deze feature zijn de volgende rollen betrokken

- Informatiebeheerder of recordmanager
- Proceseigenaar
- Gemeentelijk archivaris

Iedere rol heeft een eigen verantwoordelijkheid en bevoegdheid in het accorderingsproces.

## Functionele beschrijving
Na het opstellen van een vernietigingslijst kan de informatiebeheerder de lijst ter accordering aanbieden.

De proceseigenaar ontvangt een verzoek tot beoordeling en ziet een geaggregeerd overzicht van de lijst. De proceseigenaar kan

- De lijst beoordelen
- Akkoord geven
- Of de lijst afwijzen

Na akkoord van de proceseigenaar wordt de lijst automatisch aangeboden aan de archivaris. Pas na akkoord van beide rollen kan de vernietiging worden uitgevoerd.

Afwijzingen worden vastgelegd en teruggekoppeld aan de informatiebeheerder.

## Relatie met design sprints
Deze feature is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over rolverdeling en verantwoordelijkheid
- Architectuurkeuzes rondom autorisatie en logging

UX-keuzes zijn leidend voor de wijze van presenteren en accorderen.

## Acceptatiecriteria op feature-niveau
Deze feature kan als afgerond worden beschouwd wanneer

- Accordering alleen mogelijk is voor bevoegde rollen
- De volgorde van accorderen technisch wordt afgedwongen
- Akkoord of afwijzing expliciet wordt vastgelegd
- Identiteit en tijdstip van accordering worden gelogd
- Vernietiging niet mogelijk is zonder volledige accordering

## Relatie met vervolgwerk
Deze feature wordt verder uitgewerkt in user stories zoals

- Ter accordering aanbieden van vernietigingslijst
- Accordering door proceseigenaar
- Accordering door archivaris
- Blokkeren van vernietiging bij ontbrekend akkoord