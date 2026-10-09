# Begrippenlijst – Vernietigingscockpit ecosysteem

Deze begrippenlijst definieert de kernbegrippen die in de architectuurdocumentatie worden gebruikt.
De definities zijn normerend bedoeld, om een eenduidig begrip te waarborgen binnen ontwerp, ontwikkeling en gebruik.

**MDTO is leidend** (ADR-0005). Voor begrippen die MDTO kent, geldt de MDTO-definitie (MDTO 1.0 / MDTO-XML 1.0.1, Nationaal Archief). Ze zijn hieronder gemarkeerd met *(MDTO)*. Eigen begrippen zijn in MDTO-termen gedefinieerd. Waarden van begripvelden komen uit de MDTO-begrippenlijsten of uit de eigen begrippenlijsten in `designrules/begrippenlijsten/`.

De begrippen zijn alfabetisch geordend.

---

## Accordering
Het expliciet goedkeuren van de vernietigingslijst of een vernietigingskandidaat door een bevoegde rol (proceseigenaar of archivaris).
Accordering vindt plaats als onderdeel van de workflow en is een normatieve handeling.
Accordering wordt vastgelegd als event *Accordering* (MDTO EventTypeLijst) en maakt deel uit van het vernietigingsdossier.

---

## Aggregatieniveau *(MDTO)*
Het aggregatieniveau van het informatieobject.
Waarden uit de MDTO-lijst Aggregatieniveaus: **Archief**, **Serie**, **Dossier**, **Archiefstuk**.
In dit ecosysteem zijn uitsluitend deze waarden toegestaan; eigen aggregatieniveaus bestaan niet (ADR-0005, B-M2).

---

## Archiefvormer *(MDTO)*
De organisatie die verantwoordelijk is voor het opmaken en/of ontvangen van het informatieobject.
In de cockpit staat de archiefvormer op het profiel van de proceseigenaar en wordt hij vastgepind op elke taakuitvoering. Een stekker mag per vernietigingskandidaat een afwijkende archiefvormer meegeven (ADR-0005, B-M3).

---

## Auditlog
De onveranderbare en juridisch relevante vastlegging van gebeurtenissen, besluiten en acties binnen het vernietigingsproces.
Het auditlog maakt onderdeel uit van het vernietigingsdossier en is leidend voor verantwoording.
Het type van elke gebeurtenis is een begrip uit de MDTO EventTypeLijst of, waar MDTO geen begrip heeft, uit de lijst Cockpit-eventtypen.

- het auditlog is altijd gekoppeld aan een taakinstantie
- er is geen globaal auditlog in de UI
- het auditlog is zichtbaar binnen taak-detail

Configuratiewijzigingen worden in een apart, even onveranderbaar configuratielog vastgelegd (Cockpit-configuratie-eventtypen).

---

## Begrippenlijst *(MDTO)*
Een gecontroleerde lijst van begrippen (label, optionele code, definitie) waaruit de waarde van een begripveld komt.
Een **gesloten** lijst mag niet worden uitgebreid; een **open** lijst wel, via een eigen gepubliceerde begrippenlijst met naam, identificatie en versie.

---

## Besluitvorming
Het nemen van normatieve besluiten over selectie en vernietiging.
Besluitvorming vindt plaats in de Vernietigingscockpit, door mensen, ondersteund door het systeem.
Besluitvorming is te onderscheiden van technische uitvoering.

---

## Bestand *(MDTO)*
Een geordende verzameling van gegevens in elektronische vorm, die door een elektronisch apparaat onder één naam kan worden behandeld en aangesproken.
Een bestand is een representatie van een informatieobject (`isRepresentatieVan`) en heeft verplicht een omvang, een bestandsformaat en een checksum.
Een bestand is geen informatieobject: bij vernietiging van een informatieobject worden ook al zijn bestanden vernietigd.

---

## Bewaartermijn *(MDTO)*
Termijn waarin het informatieobject bewaard dient te worden, zoals gespecificeerd in de van toepassing zijnde en vastgestelde selectielijst.
Een bewaartermijn bestaat uit:
- **termijnTriggerStartLooptijd**: de gebeurtenis waarna de looptijd start
- **termijnStartdatumLooptijd**: de datum waarop die gebeurtenis plaatsvond
- **termijnLooptijd**: de looptijd (ISO 8601-duur, bijv. `P5Y`)
- **termijnEinddatum**: de datum waarop de termijn eindigt; voor een vernietigingskandidaat de datum waarop vernietiging mag plaatsvinden

