# ADR 0006 – Verwijderen van de werkkopie van een vernietigingsdossier

## Status
Voorgesteld (concept, nog vast te stellen)

## Datum
2026-10-08

## Context

ADR-0005 (B-M5) bepaalt dat het vernietigingsdossier en al zijn onderdelen de waardering **B – Blijvend te bewaren** krijgen. Het dossier wordt bij de overgang `resultaat → archief` gearchiveerd als MDTO-pakket (ADR-0005 §7).

Daarna bestaat het dossier twee keer:

1. het **gearchiveerde exemplaar** in het archief- of zaaksysteem: het blijvend te bewaren archiefbescheid;
2. de **werkkopie** in de cockpitdatabase: taakinstantie, selecties, kandidaten (inclusief de ruwe stekkerpayload `bron`), besluiten, uitvoeringen, batches, resultaten, verklaringen (PDF- en CSV-bytes), archiveringen, outbox en het auditlog.

De werkkopie staat nu onbeperkt in de database. De bescherming uit ADR-0003 en de kandidaat-besluitmigratie maakt `audit_event`, `configuratie_event` en `kandidaat_besluit` append-only:
- triggers weigeren `UPDATE`, `DELETE` en `TRUNCATE`;
- de app-rol heeft daar alleen `SELECT` en `INSERT`.

Er is dus geen pad om de werkkopie op te ruimen. Dat is strijdig met:
- `security-en-privacy.md` §7.3: dossiers mogen niet langer worden bewaard dan noodzakelijk; dossiervernietiging hoort bij het ontwerp;
- de AVG: dataminimalisatie en opslagbeperking. Kandidaten bevatten namen en identificaties van informatieobjecten, die na archivering in de cockpit geen doel meer dienen.

## Beslissing

### 1. Begrip

- **Werkkopie**: alle gegevens in de cockpitdatabase die bij één taakinstantie horen.
- **Verwijderen van de werkkopie** is **geen** vernietiging in de zin van de Archiefwet of MDTO (`Vernietigen`). Het archiefbescheid blijft in het archiefsysteem bestaan. Het verwijderen wordt daarom niet als `Vernietigen` vastgelegd, maar als het eigen eventtype **Werkkopie verwijderd** (lijst Cockpit-configuratie-eventtypen, ADR-0005 §5).

Buiten deze ADR vallen de taakdefinitie, stamgegevens, stekkers en stekkerconfiguraties, gebruikers en `configuratie_event`. Die horen niet bij één dossier.

### 2. Voorwaarden

Een werkkopie wordt alleen verwijderd als **alle** onderstaande voorwaarden gelden. De database controleert ze zelf (§4), niet alleen de applicatie.

1. De taakinstantie heeft status `archief`.
2. Er is een archivering met status `SUCCESS`, via welke archiefadapter dan ook. De bestandsadapter telt ook.
3. **Het gearchiveerde pakket is direct voor het verwijderen opnieuw geverifieerd**:
   - de adapter leest `dossier.mdto.xml` en alle bestanden terug;
   - de SHA-256 van `dossier.mdto.xml` komt overeen met `archivering.dossier_sha256`;
   - de checksum van elk bestand komt overeen met zijn MDTO-bestandsbeschrijving, en die van `kandidaten/` en `specificaties/` met de CSV-bijlage (ADR-0005 §7).

   Mislukt de verificatie, dan wordt er niet verwijderd en wordt *Verificatie archief mislukt* vastgelegd.
4. De **bewaartermijn van de werkkopie** is verstreken, gerekend vanaf `archivering.afgerond_op`. Die termijn is per organisatie instelbaar, met als standaard **12 maanden** (`WERKKOPIE_BEWAARTERMIJN`, ISO 8601-duur, standaard `P12M`). Een termijn van `P0D` mag. Wijzigingen van de instelling worden gelogd als configuratie-event.
5. De auditketen van de taak is intact (`/auditlog/verificatie` geeft `intact = true`).

### 3. Uitvoering: volledig automatisch

- Een periodieke job in de worker (outbox-queue `opschoning`, standaard dagelijks) zoekt taakinstanties die aan voorwaarden 1, 2, 4 en 5 voldoen. Per taak voert hij de verificatie (3) uit en daarna het verwijderen.
- Er is **geen menselijk besluit** per verwijdering. Dit is een operationele beheerhandeling op een kopie, geen normatief besluit over archiefbescheiden: het normatieve besluit (waardering B en archivering) is al genomen en vastgelegd. De termijn is het besluit; hij is configuratie en wordt gelogd.
- Verwijderen gebeurt per taak in **één transactie**. Lukt het niet, dan blijft alles staan en probeert de job het later opnieuw (retrybeleid zoals bij andere worker-jobs).

### 4. Databasebescherming

- De app-rol (`cockpit_app`) houdt op `audit_event` en `kandidaat_besluit` alleen `SELECT` en `INSERT`. Hij kan dus zelf niet verwijderen.
- Verwijderen kan alleen via de functie `verwijder_werkkopie(taakinstantie_id uuid, verificatie jsonb)`. Die functie:
  - is `SECURITY DEFINER` en eigendom van de migratie-eigenaar;
  - heeft `EXECUTE` alleen voor de app-rol;
  - controleert in SQL de voorwaarden 1, 2, 4 en 5 en of er een verificatieresultaat is meegegeven;
  - schrijft eerst de grafsteen (§5) en het configuratie-event;
  - zet daarna de transactievariabele `cockpit.werkkopie_verwijderen = <taakinstantie_id>`;
  - verwijdert vervolgens alle rijen van die taak, in FK-volgorde.
- De append-only-triggers staan `DELETE` alleen toe als die variabele gelijk is aan de `taakinstantie_id` van de rij. `UPDATE` blijft altijd geweigerd. `TRUNCATE` blijft altijd geweigerd, ook voor de eigenaar.
- Voor `configuratie_event` en de nieuwe tabel `dossier_grafsteen` blijft verwijderen volledig onmogelijk.

### 5. Grafsteen

Per verwijderde werkkopie komt er één rij in de insert-only tabel `dossier_grafsteen`, met eigen hashketen (globaal, net als `configuratie_event`). De rij bevat:

| Veld | Inhoud |
|---|---|
| `taakinstantie_id` | identificatie van het dossier (= het `identificatieKenmerk` in het MDTO-pakket) |
| `taakdefinitie_id` | herkomst |
| `archiefvormer` | MDTO-verwijzing (ADR-0005, B-M3) |
| `archivering_id`, `archief_adapter`, `archief_locatie`, `openzaak_zaak_id` | waar het blijvende exemplaar staat |
| `dossier_sha256` | integriteit van het pakket (SHA-256 van `dossier.mdto.xml`) |
| `verificatie` | resultaat van de laatste verificatie (tijdstip, aantal bestanden, uitkomst) |
| `audit_aantal_events`, `audit_laatste_hash` | sluitstuk van de auditketen van de taak. Dit maakt het gearchiveerde `auditlog` controleerbaar. |
| `lijst_hash`, `verklaring_pdf_sha256`, `verklaring_versie` | integriteit van de vrijgegeven lijst en de verklaring |
| `afgerond_op`, `gearchiveerd_op`, `verwijderd_op` | tijdlijn |
| `bewaartermijn_werkkopie` | de toegepaste termijn |
| `vorige_hash`, `hash` | keten |

De grafsteen bevat **geen** persoonsgegevens en geen kandidaatgegevens. De taaknaam staat er ook niet in, omdat die soms een naam bevat. De grafsteen wordt nooit verwijderd.

Tegelijk schrijft de functie in `configuratie_event`:
- `event_type` *Werkkopie verwijderd*;
- actor = systeem;
- `entiteit_type` taakinstantie;
- in de details de grafsteen-id en `audit_laatste_hash`.

### 6. Controleerbaarheid na verwijderen

- `GET /dossiers/{taakinstantieId}` geeft na verwijdering de grafsteen terug (status `werkkopie_verwijderd`) in plaats van 404. Daarmee blijft voor de auditor zichtbaar dat er een dossier was en waar het staat. De zichtbaarheid volgt de regels van het auditlog: betrokkenen en auditor; anderen krijgen 404.
- Een auditor kan het gearchiveerde `auditlog` (MDTO-pakket) onafhankelijk verifiëren. Hij herberekent de keten en vergelijkt het resultaat met `audit_laatste_hash` en `audit_aantal_events` van de grafsteen. De grafsteenketen zelf is te verifiëren via `GET /dossiers/grafstenen/verificatie`.
- Lijsten en overzichten tonen dossiers met een verwijderde werkkopie niet meer. Wel blijft vindbaar dat er een volgende cyclus is gepland.

### 7. Wat er niet gebeurt

- Er worden niet direct na archivering gegevens geschoond. Alles blijft staan tot de termijn verstreken is en gaat dan in één keer weg.
- Het gearchiveerde exemplaar wordt nooit door de cockpit gewijzigd of verwijderd.
- Back-ups van de database vallen buiten deze functie. Het beheerbeleid moet een **bewaartermijn voor back-ups** vastleggen, zodat verwijderde werkkopieën ook daaruit verdwijnen (zie Gevolgen).

## Overwegingen

- **AVG.** Opslagbeperking en dataminimalisatie: na archivering is de cockpit niet meer de plek waar het dossier nodig is.
- **Archiefwet.** Het blijvend te bewaren exemplaar staat in het archiefsysteem. De werkkopie verwijderen tast het archiefbescheid niet aan, mits zeker is dat het archief compleet en integer is. Daarom is hercontrole vlak vóór het verwijderen verplicht, en niet alleen het vertrouwen op de oorspronkelijke archivering.
- **Volledig automatisch** is gekozen boven accordering per verwijdering. De handeling is niet normatief, en de risico's zitten in de techniek (is het archief compleet?). Die worden technisch afgedekt met de verificatie, de databasecontroles en de grafsteen.
- **Elke archiefadapter telt**, ook de bestandsadapter. Daardoor hangt de veiligheid volledig af van het beheer van de archieflocatie (zie Risico's).
- **Grafsteen in plaats van niets.** Zonder sluitstuk is achteraf niet aan te tonen dat het gearchiveerde auditlog volledig en ongewijzigd is. Met `audit_laatste_hash` wel.
- **De database dwingt af.** Een fout of misbruik in de applicatie mag geen dossier kunnen verwijderen dat niet aan de voorwaarden voldoet. Dat past bij ADR-0003 §3.

## Alternatieven

- **Accordering door de archivaris per lijst.** Niet gekozen (besluit 2026-10-08). Dat geeft extra menselijke controle, maar het verwijderen is geen normatief besluit.
- **Alleen verwijderen bij een aangewezen archiefsysteem of OpenZaak.** Niet gekozen (besluit 2026-10-08). Het risico van de bestandsadapter wordt in het beheer belegd.
- **Pseudonimiseren in plaats van verwijderen.** Verworpen: dat breekt de hashketen, tenzij de keten vooraf over gehashte waarden loopt. Bovendien blijft er dan nog steeds een overbodige kopie staan.
- **Direct na archivering verwijderen.** Mogelijk door de termijn op `P0D` te zetten. Als standaard niet gekozen, zodat vragen kort na vernietiging in de cockpit te beantwoorden blijven.
- **Nooit verwijderen.** Verworpen: strijdig met de AVG en met `security-en-privacy.md` §7.3.

## Gevolgen

**Architectuur en documenten:**
- `architectuur-cockpit.md` §5.5 en §5.9: het dossier kent twee exemplaren (archief en werkkopie) en een levenscyclus van de werkkopie.
- `architectuur-techniek.md` §7: de tabel `dossier_grafsteen`, de functie `verwijder_werkkopie`, de job `opschoning`.
- `security-en-privacy.md` §7.3: de verwijzing naar deze ADR, en de eis dat het beheer een bewaartermijn voor back-ups vastlegt.
- ADR-0003 §3: `DELETE` op `audit_event` en `kandidaat_besluit` wordt uitsluitend toegestaan via `verwijder_werkkopie`.
- ADR-0005 §5: *Werkkopie verwijderd* en *Verificatie archief mislukt* komen in de lijst Cockpit-configuratie-eventtypen.
- `ui-spec`: geen schermwijziging. Overzichten tonen verwijderde werkkopieën niet.

**Implementatie (cockpit):**
- `ArchiefAdapter` krijgt een methode `verifieer(locatie, dossierSha256)`. De bestandsadapter leest het pakket terug en controleert de checksums; de OpenZaak-adapter doet hetzelfde via de Documenten-API.
- Migratie: de tabel `dossier_grafsteen` (insert-only, eigen keten, triggers), de functie `verwijder_werkkopie`, aangepaste triggers op `audit_event` en `kandidaat_besluit`, en `EXECUTE`-rechten.
- Worker-job `opschoning` met claim en lease zoals bij andere jobs, configuratie `WERKKOPIE_BEWAARTERMIJN` en `OPSCHONING_INTERVAL`.
- Tests:
  - integratie: voorwaarden, het weigeren van directe `DELETE` door de app-rol, het weigeren bij mislukte verificatie, de grafsteenketen;
  - E2E: een dossier met termijn `P0D` wordt na archivering opgeruimd en de grafsteen is opvraagbaar.

**Beheer en governance:**
- De archieflocatie van de bestandsadapter moet buiten de cockpit worden beheerd en geback-upt, als een aangewezen archieflocatie. Anders is na het verwijderen het pakket op het volume het enige exemplaar.
- De organisatie stelt de termijn voor de werkkopie vast en registreert hem in het verwerkingsregister.
- Het back-upbeleid van de cockpitdatabase krijgt een maximale bewaartermijn.

**Risico's en aandachtspunten:**
- **Bestandsadapter als enige exemplaar.** Een defect of verlies van het volume na het verwijderen betekent dat het blijvend te bewaren dossier verloren gaat. De hercontrole voorkomt alleen verwijderen bij een *al* defect pakket. Mitigatie zit in het beheer: back-up en aanwijzing van de locatie.
- **Geen uitstel per dossier.** Er komt geen juridische bevriezing van de werkkopie (besluit 2026-10-08). Een Woo-verzoek, bezwaar of geschil wordt vóór de vernietiging afgehandeld door de betreffende kandidaten **uit te sluiten** in de beoordeling. Na archivering staat het volledige dossier in het archiefsysteem; de werkkopie is daarvoor niet nodig.
- **Klokken en termijnen.** De termijn wordt in de database berekend (`now()` van de database), niet door de worker.
