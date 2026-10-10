# ADR 0007 – Identiteit, snapshots en aggregaties

## Status
Voorgesteld (concept, nog vast te stellen)

## Datum
2026-10-09

## Context

In de uitwisseling tussen bron, stekker en cockpit komt hetzelfde informatieobject onder meerdere kenmerken voor:

| Plek | Voorbeeld | Wat het aanduidt |
|--------|--------|--------|
| Bron | `ZAAK-2020-00421`, technische sleutel `8f74…e501` | Het informatieobject zelf |
| Stekker | `selectieId` + `vernietigingskandidaatId` | Het object zoals het in één selectie is vastgelegd |
| Cockpit | Intern kandidaat-id | De beoordeling en het besluit over die kandidaat |

De documenten legden niet eenduidig vast hoe deze identiteiten zich tot elkaar verhouden:

- `vernietigingskandidaatId` heette "stabiel over het hele proces". Het was niet duidelijk of hetzelfde object in een volgende selectie hetzelfde id moet krijgen.
- ADR-0005 (B-M2) verbiedt kunstmatige groeperingen, maar zegt niet wanneer een samengestelde eenheid, zoals een zaak zonder fysieke map, wél een dossier is.
- De stekkerarchitectuur eist dat vernietiging plaatsvindt "op dezelfde set als geselecteerd". Er stond niet wat er gebeurt als een dossier, serie of archief tussen selectie en uitvoering onderdelen krijgt of verliest.

Deze ADR legt de vier ontwerpregels vast. Ze vult ADR-0001 en ADR-0005 aan en vervangt ze niet.

## Beslissing

### DR-01 Objectidentiteit

1. Het informatieobject wordt geïdentificeerd door de MDTO-`identificatie`: een of meer paren `identificatieKenmerk` + `identificatieBron`, met minimaal de technische sleutel in de bron.
2. Alleen deze identificatie zegt dat twee kandidaten hetzelfde object zijn, ook over selecties heen. Wil de cockpit tonen dat een object eerder kandidaat was, dan zoekt hij op `identificatie`.
3. De technische sleutel moet in de bron stabiel zijn zolang het object bestaat. Verandert hij, bijvoorbeeld bij een migratie, dan is het voor de keten een ander object.
4. Het interne kandidaat-id van de cockpit identificeert de beoordeling binnen één taakuitvoering. Het gaat nooit naar de stekker.

### DR-02 Snapshotidentiteit

1. Een `selectieId` verwijst naar precies één bevroren selectie. Vanaf `READY` verandert die niet meer (contract §3.1).
2. `vernietigingskandidaatId` is **uniek en stabiel binnen één selectie** en in de vernietigingen en resultaten die op die selectie gebaseerd zijn. Een kandidaat in een momentopname wordt dus aangeduid met `selectieId` + `vernietigingskandidaatId`.
3. Een stekker **mag** voor hetzelfde object in een volgende selectie hetzelfde `vernietigingskandidaatId` gebruiken. De cockpit geeft daar **geen betekenis** aan: elke selectie levert nieuwe kandidaten op, en elke kandidaat krijgt een eigen beoordeling. Een oordeel uit een eerdere selectie gaat nooit automatisch over.
4. Aan de cockpitkant geldt het besluit van de archivaris voor precies de lijst die bij het event *Bevriezing* is vastgelegd, met `lijstHash`. Wijkt de lijst bij de vernietigingsopdracht af, dan weigert de cockpit (409, `LIST_CHANGED`).

### DR-03 Aggregatie-identiteit

1. Een kandidaat met aggregatieniveau Archief, Serie of Dossier is alleen toegestaan als **de bron die eenheid zelf als eenheid beheert** en er een eigen kenmerk voor heeft. Voorbeelden: een zaak in een ZGW-zaaksysteem, een cliëntdossier of een serie in een ordeningsplan. Een fysieke map of container is niet nodig.
2. Een groepering die alleen in de selectielogica van de stekker bestaat, is kunstmatig en niet toegestaan (ADR-0005, B-M2). Voorbeeld: "alle meldingen van 2019 met categorie X".
3. De `identificatieBron` van een aggregatie is de bron of de nummering van de organisatie, **nooit de stekker**. Een kenmerk dat de stekker zelf verzint, maakt van een groepering geen dossier.

### DR-04 Uitvoeringsscope

1. De stekker legt bij selectie per kandidaat vast welke direct onderliggende informatieobjecten op dat moment bij de aggregatie horen. Dat blijft binnen de stekker; de API wisselt het niet uit.
2. Bij uitvoering vernietigt de stekker alleen de kandidaat als geheel, en alleen als die nog overeenkomt met de selectie.
3. Zijn er sinds de selectie **onderdelen bijgekomen of verdwenen**, dan meldt de stekker voor de **hele kandidaat** `CHANGED` en vernietigt hij **niets** van die kandidaat. Hetzelfde geldt voor de andere gevallen uit contract §7.1.
4. Bij `SUCCESS` bevat de specificatie een `bevatOnderdeel` voor precies de onderdelen uit de momentopname, niet meer en niet minder.
5. Een kandidaat met `CHANGED` kan alleen via een nieuwe selectie en een nieuwe beoordeling worden vernietigd.
6. `aantalObjecten` is het aantal **direct** onderliggende informatieobjecten in de momentopname, dus gelijk aan het aantal `bevatOnderdeel` in de specificatie. Dieper liggende niveaus tellen niet mee. Een archiefstuk heeft geen onderliggende informatieobjecten en dus `aantalObjecten` 0. `totaalObjecten` van een selectie of uitvoering is de som van `aantalObjecten` van de kandidaten (besloten 2026-10-10).
7. Tellen en specificeren eindigt bij het archiefstuk. Bestanden (MDTO `heeftRepresentatie` / `bestand`) worden niet geteld en niet in de specificatie opgenomen; er komt geen `aantalBestanden`. Ze worden wel vernietigd, samen met het informatieobject waartoe ze behoren (besloten 2026-10-10).

## Overwegingen

- **Eén begrip, één taak.** `identificatie` zegt welk object het is. `selectieId` + `vernietigingskandidaatId` zegt welke momentopname. Zo kan een oordeel niet per ongeluk meeschuiven naar een nieuwe selectie met andere metagegevens, bijvoorbeeld een herberekende bewaartermijn.
- **Weinig eisen aan leveranciers.** Een stekker hoeft geen blijvend register van ids bij te houden over selecties en jaren heen.
- **Geen half vernietigde dossiers.** MDTO definieert vernietigen als blijvend ontoegankelijk maken *met alle onderdelen*. Gedeeltelijk vernietigen past daar niet bij, en ook niet bij de betekenis van `SUCCESS`.
- **Geen vernietiging zonder beoordeling.** Onderdelen die na de selectie zijn bijgekomen, zijn niet beoordeeld en vallen niet onder het besluit.
- **Bestaande code.** De cockpit gebruikt `vernietigingskandidaatId` al alleen binnen een selectie (unieke sleutel op selectie + kandidaat-id). Het archiefpakket gebruikt om die reden het interne cockpit-id als bestandsnaam.

## Alternatieven

- **`vernietigingskandidaatId` stabiel over selecties heen.** Niet gekozen: het dupliceert `identificatie`, vraagt een blijvend register bij de stekker en maakt het mogelijk dat een oordeel uit een oudere momentopname wordt hergebruikt.
- **Een apart snapshot-id per kandidaat.** Niet gekozen: `selectieId` + `vernietigingskandidaatId` duidt de momentopname al eenduidig aan.
- **Bij gewijzigde onderdelen alleen de onderdelen uit de momentopname vernietigen.** Niet gekozen: dat laat een half dossier achter, strijdig met de MDTO-definitie van vernietigen.
- **Bij gewijzigde onderdelen alles vernietigen, ook de nieuwe onderdelen.** Niet gekozen: de nieuwe onderdelen zijn niet beoordeeld.
- **Het begrip "virtueel dossier" invoeren.** Niet gekozen: het lijkt de deur die B-M2 sluit weer te openen. De toets in DR-03 maakt hetzelfde onderscheid zonder nieuw begrip.

## Gevolgen

- **Informatiemodel en OpenAPI-spec:** de beschrijving van `vernietigingskandidaatId` wordt "uniek en stabiel binnen één selectie". Er verandert geen veld, type of verplichting; de versie blijft 2.0.0.
- **Contract en checklist:** §3 krijgt de toets uit DR-03, §4.3 en §7.1 de uitvoeringsscope uit DR-04, §5.3 de eis dat `bevatOnderdeel` gelijk is aan de momentopname. De checklist krijgt een acceptatiescenario voor gewijzigde onderdelen.
- **Stekkerarchitectuur:** de eis "vernietiging op dezelfde set als geselecteerd" geldt per kandidaat inclusief onderdelen.
- **Teststekker:** moet per kandidaat de onderdelen vastleggen bij selectie en `CHANGED` melden als ze bij uitvoering afwijken. Dat is nu nog niet zo.
- **Cockpit:** geen wijziging nodig voor DR-01 en DR-02. Door DR-04 punt 6 kan de cockpit het aantal `bevatOnderdeel` in de specificatie controleren tegen `aantalObjecten` van de kandidaat. Wat de cockpit bij een verschil doet, is nog niet besloten.
- **ADR-0001 en ADR-0005:** krijgen een notitie met een verwijzing naar deze ADR.
