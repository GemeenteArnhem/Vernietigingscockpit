# ADR 0008 – Selectielijstcodes en het register Cockpit-selectielijsten

## Status
Voorgesteld (concept, nog vast te stellen)

## Datum
2026-10-11

## Context

Een vernietigingskandidaat draagt een `informatiecategorie` (MDTO `begripGegevens`): de categorie uit de vastgestelde selectielijst waarop waardering en bewaartermijn gebaseerd zijn. MDTO beschouwt de selectielijst als begrippenlijst. Daarom verwijst `begripBegrippenlijst` (`verwijzingGegevens`) naar de selectielijst zelf (ADR-0005 §4).

In spec v2.0.0 is van die verwijzing alleen `verwijzingNaam` verplicht. `verwijzingIdentificatie` is optioneel, en wie hem invult, doet dat elk op een eigen manier:

| Plek | `identificatieKenmerk` | `identificatieBron` |
|--------|--------|--------|
| Voorbeeld in de OpenAPI-spec | `selectielijst-gemeenten-2020` | `Nationaal Archief` |
| Teststekker | `selectielijst-2020` | `Selectielijsten (teststekker)` |
| OpenZaak-stekker | – | – |

De cockpit slaat daarom alleen de naam op, als vrije tekst ("Selectielijst gemeenten en intergemeentelijke organen 2020"), en gebruikt die als kolom, filter en groepering. Dat heeft vier nadelen:

- de kolom en het filter in de beoordelings- en accorderingsschermen zijn zwaar en slecht te scannen;
- dezelfde lijst kan onder verschillende namen binnenkomen, zodat filteren en groeperen niet betrouwbaar is;
- de cockpit kan niet controleren of de kandidaat naar een werkelijk vastgestelde selectielijst verwijst;
- in de verklaring en het MDTO-archiefpakket staat geen eenduidige, herleidbare verwijzing naar de vaststelling.

Er bestaat geen landelijke identificatie per selectielijst. Het Nationaal Archief publiceert een *Overzicht vastgestelde BSD's en selectielijsten* (PDF, bijgewerkt tot en met 5 oktober 2026, 567 regels) met per lijst zorgdrager, titel, beschikking en Staatscourant-vindplaats. Daarvan is niets als identificatie bruikbaar:

- **Beschikkingskenmerk** (`NA/2020/21446242`): er pas sinds ongeveer 2009. Daarvoor gaat het om een datum of een kenmerk als `C/S&A/09/321`. Lijsten die bij Koninklijk Besluit zijn vastgesteld, hebben geen NA-kenmerk. En een BSD met meerdere zorgdragers heeft er één per zorgdrager (Universiteiten 2009: 13 beschikkingen).
- **Staatscourant-vindplaats**: vóór 2009 is het nummer een uitgavenummer. Meerdere lijsten delen dat nummer: Stcrt. 31-01-1997 nr. 22 bevat er vijf. Pas sinds 2009 is het een uniek documentnummer (`stcrt-2020-11143`).
- **Selectielijst-API** (VNG, gebruikt door ZGW/OpenZaak): kent procestypen met een jaartal, maar geen identificatie van de lijst.

## Beslissing

De cockpit voert een eigen, kort en permanent kenmerk per selectielijst in: de **selectielijstcode**. Een eigen begrippenlijst **Cockpit-selectielijsten** (`designrules/begrippenlijsten/cockpit-selectielijsten.md`) geeft de codes uit en houdt ze bij. De selectielijstcode is het `identificatieKenmerk` van de selectielijst in de MDTO-verwijzing.

### DR-SL-01 Formaat

1. Een selectielijstcode heeft de vorm `CODE-YYYY` of `CODE-YYYY.VV` en voldoet aan het patroon `^[A-Z][A-Z0-9]{1,11}-[0-9]{4}(\.[0-9]{2})?$`.
2. `CODE` is een afkorting van 2 tot en met 12 tekens: hoofdletters en cijfers, beginnend met een letter, zonder koppelteken. Het koppelteken scheidt alleen `CODE` en `YYYY`.
3. `YYYY` is een jaartal van vier cijfers.
4. `VV` is optioneel: een versienummer van twee cijfers, `01` tot en met `99`.

### DR-SL-02 Toekenning

