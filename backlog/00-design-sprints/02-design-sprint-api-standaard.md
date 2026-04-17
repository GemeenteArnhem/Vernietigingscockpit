# DESIGN API Standaard Vernietiging

## Doel
Het ontwerpen en vastleggen van een leveranciersonafhankelijke API-standaard voor het uitvoeren van vernietiging, waarmee de Vernietigingscockpit op een eenduidige manier kan samenwerken met uiteenlopende bronsystemen.

Deze design sprint richt zich op semantiek, lifecycle en contractafspraken, niet op technische implementatiedetails.

## Context
Gemeentelijke informatielandschappen bestaan uit veel verschillende systemen, cloud en on premises, modern en legacy.

De Vernietigingscockpit kan alleen functioneren als centrale regiecomponent wanneer koppelingen tussen cockpit en bronnen uniform, voorspelbaar en herbruikbaar zijn.

Deze design sprint vormt de basis voor een API-standaard die aansluit op Common Ground principes en inzetbaar is door meerdere leveranciers en gemeenten.

## Scope
Deze design sprint omvat

- Het functionele contract tussen cockpit en bronsysteem
- De lifecycle van een vernietigingstaak vanuit API-perspectief
- De verantwoordelijkheidsverdeling tussen cockpit en bron
- Terugkoppeling en logging vanuit bronnen

Buiten scope vallen

- Concrete endpoint naming en HTTP details
- Technologiekeuze of frameworks
- Referentie-implementaties

## Ontwerpvragen
Tijdens deze design sprint worden onder andere de volgende vragen beantwoord

- Welke informatieobjecten kan een bron aanleveren voor vernietiging
- Hoe wordt een vernietigingsopdracht eenduidig aangeboden aan een bron
- Hoe bevestigt een bron succesvolle of mislukte vernietiging
- Welke statusovergangen zijn toegestaan
- Hoe wordt onherstelbaarheid functioneel geborgd
- Welke metadata is minimaal vereist voor verantwoording

## Conceptuele lifecycle
De API-standaard ondersteunt ten minste de volgende conceptuele stappen

- Aanbieden van selecteerbare informatieobjecten
- Vastleggen van expliciet akkoord voor vernietiging
- Initiëren van vernietiging vanuit de cockpit
- Terugmelding van resultaat per bron
- Vastleggen van auditinformatie

Deze lifecycle wordt zodanig ontworpen dat bronnen niet zelfstandig hoeven te bepalen of vernietiging is toegestaan.

## Randvoorwaarden
- De cockpit heeft regie, de bron voert uit
- De API is idempotent waar mogelijk
- Foutafhandeling is expliciet en herleidbaar
- Logging ondersteunt toezicht en auditing
- De standaard is uitbreidbaar zonder breaking changes

## Verwachte output
Deze design sprint wordt als afgerond beschouwd wanneer het volgende is vastgelegd

- Een conceptueel API-model inclusief lifecycle
- Duidelijke afbakening van verantwoordelijkheden
- Minimale set vereiste gegevens en metadata
- Input voor OpenAPI specificatie v0.1
- Eén of meerdere decision issues waarin standaardafspraken expliciet zijn besloten

## Relatie met vervolgwerk
De uitkomsten van deze design sprint vormen de basis voor

- De API repository en standaardisatiewerk
- Implementatie-issues in cockpit en bronsystemen
- Architectuurbesluiten rondom synchroniteit en foutafhandeling