De stekker berekent de bewaartermijn; de cockpit legt hem volledig vast, zodat hij zonder interpretatie te controleren is.

---

## Bronsysteem
Een applicatie of systeem waarin informatieobjecten daadwerkelijk zijn opgeslagen.
Het bronsysteem is systeem van record.
Fysieke vernietiging vindt plaats in het bronsysteem, aangestuurd via een stekker.

---

## Cockpit
Zie Vernietigingscockpit.

---

## Dossier (vernietigingsdossier)
Het samenhangende geheel van informatie dat één vernietigingsproces (één taakinstantie) beschrijft en verantwoordt.
In MDTO-termen is het een informatieobject met aggregatieniveau **Dossier**, met als onderdelen (`bevatOnderdeel`):
- de vernietigingslijst
- de besluiten (beoordeling, accorderingen, uitsluitingen met toelichting)
- de uitvoeringsresultaten
- de verklaring van vernietiging
- het auditlog

Het dossier vormt het juridische en organisatorische bewijs. Het krijgt vast de waardering **B – Blijvend te bewaren** (ADR-0005, B-M5) en wordt gearchiveerd als MDTO-pakket.
Na archivering bestaat het blijvende exemplaar in het archiefsysteem; de cockpit houdt een werkkopie (zie Werkkopie).

---

## Event *(MDTO)*
Gebeurtenis die heeft plaatsgevonden met betrekking tot het ontstaan, wijzigen, vernietigen en beheer van het informatieobject en de bijbehorende metagegevens.
Een event heeft een eventType (begrip), eventTijd, eventVerantwoordelijkeActor en eventResultaat.

---

## Executor
Het onderdeel van een stekker dat de daadwerkelijke technische vernietiging uitvoert.
De executor werkt idempotent en rapporteert per vernietigingskandidaat een uitvoeringsresultaat terug.

---

## Functiescheiding
Het principe dat verschillende stappen in het proces door verschillende rollen worden uitgevoerd.
Functiescheiding voorkomt belangenverstrengeling en is een essentieel compliance-principe.

---

## Grafsteen
Het minimale, onveranderbare record dat achterblijft nadat de werkkopie van een vernietigingsdossier uit de cockpit is verwijderd (ADR-0006).
Het bevat geen persoonsgegevens, alleen de verwijzing naar het gearchiveerde exemplaar en de integriteitsgegevens (dossier-hash, laatste hash van het auditlog).

---

## Idempotentie
De eigenschap dat een actie meerdere keren kan worden uitgevoerd zonder extra effect op de gegevens.
Herhaalde aanroepen kunnen wel afzonderlijk worden vastgelegd in logging en audit.
In de context van vernietiging betekent dit dat dubbele aanroepen niet leiden tot dubbele vernietiging.

---

## Identificatie *(MDTO)*
Gegevens waarmee het object geïdentificeerd kan worden: altijd het paar **identificatieKenmerk** (het kenmerk) en **identificatieBron** (de herkomst waarbinnen het kenmerk uniek is).
Een informatieobject kan meerdere identificaties hebben, bijvoorbeeld de technische sleutel in de bronapplicatie en het zaaknummer.

---

## Informatiecategorie *(MDTO)*
De informatiecategorie uit een vastgestelde selectielijst of hotspotlijst waar de bewaartermijn op gebaseerd is.
MDTO beschouwt een selectielijst als begrippenlijst: de code van het begrip is de codering in de selectielijst, het label de titel. De verwijzing naar de selectielijst bevat de identificatie en versie van de lijst.

---

## Informatieobject *(MDTO)*
Een op zichzelf staand geheel van gegevens met een eigen identiteit.
Een informatieobject kan bijvoorbeeld een archief, serie, dossier, zaak of document zijn; het aggregatieniveau legt vast welke.
Een informatieobject heeft in MDTO verplicht een identificatie, naam, waardering, archiefvormer en beperking gebruik.
Informatieobjecten worden beheerd in het bronsysteem. Tussen cockpit en stekker worden ze uitgewisseld als vernietigingskandidaat.

---

