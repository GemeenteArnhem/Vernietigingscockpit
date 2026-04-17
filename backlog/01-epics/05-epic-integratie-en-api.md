# EPIC Integratie en API

## Doel
Deze epic richt zich op de integratie tussen de Vernietigingscockpit en bronsystemen via gestandaardiseerde APIs, zodat vernietiging centraal kan worden aangestuurd zonder afhankelijkheid van specifieke leveranciers of technische implementaties.

Het doel is een robuuste en herbruikbare integratielaag te realiseren die aansluit op Common Ground principes.

## Context
Gemeenten beschikken over een groot en divers applicatielandschap. Om vernietiging schaalbaar en beheersbaar te maken, moet de Vernietigingscockpit via uniforme afspraken kunnen communiceren met uiteenlopende bronnen.

Deze epic operationaliseert de uitkomsten van de API design sprint en vertaalt deze naar concrete integratiefunctionaliteit.

## Scope
Deze epic omvat

- Integratie tussen cockpit en bronsystemen via API’s
- Uitvoering van vernietigingsopdrachten via gekoppelde bronnen
- Ontvangen en verwerken van terugmeldingen
- Afhandeling van fouten en uitzonderingen in de keten
- Ondersteunen van meerdere bronnen binnen één vernietigingstaak

De focus ligt op functionele integratie, niet op leverancier specifieke details.

## Buiten scope
De volgende onderwerpen vallen buiten deze epic

- Ontwikkeling van bronapplicaties zelf
- Beheer van bronsystemen
- Migratie of opschoning van legacy data
- Niet-gestandaardiseerde maatwerkkoppelingen

Deze onderwerpen worden beschouwd als randvoorwaardelijk of organisatorisch.

## Relatie met design sprints
Deze epic is direct gebaseerd op

- DESIGN API Standaard Vernietiging
- DESIGN Technische architectuur Vernietigingscockpit

Zonder expliciete besluiten uit deze design sprints kan deze epic niet worden geïmplementeerd.

## Belangrijkste functionaliteiten
Binnen deze epic worden onder andere de volgende capabilities gerealiseerd

- Oproepen van bronsystemen op basis van een uniform API-contract
- Verwerken van selectiegegevens vanuit bronnen
- Initiëren van vernietigingsacties per bron
- Ontvangen van status en resultaatmeldingen
- Vastleggen van integratiestatus binnen de cockpit
- Herleidbare foutafhandeling per bron

## Acceptatiecriteria op epic-niveau
Deze epic kan als afgerond worden beschouwd wanneer

- Meerdere bronsystemen via dezelfde API-standaard kunnen worden aangesproken
- Vernietigingsopdrachten correct worden uitgevoerd en teruggekoppeld
- Fouten per bron afzonderlijk inzichtelijk zijn
- Integratie geen inhoudelijke beslissingen neemt
- Functionaliteit herbruikbaar is door andere gemeenten

## Relatie met vervolgwerk
Deze epic wordt uitgewerkt in features en user stories zoals

- Aansluiten van bronnen
- Initiëren van vernietiging per bron
- Verwerken van terugmeldingen
- Integratiestatus en foutafhandeling

Implementatie-issues worden expliciet gelabeld als `api-implementation`.