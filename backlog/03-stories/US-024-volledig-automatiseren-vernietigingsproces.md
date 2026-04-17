# STORY Volledig automatiseren van het vernietigingsproces voor bepaalde processen

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_024.

## User story
Als informatiebeheerder  
wil ik voor bepaalde processen het vernietigingsproces volledig kunnen automatiseren  
zodat ik geen handmatige goedkeuringslijsten hoef op te stellen wanneer dat geen toegevoegde waarde heeft.

## Toelichting
Niet elk vernietigingsproces vraagt om dezelfde mate van handmatige beoordeling. Voor gestandaardiseerde, laag-risico processen kan volledige automatisering wenselijk en verantwoord zijn.

Deze user story maakt het mogelijk om op basis van vooraf vastgestelde criteria vernietiging automatisch te laten verlopen, zonder afzonderlijke accorderingsstappen per cyclus.

Automatisering is altijd expliciet ingericht en nooit de standaard.

## Functionele scope
Deze user story omvat

- Configureren van processen waarvoor vernietiging automatisch mag verlopen
- Automatisch selecteren van objecten op basis van vastgestelde criteria
- Automatisch doorlopen van vernietigingsstappen zonder handmatige accordering
- Vastleggen van uitgevoerde vernietiging en verantwoording
- Mogelijkheid tot uitsluiten van specifieke objecten of situaties

Automatisering vindt plaats binnen vooraf vastgestelde kaders.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Organisatorische besluitvorming over welke processen geautomatiseerd mogen worden
- Wijzigen van wettelijke eisen of selectielijsten
- Volledige afschaffing van accordering voor alle processen
- Zelflerende of adaptieve automatisering

Deze aspecten worden bestuurlijk of organisatorisch bepaald.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- Automatisering per proces expliciet kan worden ingesteld
- Alleen vooraf goedgekeurde processen automatisch worden uitgevoerd
- Vernietiging automatisch maar aantoonbaar plaatsvindt
- Afwijkingen en uitzonderingen zichtbaar blijven
- Automatische vernietiging volledig wordt gelogd en verantwoord

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN Technische architectuur Vernietigingscockpit
- Besluiten over automatisering en risicoklassen
- EPIC Vernietigingsproces end to end
- EPIC Afwijkingen bewaartermijnen
- FEATURE Uitvoeren vernietiging

Architectuurkeuzes bepalen hoe automatisering veilig wordt ingericht.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Backend task voor configuratie van automatische processen
- Validatie dat automatisering alleen binnen vastgestelde kaders plaatsvindt
- Logging en audit van automatische vernietiging
- Frontend task voor inzicht in automatische processen