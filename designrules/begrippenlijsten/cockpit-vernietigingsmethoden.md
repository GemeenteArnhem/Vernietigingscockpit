# Begrippenlijst Cockpit-vernietigingsmethoden

| Kenmerk | Waarde |
|---|---|
| Naam | Cockpit-vernietigingsmethoden |
| Identificatie | `urn:vernietigingscockpit:begrippenlijst:cockpit-vernietigingsmethoden:1.0` |
| Versie | 1.0 |
| Type | Open |
| Basis | ADR-0005 §4.3 en §9 (B-M4); Archiefbesluit 1995 art. 8 (wijze van vernietiging) |

De stekker meldt per vernietigingsuitvoering de **wijze** waarop is vernietigd (`Vernietigingsuitvoering.vernietigingsmethode`). Daarnaast geeft hij een verplichte toelichting (`vernietigingsmethodeToelichting`) over de behandeling van back-ups, replica's, zoekindexen, caches en logbestanden, en over de termijn waarbinnen restanten daarin zijn uitgedoofd.

Elke methode moet leiden tot vernietiging in de zin van MDTO: *het blijvend ontoegankelijk maken van informatie, waardoor deze niet meer vindbaar, beschikbaar, leesbaar, interpreteerbaar en betrouwbaar is*. Een "prullenbak", een archiveringsvlag of een soft delete die te herstellen is, is **geen** vernietiging.

| Label | Definitie |
|---|---|
| Verwijderd via bronfunctie | Vernietigd met de door de leverancier van de bron geboden definitieve verwijderfunctie, inclusief bijbehorende bestanden en metagegevens. De toelichting beschrijft wat die functie precies verwijdert. |
| Fysiek verwijderd | Gegevens en bestanden zijn rechtstreeks uit de primaire opslag (database, bestandsopslag) verwijderd, zonder herstelmogelijkheid in de bron. |
| Overschreven | De opslaglocatie van de gegevens is overschreven, zodat herstel ook met forensische middelen niet mogelijk is. |
| Cryptografisch onleesbaar gemaakt | De gegevens waren versleuteld met een sleutel die alleen voor deze gegevens gold; die sleutel is aantoonbaar vernietigd (crypto-shredding). |
| Overig | Een andere methode; de toelichting beschrijft de methode en waarom die voldoet aan de MDTO-definitie van vernietigen. |
