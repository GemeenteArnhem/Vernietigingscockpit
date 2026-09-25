# Leveranciersinstructie bronadapter en selectielogica

Dit document beschrijft welke informatie een leverancier moet aanleveren en implementeren om een Stekker te ontwikkelen voor de eigen applicatie of applicatiefamilie.

De Stekker moet voldoen aan:

- `stekker-openapi-spec.yaml`
- `stekker-openapi-contract.md`
- `api-informatiemodel.md`
- `stekker-api-implementatiechecklist.md`

Dit document vult die afspraken aan voor de bronadapter en de selectielogica. De architectuur schrijft niet voor hoe de leverancier dit intern bouwt, maar wel welk gedrag aantoonbaar geleverd moet worden.

## 1. Doel van de Stekker

De Stekker vormt de technische koppeling tussen de Vernietigingscockpit en de applicatie van de leverancier.

De Stekker:

- bepaalt vernietigingskandidaten op basis van brondata, selectieregels en configuratie;
- levert deze kandidaten via de Stekker API aan de Cockpit;
- voert na vrijgave door de Cockpit de vernietiging technisch uit;
- rapporteert per aangeboden kandidaat het uitvoeringsresultaat terug.

De Stekker neemt geen normatieve besluiten. De Cockpit beoordeelt, sluit uit, accordeert en verantwoordt.

## 2. Verantwoordelijkheden van de leverancier

De leverancier is verantwoordelijk voor:

- de bronadapter naar de eigen applicatie of gegevensbron;
- de interpretatie van brondata;
- de toepassing van de selectielogica binnen de afgesproken configuratie;
- het bepalen van `vernietigingskandidaatId`, `bronId` en `bronIdNaam`;
- het technisch vernietigen of laten vernietigen van objecten in de bron;
- het detecteren van afwijkingen tussen selectie en vernietiging;
- het rapporteren van resultaten volgens de Stekker API;
- logging, foutafhandeling, idempotentie en herstartbaarheid binnen de Stekker.

De leverancier mag geen Cockpit-specifieke workflowlogica of normatieve besluitvorming in de Stekker opnemen.

## 3. Bronadapter

De leverancier beschrijft en implementeert hoe de Stekker de bron benadert.

Minimaal aan te leveren:

| Onderwerp | Toelichting |
|--------|--------|
| Bronnaam | Naam van de applicatie, module of gegevensbron die de Stekker ontsluit. |
| Bronbereik | Welke objecttypen, dossiers, documenten of records vallen binnen scope. |
| Technische toegang | API, database, exportbestand, message queue of andere toegangsvorm. |
| Authenticatie | Hoe de Stekker zich bij de bron authenticeert. |
| Autorisatie | Welke rechten nodig zijn voor lezen, selecteren en vernietigen. |
| Rate limits | Beperkingen in snelheid, volumes of piekbelasting. |
| Beschikbaarheid | Verwachte beschikbaarheid en onderhoudsvensters van de bron. |
| Foutgedrag | Hoe de bron fouten, time-outs en partial failures teruggeeft. |
| Transactiegedrag | Of vernietiging atomair, per object of per batch plaatsvindt. |
| Herstelgedrag | Hoe de Stekker veilig hervat na onderbreking of retry. |

## 4. Identificaties

De leverancier moet drie identificaties eenduidig invullen.

| Veld | Betekenis | Eis |
|--------|--------|--------|
| `vernietigingskandidaatId` | Stabiele identificatie van de vernietigingskandidaat over selectie, beoordeling, vernietiging en resultaatverwerking. | Moet stabiel blijven binnen het hele proces. |
| `bronId` | Technische sleutel waarmee de Stekker het object in de bron kan terugvinden en vernietigen. | Moet voldoende zijn voor technische uitvoering. |
| `bronIdNaam` | Gebruikersherkenbare naam of aanduiding van het object. | Moet bruikbaar zijn voor weergave en controle in de Cockpit. |

Voorbeeld:

```json
{
  "vernietigingskandidaatId": "vk-2026-000123",
  "bronId": "8f7410a8-3b8a-42a8-8c10-7424f589e501",
  "bronIdNaam": "ZAAK-2020-00421"
}
```

`bronId` mag gelijk zijn aan `bronIdNaam` als dezelfde waarde zowel technisch uitvoerbaar als gebruikersherkenbaar is. Als dat niet zo is, moeten ze gescheiden blijven.

## 5. Selectielogica

De leverancier beschrijft hoe vernietigingskandidaten worden bepaald.

Minimaal aan te leveren:

| Onderwerp | Toelichting |
|--------|--------|
| Selectiecriteria | Welke regels bepalen dat een object vernietigbaar is. |
| Selectielijst | Welke selectielijst of welk normenkader wordt toegepast. |
| Classificatie | Hoe classificatieschema, sleutel en omschrijving worden bepaald. |
| Resultaat en waardering | Hoe resultaattype, bewaartermijn en waardering worden afgeleid. |
| Peildatum | Hoe de peildatum wordt toegepast. |
| Begin- en einddatum | Welke bronvelden worden gebruikt voor periodebepaling. |
| Vernietigingsdatum | Hoe de vernietigingsdatum wordt berekend. |
| Uitzonderingen | Welke bronstatussen of kenmerken selectie uitsluiten. |
| Onzekerheden | Hoe ontbrekende, inconsistente of onvolledige data wordt behandeld. |
| Configuratieversie | Hoe wordt vastgelegd welke configuratie is gebruikt. |

De Stekker mag geen kandidaten leveren waarvan niet betrouwbaar kan worden vastgesteld dat ze vernietigingskandidaat zijn. Onzekerheden moeten zichtbaar worden gemaakt via waarschuwingen, fouten of logging.

## 6. Selectieresultaat

Elke geselecteerde kandidaat bevat minimaal:

- `vernietigingskandidaatId`
- `bronId`
- `bronIdNaam`
- `omschrijving`
- `selectielijst`
- `grondslag`
- `bewaartermijn`
- `waardering`
- `begindatum`
- `einddatum`
- `vernietigingsdatum`

Aanvullende metadata wordt geleverd wanneer beschikbaar, zoals classificatiegegevens, aantallen, betrokkenen, relatiegegevens, bronstatus of toelichting.

De selectie is bevroren zodra de status `READY` is. Dezelfde selectie moet bij herhaald ophalen dezelfde kandidaten opleveren.

## 7. Vernietiging

De Cockpit biedt na beoordeling en accordering alleen vrijgegeven kandidaten aan de Stekker aan.

Een vernietigingsbatch bevat per object minimaal:

- `vernietigingskandidaatId`
- `bronId`

De Stekker moet controleren dat:

- de `vernietigingskandidaatId` hoort bij de onderliggende selectie;
- de `bronId` overeenkomt met de kandidaat zoals eerder geselecteerd;
- het object nog bestaat;
- het object niet zodanig is gewijzigd dat vernietiging niet meer betrouwbaar is.

De Stekker mag geen extra objecten toevoegen aan een vernietiging. De Stekker vernietigt alleen objecten die expliciet door de Cockpit zijn aangeboden.

Het aanbieden van batches is nog geen startsein voor technische vernietiging. De leverancier moet implementeren dat de Stekker pas start nadat de Cockpit de vernietiging expliciet vrijgeeft via:

`POST /vernietigingen/{vernietigingId}/vrijgeven`

Bij vrijgave levert de Cockpit minimaal:

- `aantalBatches`
- `aantalKandidaten`

De Stekker controleert deze aantallen tegen de ontvangen batches en kandidaten. Bij ontbrekende of afwijkende batches retourneert de Stekker `409 Conflict` en start de technische vernietiging niet.

## 8. Afwijkingen tussen selectie en vernietiging

De bron kan wijzigen tussen selectie en uitvoering. De Stekker moet afwijkingen detecteren en per object rapporteren.