## Landelijke Selectielijst (LSL) / selectielijst
De normatieve, vastgestelde set van informatiecategorieën met waardering en bewaartermijn, zoals de Selectielijst gemeenten en intergemeentelijke organen.
Selectielijstregels zijn abstract en normatief.
De operationele toepassing van de selectielijst vindt plaats binnen de stekker. Het resultaat wordt in MDTO-termen geleverd (informatiecategorie, waardering, bewaartermijn).

---

## Logging
Technische registratie van systeemgebeurtenissen ten behoeve van monitoring, foutanalyse en beheer.
Logging is niet normatief, kan tijdelijk zijn en maakt geen onderdeel uit van het vernietigingsdossier.

---

## MDTO
Metagegevens voor duurzaam toegankelijke overheidsinformatie: de standaard van het Nationaal Archief voor het vastleggen en uitwisselen van metagegevens van informatieobjecten.
MDTO is in dit ecosysteem leidend voor benaming, begrippen en informatiemodel (ADR-0005). Referentieversie: MDTO 1.0 / MDTO-XML 1.0.1.

---

## Naam *(MDTO)*
Een betekenisvolle aanduiding waaronder het object bekend is, bijvoorbeeld de titel van een dossier.
Een kenmerk zoals een zaaknummer is geen naam maar een identificatie.

---

## Normatief
Alles wat betrekking heeft op regels, kaders en besluiten.
Normatief betreft de vraag wat mag en moet.
Normatieve handelingen worden door mensen uitgevoerd en vastgelegd.

---

## Operationeel
Alles wat betrekking heeft op technische uitvoering.
Operationeel betreft de vraag hoe iets concreet wordt uitgevoerd.
Operationele logica bevindt zich in stekkers en ondersteunende componenten.

---

## Proceseigenaar
Een rol die verantwoordelijk is voor het proces waarin de informatie is ontstaan.
De proceseigenaar levert een inhoudelijke controle en accordering als onderdeel van de workflow.

---

## Recordmanager
De primaire gebruiker van de Vernietigingscockpit.
De recordmanager beheert taken, beoordeelt vernietigingslijsten en bewaakt het proces.

---

## Scheduler
Een mechanisme dat periodieke processen start.
Bijvoorbeeld het automatisch klaarzetten van de volgende cyclus van een taak, of het opruimen van werkkopieën.

---

## Selectie
Een bevroren verzameling vernietigingskandidaten die een stekker op een peildatum heeft bepaald.
Bij gereedmelding (`READY`) verandert de selectie niet meer. In de cockpit leidt het importeren tot het event *Import* en het bevriezen van de lijst bij vrijgave tot *Bevriezing*.

---

## Sjabloon
Een herbruikbare definitie voor taken (taakdefinitie).
Sjablonen bevatten instellingen zoals archiefvormer, bronnen (stekkers), frequentie en workflow.
Ze zorgen voor standaardisatie en herhaalbaarheid.

---

## Stekker
Een generiek, herbruikbaar component dat fungeert als schakel tussen cockpit en bron.
De stekker:
- bepaalt vernietigingskandidaten (via selectie) en levert hun MDTO-metagegevens
- voert vernietiging technisch uit
- bevat bron- en domeinspecifieke logica
- exposeert een uniform contract

---

## Taak
Een gedefinieerde vernietigingscyclus binnen de cockpit (taakinstantie, op basis van een taakdefinitie).
Een taak beschrijft scope, stekkers en planning en bevat één vernietigingslijst per cyclus.
- vertegenwoordigt een domein of context (bijv. Zorgdomein)
- kan meerdere stekkers (bronnen) bevatten
- heeft één vernietigingsdossier

Taken doorlopen de workflow:
- beoordeling
- accordering
- uitvoering
- resultaat
- archief

---

## Uitsluiting
Het normatieve besluit van de recordmanager dat een vernietigingskandidaat niet wordt vernietigd, met een uitsluitreden (lijst Cockpit-uitsluitredenen) en een toelichting.
Een lopend Woo-verzoek, AVG-verzoek, bezwaar of geschil leidt tot uitsluiting (*Lopend verzoek of procedure*).
De cockpit sluit automatisch uit bij een waardering anders dan V (*Waardering niet V*).

---

