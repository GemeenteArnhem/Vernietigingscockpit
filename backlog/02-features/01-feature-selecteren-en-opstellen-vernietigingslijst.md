# FEATURE Selecteren en opstellen vernietigingslijst

## Doel
Deze feature beschrijft het selecteren van in aanmerking komende informatieobjecten en het opstellen van een vernietigingslijst die als basis dient voor beoordeling en accordering.

Het doel is dat informatiebeheerders op een gecontroleerde en transparante manier een vernietigingslijst kunnen samenstellen, aanpassen en voorbereiden voor accorderingsrondes.

## Context
De vernietigingslijst vormt het hart van het vernietigingsproces. Deze lijst moet volledig, begrijpelijk en navolgbaar zijn, zodat betrokken rollen een inhoudelijke beoordeling kunnen uitvoeren vóórdat vernietiging plaatsvindt.

De feature sluit aan op de UX design sprint en gebruikt selectiecriteria afkomstig uit bronsystemen.

## Scope
Deze feature omvat

- Ophalen van selecteerbare informatieobjecten uit één of meerdere bronnen
- Tonen van selectie over meerdere aggregatieniveaus
- Groeperen van objecten op zaak, dossier of ander logisch verband
- Mogelijkheid tot uitsluiten van individuele objecten of groepen
- Vastleggen van toelichtingen bij uitsluitingen
- Tussentijds opslaan van concept-vernietigingslijsten

## Buiten scope
De volgende onderwerpen vallen buiten deze feature

- Accordering en goedkeuring van de lijst
- Uitvoering van vernietiging
- Beheer van selectiecriteria in bronsystemen
- Geavanceerde rapportage en exports

Deze onderwerpen worden behandeld in afzonderlijke features en epics.

## Gebruikers en rollen
Primair gericht op

- Informatiebeheerder of recordmanager

Secundair relevant voor

- Proceseigenaar
- Archivaris

Deze rollen beoordelen later de output van deze feature.

## Functionele beschrijving
De informatiebeheerder start met het ophalen van selecties uit geconfigureerde bronnen. De cockpit toont een overzicht van informatieobjecten die op basis van vastgestelde criteria in aanmerking komen voor vernietiging.

De gebruiker kan

- Details van objecten bekijken
- Groepen uitklappen of samenvouwen
- Objecten of volledige groepen uitsluiten
- Een motivering toevoegen bij uitsluitingen
- De lijst opslaan en later hervatten

De vernietigingslijst blijft een concept tot deze expliciet ter accordering wordt aangeboden.

## Relatie met design sprints
Deze feature is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow