# Begeleidend contract – Stekker API Vernietigingscockpit

Dit document beschrijft de normatieve afspraken en gedragsregels voor implementaties van de Stekker API. Deze afspraken zijn bindend voor alle leveranciers en implementaties. De OpenAPI-specificatie en dit begeleidend contract vormen samen het contract tussen de Vernietigingscockpit en de stekker.

De Stekker API ondersteunt het selecteren en vernietigen van informatieobjecten. In dit contract wordt hiervoor de term **informatieobjecten** gebruikt. Waar de context duidelijk is, mag dit worden afgekort tot **objecten**. Voor informatieobjecten die in aanmerking komen voor vernietiging wordt steeds de term **vernietigingskandidaten** gebruikt.

Dit contract is opgesteld in lijn met gangbare ontwerpprincipes en publieke standaarden voor overheidssoftware en API’s, waaronder:

* NeRDS leidraad softwareontwikkeling
* API Design Rules (ADR)
* Common Ground

Daarbij is gekozen voor een resource-georiënteerde, eenvoudige en domeingedreven opzet. De API maakt de processtatus en uitvoeringsresultaten van selectie en vernietiging opvraagbaar via stabiel identificeerbare resources, terwijl de verantwoordelijkheden tussen cockpit, stekker en bronsysteem strikt gescheiden blijven.

## 1. Doel en uitgangspunten

De Stekker API faciliteert:

- het leveren van een bevroren selectie van vernietigingskandidaten (selectie)
- het uitvoeren van vernietiging op basis van door de cockpit vrijgegeven informatieobjecten (vernietiging)
- het terugkoppelen van vernietigingsresultaten per informatieobject (resultaatverantwoording)

Daarbij geldt:

- de cockpit voert regie, beoordeling, accordering en verantwoording uit
- de cockpit bepaalt welke informatieobjecten na besluitvorming ter vernietiging worden aangeboden
- de stekker voert selectie en vernietiging operationeel uit
- de stekker bevat de bron- en domeinspecifieke logica, zoals bewaartermijnen, selectieregels en technische uitvoeringsregels
- de stekker rapporteert per informatieobject het resultaat van de uitvoering terug aan de cockpit
- de cockpit bevat geen selectie- of vernietigingslogica
- de cockpit verwerkt de teruggekoppelde resultaten in het vernietigingsdossier en gebruikt deze voor verantwoording, controle en de verklaring van vernietiging

## 2. Algemene principes

De algemene architectuurprincipes, verantwoordelijkheden en scheiding tussen cockpit, stekker en bronsysteem zijn vastgelegd in `architectuur-stekker.md`. Dit begeleidend contract specificeert hoe deze principes via de Stekker API worden toegepast.

De Stekker API volgt een resource-georiënteerd ontwerp conform de API Design Rules. De exacte endpoints, request- en responsemodellen, statuscodes en foutmodellen zijn vastgelegd in de OpenAPI-specificatie.

De API volgt daarbij de volgende uitgangspunten:

- selecties en vernietigingen worden als afzonderlijke resources beschikbaar gemaakt
- iedere selectie heeft een stabiele `selectieId`
- iedere vernietiging heeft een stabiele `vernietigingId`
- processturing, herstart, audit en dossieropbouw gebruiken altijd deze stabiele identificaties
- de API is stateless in interactie, maar maakt de processtatus opvraagbaar via resources
- de stekker beheert de operationele toestand van selecties en vernietigingen
- de cockpit voert procesregie, batching, herstart en verwerking van resultaten uit

### 2.1 Scheiding van verantwoordelijkheden

De scheiding van verantwoordelijkheden is normatief vastgelegd in `architectuur-stekker.md`.

Voor dit API-contract betekent dit:

- de cockpit bepaalt welke vrijgegeven informatieobjecten ter vernietiging worden aangeboden
- de stekker bepaalt hoe selectie en vernietiging technisch worden uitgevoerd
- de stekker retourneert status en resultaten aan de cockpit
- de cockpit verwerkt deze resultaten in het vernietigingsdossier

De stekker mag geen normatieve besluiten nemen. De cockpit mag geen selectie- of vernietigingslogica uitvoeren.

### 2.2 Stateless API, state in resources

De API is stateless in interactie: iedere request bevat voldoende informatie om de gevraagde actie of opvraging te kunnen uitvoeren. De operationele toestand van selectie en vernietiging wordt door de stekker beheerd en via resources beschikbaar gemaakt.

Selecties en vernietigingen zijn altijd adresseerbare resources:

- selecties zijn beschikbaar via `/selecties/{selectieId}`
- informatieobjecten binnen een selectie zijn beschikbaar via `/selecties/{selectieId}/objecten`
- vernietigingen zijn beschikbaar via `/vernietigingen/{vernietigingId}`
- batches en resultaten van een vernietiging zijn beschikbaar via `/vernietigingen/{vernietigingId}/batches`
- resultaten van een batch zijn beschikbaar via `/vernietigingen/{vernietigingId}/batches/{batchNummer}`

Hierdoor kunnen meerdere selecties en vernietigingen naast elkaar bestaan binnen dezelfde stekker. Dit ondersteunt parallelle vernietiging, herstartbaarheid, reproduceerbaarheid en audit.

Een stekker kan bijvoorbeeld één systeem voor het sociaal domein ontsluiten. Binnen dat systeem kunnen afzonderlijke processen bestaan, zoals handhaving en uitkering. Dezelfde stekker kan dan zowel een vernietigingstaak voor handhavingsdossiers als een vernietigingstaak voor uitvoeringsdossiers ondersteunen. Deze taken zijn afzonderlijk adresseerbaar en herleidbaar via hun eigen `selectieId` en `vernietigingId`.

### 2.3 Resource-identificatie

`selectieId` en `vernietigingId` zijn blijvende identificaties binnen de context van de stekker.

Deze identificaties worden gebruikt voor:

- processturing
- statusopvraging
- ophalen van vernietigingskandidaten
- aanbieden en volgen van batches
- herstart en herstel
- audit en dossieropbouw
- terugkoppeling van uitvoeringsresultaten

Een selectie of vernietiging mag na aanmaak niet stilzwijgend van betekenis veranderen. Nieuwe selectie- of vernietigingsruns krijgen een nieuwe identificatie.

## 3. Selectie

### 3.1 Definitie

Een selectie is een bevroren momentopname van vernietigingskandidaten.

Dit betekent:

- de selectie heeft een `selectieId`
- de selectie heeft een `selectionTimestamp`
- de selectie bevat de informatieobjecten die op dat moment als vernietigingskandidaat zijn bepaald
- de selectie verandert niet meer nadat deze gereed is (`READY`)
- dezelfde selectie levert bij herhaald opvragen dezelfde lijst met vernietigingskandidaten op

Hierdoor kan de cockpit de selectie beoordelen, vastleggen en gebruiken in het vernietigingsdossier.

### 3.2 Starten van een selectie

`POST /selecties` start een nieuwe selectie.

Bij het starten van een selectie maakt de stekker een nieuwe selectie-resource aan met een eigen `selectieId`.

Een nieuwe selectie overschrijft geen bestaande selectie. Eerdere selecties blijven via hun eigen `selectieId` opvraagbaar zolang dat nodig is voor processturing, herstart, audit en dossieropbouw.

### 3.3 Status van een selectie

`GET /selecties/{selectieId}` retourneert de status van een selectie.

De response bevat minimaal:

- `selectieId`
- `status` (`IDLE`, `RUNNING`, `READY`, `FAILED`)
- `selectionTimestamp`
- `totaalObjecten`

### 3.4 Ophalen van vernietigingskandidaten

Vernietigingskandidaten binnen een selectie worden opgehaald via:

`GET /selecties/{selectieId}/objecten`

Daarbij geldt:

- standaard wordt paginering toegepast via `offset` en `limit`
- de maximale paginagrootte is 500
- iedere pagina bevat informatieobjecten uit dezelfde selectie
- iedere response bevat de gebruikte `selectieId`

De paginering is technisch bedoeld om grote lijsten beheersbaar op te halen. Paginering verandert de inhoud van de selectie niet.

#### Toekomstige uitbreiding

De API is uitbreidbaar naar cursor-based paginering:

- `cursor` kan als alternatief voor `offset` worden geïntroduceerd
- deze uitbreiding moet backward compatible zijn

### 3.5 Stabiliteit van de selectie

De stekker moet garanderen dat alle pagina’s die via `/selecties/{selectieId}/objecten` worden opgehaald, uit dezelfde bevroren selectie komen.

De stekker mag geen informatieobjecten toevoegen aan of verwijderen uit een selectie nadat deze gereed is (`READY`).

Wanneer brongegevens na het maken van de selectie wijzigen, wijzigt de bestaande selectie niet. Afwijkingen tussen selectie en latere vernietiging worden bij de uitvoering gerapporteerd als objectresultaat.

## 4. Vernietiging

### 4.1 Start van vernietiging

`POST /vernietigingen` start een nieuwe vernietiging.

Een vernietiging wordt gestart nadat de cockpit een selectie heeft beoordeeld, eventuele uitsluitingen heeft verwerkt en de vernietiging normatief is vrijgegeven.

Bij het starten van een vernietiging maakt de stekker een nieuwe vernietiging-resource aan met een eigen `vernietigingId`.

De request bevat minimaal:

- de `selectieId` waarop de vernietiging is gebaseerd
- de scope van de vernietiging
- de informatie die nodig is om de vernietiging herleidbaar te maken tot de cockpit-taak en het genomen besluit

De stekker zet de vernietiging na acceptatie op `IDLE` wanneer de vernietiging is aangemaakt maar nog niet gestart, of op `RUNNING` wanneer de verwerking is gestart of ingepland.

### 4.2 Parallelle vernietiging

Een stekker mag meerdere vernietigingen parallel ondersteunen.

Parallelle vernietiging is toegestaan wanneer vernietigingen afzonderlijk adresseerbaar, herleidbaar en controleerbaar blijven via hun eigen `vernietigingId`.

Daarbij geldt:

- iedere vernietiging heeft een eigen `vernietigingId`
- iedere vernietiging verwijst naar de selectie waarop deze is gebaseerd
- batches worden altijd gekoppeld aan één specifieke `vernietigingId`
- resultaten worden altijd per `vernietigingId`, batch en informatieobject teruggekoppeld
- fouten of blokkades binnen één vernietiging mogen andere vernietigingen niet automatisch blokkeren

Een stekker kan bijvoorbeeld één systeem voor het sociaal domein ontsluiten. Binnen dat systeem kunnen parallel vernietigingen lopen voor verschillende processen, zoals handhaving en uitkering. Deze vernietigingen moeten apart gevolgd en verantwoord kunnen worden.

Wanneer dezelfde informatieobjecten in meerdere vernietigingen voorkomen, blijft de verwerking doorlopen. Als een informatieobject al eerder is vernietigd of niet meer bestaat, wordt de uitvoering voor dat informatieobject genegeerd en rapporteert de stekker `NOT_FOUND`.

### 4.3 Batchverwerking

Vernietiging gebeurt in batches.

Een batch is een technische groepering van informatieobjecten binnen één vernietiging. Batches zijn bedoeld om grote aantallen informatieobjecten beheersbaar te verwerken en te kunnen herstarten.

Een batch is dus geen afzonderlijk normatief besluit en geen aparte vernietigingstaak. Het besluit tot vernietiging ligt vast in de cockpit. De batch is alleen een technische verdeling van de uitvoering.