## Uitvoeringsresultaat
Het resultaat dat een stekker terugkoppelt na technische verwerking van een aangeboden vernietigingskandidaat: `SUCCESS`, `FAILED`, `SKIPPED`, `NOT_FOUND` of `CHANGED`.
Alleen `SUCCESS` betekent dat het informatieobject is vernietigd. Daarbij hoort het event *Vernietigen* met het tijdstip van vernietiging.
Uitvoeringsresultaten worden door de cockpit verwerkt in het vernietigingsdossier en gebruikt voor verantwoording en de verklaring van vernietiging.

---

## Vernietigen / vernietiging *(MDTO)*
Vernietigen van informatie is het blijvend ontoegankelijk maken van die informatie, waardoor deze niet meer vindbaar, beschikbaar, leesbaar, interpreteerbaar en betrouwbaar is.
Vernietiging vindt plaats in het bronsysteem, aangestuurd via een stekker, met een vastgelegde vernietigingsmethode (lijst Cockpit-vernietigingsmethoden).
Een soft delete, prullenbak of archiveringsvlag is geen vernietiging. Het verwijderen van een werkkopie of het logisch verwijderen van een taak is evenmin vernietiging.

---

## Vernietigingscockpit
De centrale applicatie voor regie, besluitvorming en verantwoording van vernietiging.

De cockpit:
- ondersteunt workflows en accordering
- beheert vernietigingslijsten en dossiers
- communiceert uitsluitend met stekkers
- voert zelf geen technische vernietiging uit

---

## Vernietigingskandidaat
Een informatieobject dat door een stekker is geselecteerd als mogelijk te vernietigen.
Een vernietigingskandidaat is altijd precies één MDTO-informatieobject op aggregatieniveau Archief, Serie, Dossier of Archiefstuk, met de MDTO-metagegevens die nodig zijn voor beoordeling, besluit en verantwoording (ADR-0001, ADR-0005). Kunstmatige groeperingen zijn niet toegestaan.
Een vernietigingskandidaat is nog niet vernietigd. De cockpit beoordeelt en accordeert de lijst met vernietigingskandidaten binnen de workflow voordat vernietiging wordt vrijgegeven.

---

## Vernietigingslijst (lijst met vernietigingskandidaten)
De lijst van vernietigingskandidaten van een taakinstantie, samengesteld uit één of meer selecties en beoordeeld in de cockpit.
In MDTO-termen een informatieobject (aggregatieniveau Archiefstuk) in het vernietigingsdossier. De lijst wordt bevroren bij de vrijgave door de archivaris (event *Bevriezing*, lijsthash).

---

## Vernietigingsverklaring (verklaring van vernietiging)
Een formeel document dat verklaart welke informatie is vernietigd, conform art. 8 Archiefbesluit 1995:
- een specificatie van de vernietigde informatieobjecten
- de wijze waarop vernietigd is (vernietigingsmethode)
- het tijdstip van vernietiging

Daarnaast bevat de verklaring de context en de accorderingen. Alleen kandidaten met resultaat `SUCCESS` gelden als vernietigd; andere uitkomsten worden apart gespecificeerd.
De verklaring is een informatieobject (aggregatieniveau Archiefstuk) in het vernietigingsdossier en wordt gearchiveerd als juridisch bewijs.

---

## Waardering *(MDTO)*
De waardering van het informatieobject volgens de van toepassing zijnde en vastgestelde selectielijst.
Gesloten MDTO-lijst Waarderingen:
- **B** – Blijvend te bewaren
- **V** – Tijdelijk te bewaren (na afloop van de bewaartermijn te vernietigen)
- **N** – Nader te bepalen

Alleen een kandidaat met waardering **V** kan worden vernietigd.

---

## Werkkopie
De gegevens van een vernietigingsdossier in de cockpitdatabase, naast het blijvende exemplaar in het archiefsysteem.
De werkkopie wordt na een instelbare termijn na archivering automatisch verwijderd. Er blijft een grafsteen achter (ADR-0006).

---

## Workflow
De vastgelegde volgorde van stappen in een vernietigingsproces.
De workflow borgt functiescheiding en correcte besluitvorming.
Workflows zijn configureerbaar en herhaalbaar.

---

## Afwijking tussen selectie en uitvoering
Situatie waarin een vernietigingskandidaat niet (meer) vernietigbaar is op het moment van uitvoering, bijvoorbeeld door wijziging of verwijdering in het bronsysteem.
De stekker meldt dit als uitvoeringsresultaat `CHANGED` of `NOT_FOUND`; de cockpit maakt het verschil tussen besluit en uitvoering zichtbaar in het dossier.