1. **`CODE`** is een unieke afkorting van het **toepassingsgebied** of van de **zorgdrager**:
   - een lijst voor een categorie organisaties krijgt een code voor het toepassingsgebied, bijvoorbeeld `GEM` (gemeentelijke en intergemeentelijke organen), `GEMMAIL` (e-mailbewaring gemeenten), `PROV` (provinciale organen), `PROVCDK` (commissaris van de Koning als rijksorgaan), `WS` (waterschappen), `UNIV`, `UMC`, `HBO`, `RHC`;
   - een lijst voor één zorgdrager krijgt de afkorting uit de zorgdragerlijst van het NA-overzicht, of anders een gangbare afkorting, bijvoorbeeld `COA`, `RDW`, `BZK`, `VWS`;
   - een BSD van meerdere zorgdragers voor één beleidsterrein krijgt een code voor het beleidsterrein, bijvoorbeeld `WATERSTAAT`.
2. **`YYYY`** is het jaartal waarmee de lijst in haar titel bekendstaat, bijvoorbeeld *Selectielijst gemeenten en intergemeentelijke organen **2020***. Noemt de titel geen lijstjaar, dan is `YYYY` het jaar van de (eerste) publicatie in de Staatscourant. Jaartallen die een periode aanduiden (*vanaf 1945*, *1995–2001*) tellen niet.
3. **`.VV`** wordt alleen gebruikt bij een formele **wijziging** of aanvulling van een al gecodeerde lijst, met een eigen vaststelling en publicatie. De eerste wijziging krijgt `.01`, de volgende `.02`, enzovoort. De oorspronkelijke vaststelling heeft geen `.VV`. Een nieuwe lijst, ook een actualisatie die een eerdere lijst vervangt, krijgt een eigen code en geen versienummer.
4. Leidt de toekenning tot een code die al bestaat, dan wordt `CODE` verfijnd met een afkorting van het onderwerp. Is de code dan nog niet uniek, dan krijgt hij een volgletter (`A`, `B`, …). Dit wordt bij de regel in het register vermeld.

### DR-SL-03 Uniek en permanent

1. Een selectielijstcode komt in het register **precies één keer** voor en verwijst naar precies één vastgestelde selectielijst of één wijziging daarvan.
2. Een uitgegeven code wordt **nooit gewijzigd, verwijderd of hergebruikt**. Ook een ingetrokken of vervallen lijst houdt haar code. Een fout in titel of kenmerken wordt in het register hersteld zonder dat de code verandert.
3. Een code is uitgegeven zodra hij in een vastgestelde versie van het register staat. De eerste versie (1.0, 567 lijsten uit het NA-overzicht) is een **concept**: de codes worden permanent zodra deze ADR is vastgesteld.

### DR-SL-04 Register

1. Het register is de begrippenlijst Cockpit-selectielijsten (`urn:vernietigingscockpit:begrippenlijst:cockpit-selectielijsten:1.0`). Het is een **open** lijst, die werkt volgens de regels van `designrules/begrippenlijsten/README.md`.
2. Per code staan in het register: titel, zorgdrager, beschikkingskenmerk(en) en Staatscourant-vindplaats(en), zoals opgenomen in het NA-overzicht. Zo is elke code **herleidbaar** naar de officiële vaststelling. Leidend is de publicatie in de Staatscourant.
3. Het register bevat **alle** lijsten uit het NA-overzicht, dus ook historische BSD's en lijsten van rijksorganisaties. Een stekker hoeft dan nooit te wachten op een nieuwe code voor een bestaande lijst.
4. De Markdown-tabel is normatief. `cockpit-selectielijsten.json` is een machineleesbare kopie met dezelfde inhoud, die de cockpit gebruikt.
5. Wordt er een nieuwe lijst of wijziging vastgesteld, dan komt er na publicatie in de Staatscourant een regel bij, via een pull request op beide bestanden. Dat is een minor versie: 1.0 wordt 1.1.

### DR-SL-05 MDTO-koppeling

1. `informatiecategorie.begripBegrippenlijst` verwijst naar de vastgestelde selectielijst uit het register, als volgt:

   ```json
   {
     "begripLabel": "Handhaving",
     "begripCode": "11.1.2",
     "begripBegrippenlijst": {
       "verwijzingNaam": "Selectielijst gemeenten en intergemeentelijke organen 2020",
       "verwijzingIdentificatie": {
         "identificatieKenmerk": "GEM-2020",
         "identificatieBron": "Cockpit-selectielijsten"
       }
     }
   }
   ```

2. `verwijzingIdentificatie` is **verplicht**. `identificatieKenmerk` is de selectielijstcode (DR-SL-01). `identificatieBron` is altijd `Cockpit-selectielijsten`: dat is de lijst die het kenmerk uitgeeft. Het is dus niet het Nationaal Archief of de stekker (vergelijk ADR-0007, DR-03).
3. `verwijzingNaam` is de titel van de selectielijst, of de gangbare korte titel daarvan. De naam is informatief. Alleen de code identificeert de lijst.
4. `begripCode` en `begripLabel` blijven de codering en titel van de **categorie** binnen de selectielijst, bijvoorbeeld `11.1.2` *Handhaving*. Die categorieën nemen we niet op in het register.
5. Een afwijkende norm, zoals een hotspotlijst of specifieke wetgeving, gaat via `informatiecategorieAfwijking.norm`. Daarvoor is geen selectielijstcode nodig. `informatiecategorie` verwijst altijd naar een vastgestelde selectielijst.
6. Bij ZGW-bronnen leidt de stekker de code af uit de selectielijst van het procestype. Het jaartal van het procestype levert `GEM-2017` of `GEM-2020`.

### DR-SL-06 Gedrag van de cockpit

1. De cockpit slaat per kandidaat de selectielijstcode op, naast de naam zoals de stekker die leverde.
2. Ontbreekt `verwijzingIdentificatie`, of voldoet de code niet aan DR-SL-01, dan voldoet de kandidaat niet aan het contract. De cockpit behandelt dat als elke andere contractfout in de selectie.
3. Voldoet de code aan het formaat maar staat hij **niet in het register**, dan neemt de cockpit de kandidaat gewoon op, maar met een **waarschuwing**. Hij sluit de kandidaat niet uit en de selectie mislukt niet. Het register kan achterlopen op het NA-overzicht, en de recordmanager beoordeelt de kandidaat toch expliciet.
4. De schermen tonen in de kolom en het filter **Selectielijst** de code. De volledige titel, uit het register of anders de `verwijzingNaam` van de stekker, staat in de tooltip en in het detailpaneel.
5. De verklaring van vernietiging, de CSV-bijlage en de MDTO-XML van het archiefpakket nemen de code en de naam over (`verwijzingIdentificatie` en `verwijzingNaam`).

## Overwegingen

- **MDTO-conform.** MDTO voorziet in een `verwijzingIdentificatie` met `identificatieKenmerk` en `identificatieBron`. De code vult precies dat veld. Er komt geen nieuw attribuut bij.
- **Kort en leesbaar.** `GEM-2020` past in een smalle kolom en een filter. Een recordmanager herkent hem, een leverancier kan hem eenvoudig invullen.
- **Herleidbaar zonder afhankelijkheid.** Het register legt per code het beschikkingskenmerk en de Staatscourant-vindplaats vast. Zo is de code te controleren tegen de officiële bron, terwijl de cockpit niet afhankelijk wordt van kenmerken die vóór 2009 niet uniek of niet aanwezig zijn.
- **Volledig register.** Met alle 567 lijsten hoeft een stekker niet te wachten op een nieuwe code voor een bestaande lijst. Dat het register daarmee groot wordt, is acceptabel: het verandert zelden en wordt alleen aangevuld.
- **Een waarschuwing, geen blokkade.** Of een kandidaat vernietigd wordt, beslissen recordmanager, proceseigenaar en archivaris, niet een registercontrole. Een onbekende code vraagt om aandacht, maar is geen reden om te weigeren.
- **Leveranciersonafhankelijk.** De code is van het ecosysteem, niet van een stekker. Zo leveren stekkers voor verschillende bronnen dezelfde code voor dezelfde lijst.

## Alternatieven

- **Staatscourant-kenmerk als identificatie** (`stcrt-2020-11143`). Niet gekozen: vóór 2009 is het een uitgavenummer dat meerdere lijsten delen. Voor een kolom of filter is het bovendien niet leesbaar.
- **NA-beschikkingskenmerk als identificatie** (`NA/2020/21446242`). Niet gekozen: het ontbreekt bij oudere lijsten en bij KB-lijsten, een BSD kan er meerdere hebben en het is niet leesbaar.
- **Vrije tekst houden** (alleen `verwijzingNaam`). Niet gekozen: dat is het huidige probleem. De naam is niet eenduidig en niet toetsbaar.
- **Een URN zonder register** (`urn:selectielijst:gemeenten:2020`). Niet gekozen: zonder register is uniciteit niet te bewaken en is niet vastgelegd waar een code naar verwijst.
- **Alleen de lijsten die nu relevant zijn** (gemeenten, provincies, waterschappen). Niet gekozen: elke nieuwe stekker voor een andere organisatie moet dan eerst wachten op een registerwijziging.
- **`.VV` altijd gebruiken** (`GEM-2020.01` voor de eerste vaststelling). Niet gekozen: dan kunnen `GEM-2020` en `GEM-2020.01` naast elkaar voor dezelfde lijst ontstaan, en dat ondermijnt de uniciteit.
- **De onbekende kandidaat uitsluiten, of de selectie laten mislukken.** Niet gekozen: een achterlopend register zou het vernietigingsproces blokkeren, terwijl de beoordeling toch expliciet is.

## Gevolgen

**Architectuur en documenten** (architectuurrepo):
- nieuw: `designrules/begrippenlijsten/cockpit-selectielijsten.md` (normatief) en `cockpit-selectielijsten.json`, en een regel in `designrules/begrippenlijsten/README.md`;
- `designrules/api/stekker-openapi-spec.yaml`: een eigen schema `Selectielijstverwijzing` met verplichte `verwijzingIdentificatie`, patroon en vaste `identificatieBron`, en het voorbeeld met `GEM-2020`. Velden worden niet hernoemd. Omdat er nog geen productiestekkers zijn (ADR-0005), blijft de versie 2.0.0;
- `api-informatiemodel.md`, `api-informatiemodel-mim.md`, `stekker-openapi-contract.md`, `stekker-api-implementatiechecklist.md`, `stekker-leveranciersinstructie-bronadapter-selectielogica.md`, `stekker-api-faq.md`, `architectuur/terminologie.md` en `ui-spec/api-mapping/api-contract.md` volgen DR-SL-05;
- ADR-0005 krijgt een notitie met een verwijzing naar deze ADR.

**Stekkers:**
- teststekker: levert in plaats van `selectielijst-<jaar>` voortaan `GEM-2012` / `GEM-2020` met bron `Cockpit-selectielijsten`;
- OpenZaak-stekker: leidt de code af uit `procestype.jaar` (DR-SL-05 punt 6) en vult `verwijzingIdentificatie`.

**Cockpit:**
- het register wordt als data opgenomen, gegenereerd uit `cockpit-selectielijsten.json`, met een controle in CI op gelijkheid met de architectuurrepo;
- de kandidaat krijgt een kolom voor de selectielijstcode. Filter, facet en sortering werken op de code. Een onbekende code levert een waarschuwing bij de import;
- `packages/api-contract` krijgt code en naam. De UI toont de code in de kolom en het filter, met de titel als tooltip en in het detailpaneel (UI-wijziging goedgekeurd 2026-10-11);
- de verklaring, de CSV en de MDTO-XML nemen de code op.

**Beheer en governance:**
- het register wordt beheerd als onderdeel van de architectuur. Bij elke nieuwe versie van het NA-overzicht worden de nieuwe lijsten toegevoegd;
- vóór vaststelling van deze ADR worden de conceptcodes beoordeeld, in elk geval de codes met een volgletter.

**Risico's en aandachtspunten:**
- de titels en kenmerken in versie 1.0 zijn automatisch overgenomen uit de PDF en kunnen kleine opmaakfouten bevatten. Aan de code verandert dat niets (DR-SL-03 punt 2);
- een lijst die in de praktijk onder een ander jaartal bekendstaat dan haar Staatscourant-jaar, bijvoorbeeld de waterschapslijst "vanaf 2012" die in 2011 is gepubliceerd (`WS-2011`), is alleen via het register te vinden. Dat is bewust: de code wordt opgezocht, niet geraden.
