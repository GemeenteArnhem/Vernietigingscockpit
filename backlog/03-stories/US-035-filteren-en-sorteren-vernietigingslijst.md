# STORY Filteren en sorteren van de vernietigingslijst

## Oorsprong
Deze user story is afkomstig uit het overzicht van functionele eisen en was daar opgenomen als US_035.

## User story
Als proceseigenaar  
wil ik de vernietigingslijst kunnen filteren en sorteren naar mijn eigen behoefte  
zodat ik de lijst effectief kan beoordelen vanuit mijn inhoudelijke verantwoordelijkheid.

## Toelichting
Vernietigingslijsten kunnen groot en complex zijn, met informatie afkomstig uit meerdere processen, dossiers en bronnen.

Om een zorgvuldige beoordeling mogelijk te maken, moeten gebruikers de lijst kunnen aanpassen aan hun informatiebehoefte, bijvoorbeeld door te focussen op een specifiek zaaktype, periode of afdeling.

Deze functionaliteit ondersteunt inzicht en beoordeling, zonder de inhoud van de lijst te wijzigen.

## Functionele scope
Deze user story omvat

- Filteren van de vernietigingslijst op beschikbare metadata
- Sorteren van de lijst op relevante kolommen
- Combineren van meerdere filters tegelijk
- Wijzigen of verwijderen van actieve filters
- Toepassen van dezelfde functionaliteit op verschillende lijstweergaven

Filteren en sorteren zijn uitsluitend weergavefunctionaliteiten.

## Buiten scope
De volgende onderwerpen vallen buiten deze user story

- Permanent opslaan van filterinstellingen
- Wijzigen van de onderliggende selectie
- Dynamisch configureren van nieuwe metadata-velden
- Geavanceerde rapportage of analytics

Deze aspecten worden als aanvullend beschouwd.

## Acceptatiecriteria
Deze user story is als afgerond te beschouwen wanneer

- De gebruiker filters kan toepassen op relevante velden
- Meerdere filters gelijktijdig kunnen worden gebruikt
- De lijst kan worden gesorteerd in oplopende of aflopende volgorde
- Filteren en sorteren geen invloed hebben op de vernietigingsstatus
- De functionaliteit intuïtief en performant is

## Relatie met design en epics
Deze user story is gebaseerd op

- DESIGN UX Vernietigingscockpit kernflow
- Besluiten over inzicht en beoordeling
- EPIC Overzicht rapportage en audittrail
- FEATURE Selecteren en opstellen vernietigingslijst

UX-keuzes bepalen hoe filters en sortering worden aangeboden.

## Uit te werken taken
Deze user story wordt technisch uitgewerkt in onder andere

- Frontend task voor filter- en sorteercomponenten
- Backend task voor ondersteunen van gefilterde weergave
- Validatie op performance bij grote datasets
- Gebruikerstest voor begrijpelijkheid en effectiviteit