Batches worden aangeboden via:

`POST /vernietigingen/{vernietigingId}/batches`

Iedere batch bevat minimaal:

- `batchNummer`
- een lijst met informatieobjecten
- per informatieobject het `recordId`
- eventueel aanvullende identificerende gegevens die nodig zijn voor uitvoering en controle

Ieder `recordId` dat vernietigd moet worden, wordt expliciet door de cockpit in de `POST` meegestuurd. De stekker mag niet zelfstandig extra informatieobjecten toevoegen aan een vernietiging.

### 4.4 Idempotentie

De stekker moet batches idempotent verwerken.

Dit betekent:

- de stekker herkent een batch binnen dezelfde vernietiging op basis van `vernietigingId` en `batchNummer`
- de stekker voert dezelfde batch nooit dubbel uit
- bij dubbele aanlevering levert de stekker hetzelfde resultaat terug of negeert de dubbele aanlevering veilig
- gedeeltelijk verwerkte batches kunnen veilig worden hervat
- verwerking blijft herleidbaar per batch en per informatieobject

Idempotentie voorkomt dat een technische retry leidt tot dubbele vernietiging of onduidelijke resultaten.

### 4.5 Asynchrone verwerking

Vernietiging wordt asynchroon uitgevoerd.

De `POST`-requests starten of vervolgen de verwerking, maar bevatten geen definitieve uitvoeringsresultaten. De cockpit haalt status en resultaten op via de daarvoor bedoelde `GET`-endpoints.

De requests worden getriggerd door de cockpit. De cockpit doet dit op basis van:

- een afgeronde beoordeling van vernietigingskandidaten
- de vereiste accordering binnen de workflow
- het vrijgeven van de vernietigingstaak
- technische batching door de cockpit
- eventuele retries of herstarts

De stekker voert vernietiging alleen uit voor informatieobjecten die expliciet door de cockpit zijn aangeboden binnen een batch.

Resultaten worden opgevraagd via:

- `GET /vernietigingen/{vernietigingId}`
- `GET /vernietigingen/{vernietigingId}/batches`
- `GET /vernietigingen/{vernietigingId}/batches/{batchNummer}`

## 5. Resultaten via API

### 5.1 Polling als primair mechanisme

De API is polling-gebaseerd. De cockpit haalt status en resultaten actief op via de API.

De stekker hoeft geen definitief uitvoeringsresultaat terug te sturen in de response op een `POST`-request waarmee een vernietiging wordt gestart of waarmee een batch wordt aangeboden.

Definitieve status en uitvoeringsresultaten worden opgehaald via de `GET`-endpoints.

### 5.2 Resultaten als bron voor uitvoeringsterugkoppeling

Uitvoeringsresultaten zijn opvraagbaar via de API:

- `GET /vernietigingen/{vernietigingId}`
- `GET /vernietigingen/{vernietigingId}/batches`
- `GET /vernietigingen/{vernietigingId}/batches/{batchNummer}`

De stekker rapporteert resultaten per batch en per informatieobject.

Deze resultaten vormen de technische terugkoppeling van de stekker aan de cockpit. De cockpit verwerkt deze resultaten in het vernietigingsdossier en gebruikt ze voor controle, verantwoording en de verklaring van vernietiging.

De stekker moet resultaten beschikbaar houden zolang dat nodig is voor processturing, herstart, audit en dossieropbouw.

## 6. Status vernietiging

`GET /vernietigingen/{vernietigingId}` geeft de status van één specifieke vernietiging.

De response bevat minimaal:

- `vernietigingId`
- `status` (`IDLE`, `RUNNING`, `COMPLETED`, `PARTIAL`, `FAILED`)
- aantal ontvangen batches
- aantal verwerkte batches
- totaal aantal batches, indien bekend
- aantal succesvol vernietigde informatieobjecten
- aantal informatieobjecten met foutresultaat
- aantal overgeslagen of niet gevonden informatieobjecten

### 6.1 Status betekenis

| Status | Betekenis |
|---|---|
| `IDLE` | De vernietiging is aangemaakt, maar verwerking is nog niet gestart. |
| `RUNNING` | De vernietiging wordt verwerkt of staat gepland voor verwerking. |
| `COMPLETED` | Alle aangeboden informatieobjecten zijn succesvol vernietigd (`SUCCESS`). |
| `PARTIAL` | De vernietiging is afgerond, maar één of meer informatieobjecten hebben een ander eindresultaat dan `SUCCESS`, zoals `FAILED`, `SKIPPED`, `NOT_FOUND` of `CHANGED`. |
| `FAILED` | De vernietiging als geheel is mislukt of kan niet betrouwbaar worden voortgezet. |

De status heeft altijd betrekking op één `vernietigingId`. Parallelle vernietigingen hebben ieder hun eigen status.

## 7. Objectresultaten

Per informatieobject wordt een uitvoeringsresultaat gerapporteerd.

De stekker rapporteert minimaal de volgende resultaten:

| Resultaat | Betekenis |
|---|---|
| `SUCCESS` | Het informatieobject is succesvol vernietigd. |
| `FAILED` | De vernietiging van het informatieobject is geprobeerd, maar mislukt. |
| `SKIPPED` | De vernietiging van het informatieobject is niet uitgevoerd. |
| `NOT_FOUND` | Het informatieobject is niet gevonden of bestaat niet meer. |
| `CHANGED` | Het informatieobject is sinds de selectie gewijzigd en is daarom niet vernietigd. |

### 7.1 Betekenis van `CHANGED`

`CHANGED` betekent dat het informatieobject niet is vernietigd.

De stekker gebruikt `CHANGED` wanneer het informatieobject tijdens de uitvoering niet meer overeenkomt met de informatie die in de selectie of vernietigingsopdracht is vastgelegd.

Dit kan bijvoorbeeld gebeuren wanneer:

- het informatieobject na selectie inhoudelijk is gewijzigd
- de status van het informatieobject na selectie is gewijzigd
- de bewaartermijn of vernietigbaarheid opnieuw moet worden beoordeeld
- identificerende kenmerken niet meer overeenkomen met de vrijgegeven selectie

In deze situaties mag de stekker het informatieobject niet stilzwijgend vernietigen. De stekker rapporteert `CHANGED`, zodat de cockpit het verschil tussen selectie, besluit en uitvoering zichtbaar kan maken in het vernietigingsdossier.

### 7.2 Resultaat per informatieobject

Een objectresultaat bevat minimaal:

- `recordId`
- `resultaat`
- eventueel een foutcode
- eventueel een foutmelding of toelichting
- eventueel een technisch correlatiekenmerk voor logging en herleidbaarheid

De stekker moet per aangeboden informatieobject precies één eindresultaat rapporteren.

### 7.3 Geen blokkade van het volledige proces

Een fout of afwijking bij één informatieobject blokkeert niet automatisch de verwerking van andere informatieobjecten binnen dezelfde vernietiging.

De stekker verwerkt de overige informatieobjecten zoveel mogelijk door en rapporteert afwijkingen per informatieobject.

## 8. Fouten en logging

### 8.1 Selectie

Bij selectie retourneert de stekker alleen informatieobjecten die als vernietigingskandidaat zijn bepaald.

Wanneer de stekker tijdens selectie fouten of onzekerheden tegenkomt, geldt:

- de fout wordt gelogd in de logging van de stekker
- de selectie-response bevat een algemene indicatie dat er fouten of waarschuwingen zijn opgetreden
- de stekker retourneert geen informatieobjecten waarvan niet betrouwbaar kan worden vastgesteld dat ze vernietigingskandidaat zijn
- de stekker mag onzekerheden of uitzonderingen niet stilzwijgend negeren

De selectie-response kan hiervoor bijvoorbeeld bevatten:

- `hasWarnings`
- `warningCount`
- `errorCount`
- `logReference`
- `warnings`

De exacte velden worden vastgelegd in de OpenAPI-specificatie.

Wanneer detailinformatie over selectiefouten nog niet via de API wordt ontsloten, moet de stekker minimaal een verwijzing naar de relevante logging of monitoring kunnen geven. Verdere ontsluiting van selectiefouten via de API is een aandachtspunt voor doorontwikkeling.

### 8.2 Vernietiging

Bij vernietiging rapporteert de stekker fouten per informatieobject.

Een foutresultaat bevat minimaal:

- `recordId`
- `resultaat`
- `foutcode`
- `foutmelding` of toelichting
- eventueel een `logReference` of correlatieId

De stekker moet foutcodes gebruiken die door de cockpit kunnen worden geregistreerd en verwerkt.

Foutcodes moeten:

- stabiel zijn binnen een major versie
- begrijpelijk zijn voor implementaties
- geschikt zijn voor rapportage en dossieropbouw
- waar mogelijk verwijzen naar een vastgelegde referentielijst

Voorbeelden van foutcategorieën zijn:

| Foutcategorie | Betekenis |
|---|---|
| `NOT_FOUND` | Het informatieobject is niet gevonden of bestaat niet meer. |
| `CHANGED` | Het informatieobject is gewijzigd sinds selectie en is niet vernietigd. |
| `VALIDATION_ERROR` | De aangeleverde gegevens zijn ongeldig of onvolledig. |
| `AUTHORIZATION_ERROR` | De stekker of bron staat de vernietiging niet toe. |
| `SOURCE_UNAVAILABLE` | Het bronsysteem is tijdelijk niet beschikbaar. |
| `TECHNICAL_ERROR` | Er is een technische fout opgetreden tijdens verwerking. |
| `UNKNOWN_ERROR` | De fout kan niet specifieker worden geclassificeerd. |

Technische fouten moeten worden gelogd. Fouten bij individuele informatieobjecten mogen niet leiden tot inconsistent gedrag of onduidelijke eindstatussen.

### 8.3 Logging en herleidbaarheid

De stekker moet logging vastleggen die voldoende is voor beheer, foutanalyse, audit en reproduceerbaarheid.

Logging bevat minimaal:

- tijdstip van request of verwerking
- `selectieId` of `vernietigingId`
- `batchNummer`, indien van toepassing
- `recordId`, indien van toepassing
- resultaat of foutcode
- technische foutdetails, indien van toepassing
- correlatieId of `logReference`

De logging van de stekker is ondersteunend aan de technische uitvoering. De cockpit verwerkt de formele uitvoeringsresultaten in het vernietigingsdossier.

Logging mag geen vervanging zijn voor het terugkoppelen van objectresultaten via de API.

## 9. Performance en schaalbaarheid

De stekker moet geschikt zijn voor verwerking van grote aantallen informatieobjecten.

Daarbij geldt:

- de stekker moet grote datasets gefaseerd kunnen verwerken
- de stekker moet paginering bij selectie ondersteunen
- de stekker moet batchverwerking bij vernietiging ondersteunen
- de stekker moet asynchrone verwerking ondersteunen waar dat nodig is
- de stekker mag interne optimalisaties toepassen, zoals caching, scheduling, throttling of wachtrijen
- optimalisaties mogen niet leiden tot verlies van herleidbaarheid, reproduceerbaarheid of controle

### 9.1 Impact op productiegebruik

Selectie en vernietiging mogen het normale productiegebruik van het bronsysteem niet onaanvaardbaar verstoren.

De stekker moet daarom rekening houden met:

- belasting van het bronsysteem
- piekbelasting tijdens kantoor- of productietijden
- beschikbare capaciteit van bron-API’s, databases of achterliggende services
- rate limits of andere technische beperkingen
- spreiding van verwerking in tijd
- veilige hervatting na onderbreking