Gebruik minimaal deze resultaatwaarden:

| Resultaat | Betekenis |
|--------|--------|
| `SUCCESS` | Het object is succesvol vernietigd. |
| `FAILED` | De vernietiging is geprobeerd maar mislukt. |
| `SKIPPED` | De vernietiging is niet uitgevoerd. |
| `NOT_FOUND` | Het object bestaat niet meer of kan niet worden gevonden. |
| `CHANGED` | Het object is sinds selectie gewijzigd en is daarom niet vernietigd. |

`NOT_FOUND` en `CHANGED` zijn objectresultaten, geen HTTP-fouten.

## 9. Idempotentie en herstartbaarheid

De Stekker moet veilig kunnen omgaan met retries vanuit de Cockpit.

Minimale eisen:

- batchverwerking is idempotent op `vernietigingId + batchNummer`;
- vrijgave voor uitvoering is idempotent voor dezelfde `vernietigingId` en dezelfde aantallen;
- een identieke batch opnieuw aanbieden leidt niet tot dubbele vernietiging;
- dezelfde `batchNummer` met afwijkende payload levert `409 Conflict`;
- gedeeltelijke verwerking kan veilig worden hervat;
- eerdere resultaten blijven opvraagbaar;
- retries en herstelacties worden technisch gelogd.

## 10. Logging en observability

De Stekker legt minimaal vast:

- tijdstip van request en verwerking;
- `selectieId`;
- `vernietigingId`;
- `batchNummer`;
- `vernietigingskandidaatId`;
- `bronId`;
- resultaat of foutcode;
- technische foutdetails waar relevant;
- `correlatieId` of `logReference`.

Logging ondersteunt foutanalyse en beheer. De formele verantwoording vindt plaats in het vernietigingsdossier van de Cockpit.

## 11. Foutafhandeling

HTTP-fouten worden gebruikt voor fouten op request- of resourceniveau.

Objectresultaten worden gebruikt wanneer de request geldig is, maar de uitvoering voor een specifiek object niet succesvol is.

Minimale HTTP-fouten:

| Status | Gebruik |
|--------|--------|
| `400` | Ongeldige of onvolledige request. |
| `401` | Authenticatie ontbreekt of is ongeldig. |
| `403` | Client is niet geautoriseerd. |
| `404` | Selectie, vernietiging of batch bestaat niet. |
| `409` | Ongeldige state transition of idempotentieconflict. |
| `500` | Onverwachte technische fout. |

Elke foutresponse gebruikt het standaard foutmodel uit de OpenAPI-specificatie.

## 12. Opleveringen door leverancier

De leverancier levert minimaal op:

1. Een werkende Stekker-implementatie die voldoet aan de OpenAPI-specificatie.
2. Een beschrijving van de bronadapter.
3. Een beschrijving van de selectielogica.
4. Een beschrijving van de mapping naar `vernietigingskandidaatId`, `bronId` en `bronIdNaam`.
5. Een beschrijving van vernietigingsgedrag in de bron.
6. Een overzicht van foutcodes en foutcategorieen.
7. Een beschrijving van logging, monitoring en correlatie.
8. Testresultaten voor de acceptatiescenario's uit `stekker-api-implementatiechecklist.md`.
9. Een configuratievoorbeeld voor test en acceptatie.
10. Een beheerinstructie voor credentials, rate limits, retries en herstart.

## 13. Acceptatie

Een Stekker wordt pas geaccepteerd wanneer:

- de OpenAPI-specificatie zonder fouten valideert;
- alle verplichte endpoints werken;
- de selectie reproduceerbaar en bevroren is na `READY`;
- vernietiging alleen gebeurt voor expliciet aangeboden kandidaten;
- idempotentie aantoonbaar werkt;
- objectresultaten volledig en herleidbaar zijn;
- foutafhandeling voldoet aan het contract;
- logging voldoende is voor foutanalyse;
- de acceptatiescenario's uit de implementatiechecklist slagen.