Wanneer verwerking impact kan hebben op productiegebruik, moet de stekker maatregelen ondersteunen om deze impact te beperken. Denk aan throttling, scheduling buiten piekuren, batchgroottebeperking of pauzeren en hervatten van verwerking.

### 9.2 Parallelle verwerking

Parallelle selectie of vernietiging is toegestaan, zolang processen elkaar niet oncontroleerbaar beïnvloeden.

Daarbij geldt:

- parallelle processen moeten afzonderlijk herkenbaar zijn via hun eigen `selectieId` of `vernietigingId`
- parallelle processen mogen elkaars status, resultaten of logging niet overschrijven
- fouten in één proces mogen andere processen niet automatisch blokkeren
- de stekker moet voorkomen dat parallelle verwerking leidt tot dubbele vernietiging of onduidelijke objectresultaten
- bij overlap tussen processen wordt per informatieobject een duidelijk resultaat gerapporteerd, zoals `SUCCESS`, `NOT_FOUND`, `CHANGED`, `SKIPPED` of `FAILED`

### 9.3 Assessment en acceptatie

Bij implementatie moet aantoonbaar worden gemaakt dat de stekker voldoet aan de afgesproken eisen voor performance, schaalbaarheid en productie-impact.

Dit kan worden onderbouwd met:

- een technisch assessment
- een performance- of loadtest
- een ketentest met de cockpit
- afspraken over maximale batchgrootte en verwerkingssnelheid
- afspraken over verwerking binnen of buiten productietijden
- monitoring en logging tijdens verwerking

De uitkomsten van assessments en tests moeten worden vastgelegd voordat de stekker in productie wordt gebruikt.

### 9.4 Monitoring

De stekker moet inzicht geven in voortgang en belasting tijdens selectie en vernietiging.

Monitoring bevat minimaal inzicht in:

- lopende selecties en vernietigingen
- verwerkte batches
- aantal verwerkte informatieobjecten
- foutaantallen en foutcategorieën
- gemiddelde verwerkingstijd
- eventuele wachtrijen of vertragingen
- belasting of beperkingen vanuit het bronsysteem, voor zover beschikbaar

Monitoring is bedoeld voor beheer en operationele controle. De formele resultaten voor verantwoording worden via de API aan de cockpit teruggekoppeld.

## 10. Security

### 10.1 API-beveiliging

De Stekker API moet passend beveiligd zijn voor systeem-naar-systeemcommunicatie.

Daarbij geldt minimaal:

- communicatie verloopt via HTTPS
- authenticatie en autorisatie zijn verplicht
- de API ondersteunt OAuth2 of een gelijkwaardig passend beveiligingsmechanisme
- credentials, tokens en secrets worden veilig beheerd
- requests zijn herleidbaar tot een geautoriseerde client of systeemkoppeling

Aanbevolen OAuth2-flow:

- Client Credentials flow voor systeem-naar-systeemcommunicatie

### 10.2 Autorisatie

Toegang tot endpoints moet gebaseerd zijn op scopes, rollen of andere expliciete autorisatieregels.

Daarbij geldt:

- minimale rechten worden toegepast volgens het principe van least privilege
- selectie, vernietiging, statusopvraging en resultaatopvraging kunnen afzonderlijk worden geautoriseerd
- onbevoegde requests worden geweigerd
- autorisatiefouten worden gelogd
- autorisatie mag niet afhankelijk zijn van impliciete aannames in de client

De stekker mag alleen acties uitvoeren waarvoor de aanroepende client geautoriseerd is.

---

## 11. Versies en compatibiliteit

De Stekker API moet kunnen evolueren zonder bestaande processen onnodig te breken.

Daarbij geldt:

- uitbreidingen zijn bij voorkeur additief
- nieuwe velden zijn optioneel, tenzij een nieuwe major versie wordt geïntroduceerd
- bestaande verplichte velden mogen binnen dezelfde major versie niet worden verwijderd of van betekenis veranderen
- bestaande endpoints mogen binnen dezelfde major versie niet zonder migratiepad worden verwijderd
- foutcodes blijven stabiel binnen een major versie
- historische processen moeten reproduceerbaar blijven
- versie-informatie wordt vastgelegd in logging, resultaten en het vernietigingsdossier

### 11.1 Ondersteuning van bestaande versies

Een stekker moet bestaande ondersteunde versies gedurende een afgesproken periode blijven ondersteunen.

Als uitgangspunt geldt:

- de actuele versie wordt ondersteund
- maximaal twee eerdere ondersteunde versies blijven beschikbaar, tenzij anders overeengekomen
- het uitfaseren van een versie gebeurt alleen met een expliciet migratiepad
- breaking changes worden alleen doorgevoerd in een nieuwe major versie

De exacte ondersteuningsperiode en uitfaseringsafspraken worden per implementatie of beheerafspraak vastgelegd.

### 11.2 Major, minor en patch

Versies worden semantisch geïnterpreteerd:

| Versietype | Betekenis |
|---|---|
| Major | Bevat mogelijk breaking changes. |
| Minor | Bevat backward compatible uitbreidingen. |
| Patch | Bevat backward compatible correcties of verduidelijkingen. |

Binnen een bestaande major versie zijn wijzigingen alleen toegestaan wanneer bestaande clients daardoor blijven werken.

### 11.3 Optioneel als uitgangspunt

Nieuwe velden en uitbreidingen zijn standaard optioneel.

Dit betekent:

- bestaande clients hoeven nieuwe velden niet direct te verwerken
- nieuwe clients mogen nieuwe velden gebruiken als de stekker deze ondersteunt
- ontbrekende optionele velden mogen niet leiden tot foutieve interpretatie
- verplichte nieuwe functionaliteit wordt alleen geïntroduceerd via een expliciete versieafspraak

Optionele uitbreidingen mogen niet leiden tot onduidelijkheid over status, resultaten, foutcodes of auditinformatie.

## 12. Toekomstige uitbreidbaarheid

De Stekker API is ontworpen om uitbreidbaar te zijn zonder bestaande implementaties onnodig te breken.

Uitbreidingen moeten zoveel mogelijk additief zijn. Nieuwe velden, endpoints of functionaliteiten mogen bestaande clients niet verplichten tot directe aanpassing, tenzij hiervoor een nieuwe major versie wordt geïntroduceerd.

Mogelijke toekomstige uitbreidingen zijn:

- cursor-based paginering naast of ter vervanging van offset/limit-paginering
- eventnotificaties, bijvoorbeeld webhooks, naast polling
- uitgebreidere foutdetails bij selectie
- referentielijsten voor foutcodes en foutcategorieën
- aanvullende monitoring- en beheerinformatie
- uitgebreidere ondersteuning voor parallelle verwerking
- aanvullende metadata voor audit, herleidbaarheid en rapportage

Deze uitbreidingen mogen niet afdoen aan de kernprincipes van dit contract:

- selecties en vernietigingen blijven afzonderlijk adresseerbare resources
- processturing, herstart, audit en dossieropbouw gebruiken stabiele identificaties
- selectie en vernietiging blijven gescheiden van normatieve besluitvorming
- uitvoeringsresultaten worden per informatieobject teruggekoppeld
- backward compatibility blijft uitgangspunt binnen een major versie

## 13. Samenvattend principe

> De stekker bepaalt vernietigingskandidaten en voert vernietiging technisch uit.  
> De cockpit stuurt, beoordeelt, besluit en verantwoordt het proces.  
> De stekker rapporteert uitvoeringsresultaten per informatieobject terug.  
> De API blijft betrouwbaar en herleidbaar door selecties en vernietigingen als stabiel identificeerbare resources aan te bieden.