# Begrippenlijst Cockpit-selectielijsten

| Kenmerk | Waarde |
|---|---|
| Naam | Cockpit-selectielijsten |
| Identificatie | `urn:vernietigingscockpit:begrippenlijst:cockpit-selectielijsten:1.0` |
| Versie | 1.0 |
| Type | Open |
| Status | **Concept.** De codes worden permanent zodra ADR-0008 is vastgesteld. Tot dan kunnen ze nog wijzigen. |
| Basis | ADR-0008 (selectielijstcodes), ADR-0005 (MDTO leidend) |
| Bron | Nationaal Archief, *Overzicht vastgestelde BSD's en selectielijsten*, bijgewerkt tot en met 5 oktober 2026 |
| Machineleesbaar | [cockpit-selectielijsten.json](cockpit-selectielijsten.json), afgeleid van deze tabel |

Dit register geeft elke door de minister vastgestelde selectielijst of elk basisselectiedocument (BSD) een **selectielijstcode**. Het Nationaal Archief kent zelf geen code per lijst. De selectielijstcode is het `identificatieKenmerk` van de selectielijst in `informatiecategorie.begripBegrippenlijst.verwijzingIdentificatie`. De `identificatieBron` is altijd `Cockpit-selectielijsten`:

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

## Regels

Ontwerpregels DR-SL-01 tot en met DR-SL-05 staan in ADR-0008. Samengevat:

- **Formaat** `CODE-YYYY` of `CODE-YYYY.VV`, patroon `^[A-Z][A-Z0-9]{1,11}-[0-9]{4}(\.[0-9]{2})?$`.
  - `CODE`: hoofdletters en cijfers, geen koppelteken; een afkorting van het toepassingsgebied (bijvoorbeeld `GEM`, `PROV`, `WS`) of van de zorgdrager (bij voorkeur de afkorting uit het NA-overzicht, bijvoorbeeld `COA`, `RDW`).
  - `YYYY`: het jaartal waarmee de lijst in de titel bekendstaat (bijvoorbeeld *… organen 2020*). Noemt de titel geen lijstjaar, dan het jaar van de Staatscourant-publicatie. Jaartallen van een periode (*vanaf 1945*) tellen niet.
  - `.VV`: alleen bij een formele **wijziging** van een al gecodeerde lijst (nieuwe vaststelling en publicatie), oplopend vanaf `.01`. Een nieuwe lijst krijgt een nieuwe code, geen versienummer.
  - Hebben twee lijsten dezelfde `CODE-YYYY`, dan wordt `CODE` verfijnd met het onderwerp en zo nodig met een volgletter.
- **Uniek**: een code komt in dit register precies één keer voor.
- **Permanent**: een uitgegeven code wordt nooit gewijzigd, verwijderd of hergebruikt. Een ingetrokken of vervallen lijst houdt haar code.
- **Herleidbaar**: elke code verwijst naar de officiële vaststelling (beschikkingskenmerk en/of Staatscourant-vindplaats).
- **Nieuwe lijsten**: na publicatie in de Staatscourant wordt een regel toegevoegd via een pull request op dit bestand en het JSON-bestand (minor versie omhoog).

Titels, zorgdragers en kenmerken zijn automatisch overgenomen uit het NA-overzicht (PDF) en kunnen kleine opmaakverschillen bevatten. Leidend is de publicatie in de Staatscourant. Vóór vaststelling worden in elk geval de regels met een volgletter beoordeeld.

## Register

| Code | Titel | Zorgdrager | Beschikking | Staatscourant | Opmerking |
|---|---|---|---|---|---|
| `VWHDTP-1994` | HDTP/ Telecommunicatie en Post | V&W | 02-11-94 | 14-12-94/241 |  |
| `DEF-1995` | Militair materieel | DEF | 23-11-94 + 28-08-97 | 28-03-95/62, 09-05-95/89 |  |
| `RIJKSUNIVE-1995` | Rijksuniversiteiten | OC&W, LNV | 01-12-94 | 06-01-95/5 |  |
| `ARK-1995` | Algemene Rekenkamer | ARK | KB 03-02-95 | 12-06-95/110 |  |
| `FIN-1995` | Belastingen | FIN | 19-01-95 | 13-10-95/199 |  |
| `FIN-1996` | Rijksbegroting | FIN | 03-05-96 | 22-05-96/96 |  |
| `VWDGSM-1994` | DGSM 1994 | V&W | 04-06-96 | 05-07-96/127 | Jaartal uit de titel. |
| `VWRLD-1996` | Burgerluchtvaart/ RLD | V&W | 01-08-96 | 08-10-96/194 |  |
| `VWLVB-1996` | Burgerluchtvaart/ LVB | V&W | 15-09-96 | 23-10-96/205 |  |
| `ZFR-1997` | Ziekenfondsraad | ZFR | 04-12-96 | 31-01-97/22 |  |
| `SZW-1997` | Arbeidsomstandigheden | SZW | 04-12-96 | 31-01-97/22 |  |
| `JUS-1997` | Vreemdelingen (IND) | JUS | 17-12-96 | 31-01-97/22 |  |
| `FIN-1997` | Domeinen | FIN | 12-12-96 | 31-01-97/22 |  |
| `HAVENSCHAPDZ-1997` | Havenschap Delfzijl | Havenschap Delfzijl | 12-12-96 | 31-01-97/22 |  |
| `RVS-1997` | Administratieve Rechtsbescherming | RvS | K.B. 21-02-97 | 06-03-97/46 |  |
| `VW-1997` | RDW | V&W | 02-04-97 | 11-04-97/70 |  |
| `DEF-2000` | Militair personeel | DEF | 27-09-00 | 13-12-00/242 |  |
| `VWS-2002` | Medische beroepen en Opleidingen | VWS | 3-12-01 | 22-1-02/15 |  |
| `BIZADGMP-1997` | DGMP | BiZa | 31-07-97 | 18-08-97/156 |  |
| `BIZABVD-1997` | Binnenlandse Veiligheidsdienst (BVD) | BiZa | ---10-97 | 11-11-97/217 |  |
| `BIZA-1998` | Overzeese pensioenen | BiZa | ---12-97 | 16-02-98/31 |  |
| `VWPTT-1998` | Staatsbedrijf PTT | V&W | 09-02-98 | 16-03-98/51 |  |
| `LNVBOSBOUW-1998` | Bosbouw | LNV | 04-03-98 | 16-03-98/51 |  |
| `LNVGRONDPRIJ-1998` | Grondprijsbeleid | LNV | 04-03-98 | 16-03-98/51 |  |
| `LNVRELATIENO-1998` | Relatienotabeleid | LNV | 04-03-98 | 30-03-98/61 |  |
| `VWKNMI-1998` | KNMI | V&W | 09-03-98 | 30-03-98/61 |  |
| `IGZ-1998` | Toezicht volksgezondheid | Inspectie Gezondheidszorg | 03-03-98 | 30-03-98/61 |  |
| `GR-1998` | Advisering gezondheidszorg | Gezondheidsraad | 03-03-98 | 30-03-98/61 |  |
| `RIVM-1998` | RIVM | RIVM | 03-03-98 | 30-03-98/61 |  |
| `KK-1999` | Kabinet der Koningin | Kabinet der Koningin | KB 12-11-99 | 9-12-99/238 |  |
| `KABNA-1999` | KABNA | KABNA/BZK | 20-11-98 | 02-02-99/22 |  |
| `RIJKSBEGRO-1998` | Rijksbegroting | AZ, BuiZa, EZ, LNV,OCW,DEF, SZW, BiZa | 08-01-98 | 30-07-98/142 |  |
| `UNIVERSITE-1999` | Universiteiten | Universiteiten | 02-06-98 | 02-02-99/22 |  |
| `AZ-2001` | Voorlichting van de rijksoverheid | AZ | 05-07-01 | 14-08-01/155 |  |
| `SZW-1999` | Inkomens- en arbeidsvoorwaardenbeleid | SZW | 02-06-98 | 04-03-99/44 |  |
| `LNVAGRARISCH-1999` | Agrarisch onderwijs | LNV | 20-11-98 | 02-02-99/22 |  |
| `STUDIEFINA-1999` | Studiefinanciering | OCW/IBG | 02-06-98 (OCW), 09-03-99 (IBG) | 07-04-99/66 |  |
| `FINSTAATSSCH-2002` | Staatsschuld | FIN | 3-12-01 | 8-01-02/5 |  |
| `PLANORGANE-1999` | Planorganen | SCP, CPB, WRR | 02-06-98 (CPB, WRR), 29-07-98 (SCP) | 02-02-99/22 |  |
| `SPECIAAL-1999` | Speciaal onderwijs | OCW/Onderwijsraad | 09-03-99 (OCW, Ond.r) | 07-04-99/66 |  |
| `BEROEPSOND-1999` | Beroepsonderwijs en volwassenen educ. | OCW/Onderwijsraad | 09-03-99 ( OCW,Ond.r.) | 07-04-99/66 |  |
| `NOM-1999` | Nationale Ombudsman | NOM | KB 12-11-99 | 9-12-99/238 |  |
| `WAARBORG-2000` | Waarborg gouden en zilveren werken | FIN/EZ | 24-05-00 (FIN/EZ) | 27-6-00/121 i.p. |  |
| `LNVFLORA-1999` | Flora en fauna | LNV | 03-08-99 | 09-11-99/216 |  |
| `VW-1999` | Waterstaat | V&W | 11-02-99 | 04-03-99/44 |  |
| `STAATSDEEL-2000` | Staatsdeelnemingen | EZ/FIN | 20-09-00 | 26-10-00/208 i.p. |  |
| `VROM-2000` | Bedrijfsvoering (verlenging) | VROM | 20-12-99 | 31-01-00/21 |  |
| `JUSPARKET-2000` | Parket Openbaar Ministerie (wijziging vernietigingslijst) | JUS | 03-08-99 | 07-02-00/26 |  |
| `OCW-1999` | Wetenschappelijk onderwijs | OCW | 23-07-99 | 09-11-99/216 |  |
| `LNVOPENLUCHT-1999` | Openluchtrecreatie | LNV | 03-08-99 | 09-11-99/216 |  |
| `BRANDWEERZ-1999` | Brandweerzorg, rampenbestrijding en crisisbeheersing | BiZa/NIBRA/LNV/EZ | 03-08-99 | 09-11-99/216 |  |
| `SER-1999` | SER | SER | 27-10-99 | 09-11-99/216 |  |
| `JUSWEERKORPS-2000` | Weerkorpsen en particuliere beveiligingsorganisaties | JUS | 24-05-00 | 06-07-00/128 i.p. |  |
| `SZWSOCIALE-2001` | Sociale voorzieningen | SZW | 07-12-00 | 23-02-01/39 |  |
| `PROV-2000` | Provincielijst | IPO | 01-11-00 | 24-11-00/229 i.p. |  |
| `OCWBASISONDE-2000` | Basisonderwijs | OC&W | 20-06-00 | 13-07-00/133 i.p. |  |
| `OCWVOORTGEZE-2000` | Voortgezet onderwijs | OC&W | 20-06-00 | 31-07-00/145 i.p. |  |
| `OCWHOGER-2000` | Hoger Beroepsonderwijs | OC&W | 20-06-00 | 24-07-00/140 i.p. |  |
| `SZW-2000` | Arbeidsomstandigheden (actualisatie) | SZW | 27-09-00 | 01-12-00/234 i..p. |  |
| `LNVNATUUR-2000` | Natuur- en landschapsbeheer | LNV | 27-09-00 | 10-11-00/219 i.p. |  |
| `LNVAGRARISCH-2000` | Agrarische handelspolitiek | LNV | 27-09-00 | 17-11-00/224 i.p. |  |
| `BZK-2000` | KABNA (actualisatie) | BZK | 20-06-00 | 09-08-00/152 i.p. |  |
| `ARBEIDSVOO-2000` | Arbeidsvoorzieningsorganisatie | Arbeidsvoorzieningsorgan isatie | 10-07-00 | 14-8-00/155 i.p. |  |
| `UNIV-2001` | Universiteiten (actualisatie) | Universiteiten | 03-04-01 | 27-04-01/82 |  |
| `FINHEFFINGSW-2001` | Heffingswetten Rijksbelastingen | FIN | 10-07-01 | 29-08-2001/166 |  |
| `FININVOERREC-2001` | Invoerrechten en –accijnzen (1940-62) | FIN | 07-12-00 | 02-02-2001/24 |  |
| `VW-2001` | Personenvervoer | V&W | 14-08-01 | 19-09-2001/181 |  |
| `SZWBEZITSVOR-2001` | Bezitsvorming | SZW | 26-03-01 | 9-05-2001/89 |  |
| `FININVOERREC-2002` | Invoerrechten en –accijnzen (1962-1995) | FIN | 10-9-01 | 21-1-02/14 |  |
| `VROM-2001` | Rijkshuisvesting | VROM | 14-08-01 | 24-09-01/184 |  |
| `RIJKSBEGRO-2001` | Rijksbegroting | JUS/VROM/VWS | 03-09-01 | 8-10-01/194 |  |
| `ARBEIDSVER-2001` | Arbeidsverhoudingen | BZK/OCW/VWS/DEF/LNV/V&W/FIN/JUS/AZ/EZ/VROM/SZW | 30-07-01 | 16-10-01/200 |  |
| `ARBEIDSVOO-2001` | Arbeidsvoorwaarden | BZK/OCW/VWS/DEF/LNV/V&W/FIN/JUS/AZ/EZ/VROM/SZW | 30-07-01 | 16-10-01/200 |  |
| `FORMATIEBE-2001` | Formatiebeleid e.a. | BZK/OCW/VWS/DEF/LNV/V&W/FIN/JUS/AZ/EZ/VROM/SZW | 30-07-01 | 16-10-01/200, 17-10-01/201 |  |
| `ARBEIDSOMS-2001` | Arbeidsomstandigheden bij de overheid | BZK/OCW/VWS/DEF/LNV/V&W/FIN/JUS/AZ/EZ/VROM/SZW | 30-07-01 | 16-10-01/200, 17-10-01/201 |  |
| `PERSONEELS-2001` | Personeelsinformatie en – administratie | BZK/OCW/VWS/DEF/LNV/V&W/FIN/JUS/AZ/EZ/VROM/SZW | 30-07-01 | 16-10-01/200, 17-10-01/201 |  |
| `OCWKUNSTEN-2002` | Kunsten | OCW | 04-07-02 | 23-07-02/138 rectificatie 16-6-03/112 |  |
| `MESTBELEID-2002` | Mestbeleid | LNV/V&W/productschapp en Pluimvee en Eieren, Vee en Vlees, Zuivel | 12-09-01 | 17-1-02/12 |  |
| `JUSKWALITEIT-2002` | Kwaliteit wetgeving | JUS | 4-12-01 | 11-1-02/8 |  |
| `WRBG-2002` | Waarborgen goud en zilver | WRBG | 20-11-01 | 8-04-2002/67 |  |
| `SZW-2002` | Arbeidsverhoudingen | SZW | 18-02-02 | 11-04-02/70 25-02-03/39 (rectificatie) |  |
| `SOCIALE-2002` | Sociale verzekeringen | SZW/SVB/Lisv | 18-02-02 | 6 t/m 8-05-02/85-87 rectificatie: 27-5-03/101 |  |
| `JUSVREEMDELI-2002` | (Toelating) vreemdelingen | JUS | 18-02-02 | 23-05-02/95 |  |
| `NWO-2002` | Wetenschapsbeleid | NWO | 17-05-02 | 04-06-02/103 |  |
| `DEFMILITAIRE-2002` | Militaire operatien | DEF | 26-04-02 | 19-06-02/114 |  |
| `IGZ-2002` | Staatstoezicht op de Volksgezondheid | IGZ | 1-8-02 | 8-8-02/149 |  |
| `DEFBURGERLUC-2002` | Burgerluchtvaart | DEF | 12-7-02 | 19-9-02/180 |  |
| `DEFRIJKSHUIS-2002` | Rijkshuisvesting | DEF | 24-6-02 | 19-9-02/180 |  |
| `WETENSCHAP-2002` | Wetenschapsbeleid | DEF/FIN/OCW/SZW/VROM/VWS | 17-5-02 | 26-9-02/185 |  |
| `BIE-2002` | Mededingingsbeleid | BIE | 12-9-02 | 30-9-02/187 |  |
| `DIENSTPLIC-2002` | Dienstplicht | AZ/DEF/SZW | 24-6-02 | 17-10-02/200 |  |
| `MILITAIRE-2002` | Militaire Operatien | BuiZa/JUS/V&W | 14-6-02 | 17-10-02/200 |  |
| `OCWMBO-2002` | MBO/VAVO | OCW | 10-10-02 | 31-10-02/210 |  |
| `RUIMTELIJK-2002` | Ruimtelijke Ordening | DEF/FIN/LNV/OCW/SZW/VROM/VWS | 24-06-02 | 7-11-02/215 |  |
| `BUZABUITENLA-2002` | Buitenland | BuZa | 9-9-02 | 14-11-02/220 |  |
| `BUZAONTWIKKE-2002` | Ontwikkelingssamenwerking | BuZa | 9-9-02 | 14-11-02/220 |  |
| `BGAPUBLIEKRE-2002` | Publiekrechtelijke bedrijfsorganisaties | BGA | 26-10-02 | 15-11-02/221 rectificatie 16-6-03/112 |  |
| `BGAARBEIDSVE-2002` | Arbeidsverhoudingen | BGA | 26-10-02 | 15-11-02/221 |  |
| `ADELSBELEI-2002` | Adelsbeleid | DEF/EZ/FIN/LNV/OCW/SZW/VWS/VROM | 17-5-02 | 18-11-02/222 |  |
| `JUS-2003` | Rechterlijke macht | JUS | 11-11-02 | 16-01-03/11 20-2-03/36 (rectificatie) |  |
| `BC-2003` | Arbeidsverhoudingen | BC | 7-11-02 | 25-2-03/39 (rectificatie) |  |
| `LNV-2003` | Sociale voorzieningen | LNV | 5-8-02 | 31-3-03/63 |  |
| `GEZONDHEID-2003` | Gezondheid en welzijn dieren | DEF/JUS/LNV/OCW/PVE/PD | 15-7-02 | 31-3 en 1-4-03/63-64 |  |
| `OCW-2003` | Monumentenzorg | OCW | 12-3-03 | 9-4-03/70 |  |
| `IND-2003` | Nationaliteiten | JUS (IND) | 17-3-03 | 6-5-03/86 27-4-11/7152 (rectificatie) |  |
| `DEF-2003` | Natuur- en landschapsbeheer | DEF | 17-3-03 | 15-5-03/93 |  |
| `KNOADELSBELA-2003` | Adelsbeleid | KNO | 12-5-03 | 15-5-03/93 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `KNOADELSBELB-2003` | Adelsbeleid/Kapittels | KNO | 4-7-03 | 15-7-03/133 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `SER-2003` | Sociaal-Economische Raad (SER) | EZ/SZW | 12-6-03 | 23-7-03/139 |  |
| `VROM-2003` | Milieubeheer | VROM | 6-6-03 | 14-16, 19-8-03/155-158 |  |
| `CONSTITUTI-2003` | Constitutionele Zaken | BZK/DEF/FIN/LNV/SZW/VWS | 12-6-03 | 8-9-03/172 |  |
| `RVS-2003` | Advisering wet- en regelgeving | RvS | 12-9-03 | 3-10-03/191 |  |
| `BZK-2003` | Nationale Ombudsman | BZK | 11-7-03 | 9-10-03/195 |  |
| `OVERHEIDSI-2003` | Overheidsinformatievoorziening | ARA/BZK/DEF/EZ/FIN/LNV/OCW/SZW/VenW/VROM/VWS | 11-7-03 | 20-10-03/202 |  |
| `UMC-2003` | Academische Ziekenhuizen | AZUvA/AZL/AZG/AZM/AZR/AZU/MET AZG-RUG/CMELUMC | 3-10-03 | 28-10-03/208 |  |
| `EMANCIPATI-2003` | Emancipatie en gelijke behandeling | DEF/FIN/LNV/OCW/SZW/VenW/VROM/VWS | 29-7-03 | 5-12-03/236 |  |
| `CFV-2004` | Volkshuisvesting | CFV | 16-1-04 | 28-1-04/18 |  |
| `WELZIJNSBE-2004` | Welzijnsbeleid | AZ/BZK/BuZa/DEF/EZ/FIN/LNV/OCW/SZW/VWS/VROM | 25-11-03 | 20-2-04/35 |  |
| `SSIOM-2004` | Sociale Verzekeringen | SSIOM | 29-3-04 | 8-4-04/69 |  |
| `COORDINATI-2004` | Coördinatie Integratie Minderheden | AZ/BZK/DEF/FIN/OCW/SVB/SZW/V&W/VROM/VWS | 20-10-03 | 8-4-04/69 |  |
| `OZZ-2004` | Bekostiging en verzekering gezondheidszorg | OZZ | 14-05-04 | 03-06-04/103 |  |
| `AANSPRAKEL-2004` | Aansprakelijkheidsverzekering motorrijtuigen | FIN/JUS/V&W/WAM | 29-03-04 | 04-06-04/104 |  |
| `STUDIEFINA-2004` | Studiefinanciering | EUR/KUB/TUDelft/TUEin dhoven/UvA/UL/KUN/UM/UU/UT/VU/WU/UG | 01-06-04 | 15-06-04/111 |  |
| `GEOINFORMA-2004` | Geo-informatie | Dienst voor het Kadaster en de Openbare registers/VROM/FIN | 14-05-04 | 24-06-04/118 |  |
| `NFF-2004` | Kunsten | Stichting Nederlands Fonds voor de Film | 28-05-04 | 25-06-04/119 |  |
| `ARBEIDSVOO-2004` | Arbeidsvoorwaarden en beroepskwaliteit in de sector Onderwijs en Wetenschappen | OCW/FIN/LNV | 04-05-04 | 09-07-04/129 |  |
| `RECLASSERI-2004` | Reclassering | JUS/Stichting Reclassering Nederland | 17-03-03 | 21-07-04/137 |  |
| `JUSEMANCIPAT-2004` | Emancipatie en gelijke behandeling | JUS | 30-06-04 | 28-07-04/142 |  |
| `JUSOVERHEIDS-2004` | Overheidsinformatievoorziening | JUS | 30-06-04 | 29-07-04/143 |  |
| `BZK-2004` | Arbeidsvoorwaarden en beroepskwaliteit in de sector Onderwijs en Wetenschappen | BZK | 04-05-04 | 02-08-04/145 |  |
| `DEVIEZENBE-2004` | Deviezenbeleid | FIN/LNV/OCW/BuiZ | 21-06-04 | 13-08-04/154 |  |
| `WATERSTAAT-2004` | Waterstaat | SZW/LNV/FIN/V&W/OCW/VROM | 29-03-04 | 16-08-04/155 |  |
| `MILIEUBEHE-2004` | Milieubeheer | DEF/V&W | 21-06-04 | 17-08-04/156 |  |
| `CULTUURBEH-2004` | Cultuurbeheer | AZ/BZK/BuZa/DEF/EZ/FIN/LNV/OCW/SZW/V&W/VWS/VROM/JUS/EUR/TU Eindhoven/TUDelft/UG/UL/UM/UT/UU/UvA/WU/ICN/ARA/RAI/ICB | 05-06-04 | 28-10-04/208 |  |
| `PLANNING-2004` | Planning van de voorzieningen in de gezondheidszorg | College Sanering Ziekenhuisvoorzieningen | 05-10-04 | 08-11-04/215 |  |
| `BUITENSECT-2004` | Buitensectorale Arbeidsvoorwaarden | BZK/DEF/FIN/LNV/OCW/SZW/VenW/VROM | 5-10-04 | 13-12-04/240 |  |
| `ARBEIDSVOO-2005` | Arbeidsvoorzieningenbeleid | AZ/DEF/EZ/FIN/LNV/OCW/VenW/VROM/BZK/SZW | 11-11-04 | 13-01-05/9 |  |
| `PT-2005` | Productschap Tuinbouw | PT | 16-12-04 | 13-01-05/9 |  |
| `COA-2005` | Toelating vreemdelingen | COA | 16-12-04 | 21-02-05/36 |  |
| `RIJKSBEGRO-2005` | Rijksbegroting | AZ/BZK/BuZa/DEF/FIN/LNV/OCW/SZW/VenW/VROM/VWS | 25-01-05 | 31-03-05/62 |  |
| `BZKPOLITIE-2005` | Politie 1994- | BZK | 17-02-05 | 31-03-05/62 |  |
| `DRINKWATER-2005` | Drinkwatervoorziening (Rijksinstituut voor de Drinkwatervoorziening) | VenW/VWS | 25-01-05 | 25-04-05/79 |  |
| `BELASTINGH-2005` | Belastingheffing | FIN/BZK/LNV/SZW/Ven W | 08-03-05 | 31-05-05/102 |  |
| `GEZONDHEID-2005` | Gezondheid en welzijn van dieren | UU/WU | 03-05-05 | 31-05-05/102 |  |
| `DEFTOELATING-2005` | Toelating van vreemdelingen | DEF | 22-03-05 | 13-06-05/111 |  |
| `STAATSSCHU-2005` | Staatsschuld | FIN/BuZa/ABP | 12-05-05 | 13-06-05/111 |  |
| `PUBLIEKREC-2005` | Publiekrechtelijke bedrijfsorganisaties | Akkerbouwproductschap pen | 22-03-05 | 14-06-05/112 4-07-05/126 (rectificatie) |  |
| `BZKBRANDWEER-2005` | Brandweerzorg, rampenbestrijding en crisisbeheersing | BZK | 02-03-05 | 14-06-05/112 |  |
| `MILITAIRE-2005` | Militaire Operatiën | EZ/FIN/VWS/VW/DEF/Bu Za/Dienst Kadaster | 03-05-05 | 15-06-05/113 4-07-05/126 (rectificatie) |  |
| `PO-2005` | PO/VO/HBO/WO/BO/VE | Inspectie van het Onderwijs | 07-02-05 | 16-06-05/114 |  |
| `RECHTSPLEG-2005` | Rechtspleging en rechtshulp | AR NovA/RvT OvA | 25-05-05 | 16-06-05/114 |  |
| `VENW-2005` | Rijksbegroting | VenW | 08-06-05 | 18-07-05/136 |  |
| `VROM-2005` | Monumentenzorg | VROM | 31-05-05 | 29-07-05/145 |  |
| `VOLKSHUISV-2005` | Volkshuisvesting | BZK/FIN/LNV/SZW/VROM/VWS | 09-06-05 | 04-08-05/149 |  |
| `COLO-2005` | Volwasseneneducatie en beroepsonderwijs | COLO | 27-07-05 | 15-08-05/156 |  |
| `DEFDIENSTPLI-2005` | Dienstplicht | DEF | 14-06-05 | 15-08-05/156 |  |
| `KOFS-2005` | Volwasseneneducatie en beroepsonderwijs | KOFS | 27-07-05 | 19-08-05/160 |  |
| `HEFFING-2005` | Heffing rijksbelastingen | BuZa/BZK/FIN/LNV/OCW/SZW/V&W/VROM | 03-05-05 | 30-08-05/167 |  |
| `KNB-2005` | Notarissen | KNB | 09-08-05 | 01-11-05/212 |  |
| `WAPENS-2005` | Wapens en munitie | AZ/BuZa/BZK/DEF/EZ/FIN/JUS/LNV/SZW/V&W/VROM | 15-09-05 | 24-11-05/229 |  |
| `AUTEURSREC-2005` | Auteursrecht | BuZa/BZK/EZ/DEF/FIN/JUS/LNV/OCW/SZW/V&W/VROM/VWS | 15-09-05 | 29-11-05/232 |  |
| `VWS-2005` | Openluchtrecreatie | VWS | 14-09-05 | 30-11-05/233 |  |
| `RIJKSDIENS-2005` | Rijksdienst voor het wegverkeer | V&W/RDW | 07-10-05 | 01-12-05/234 |  |
| `JUS-2005` | Beleid Openbaar Ministerie | JUS | 14-10-05 | 02-12-05/235 |  |
| `ORGANISATI-2005` | Organisatie van de rijksoverheid | AZ/BuZa/BZK/DEF/EZ/FIN/LNV/OCW/SZW/V&W/VROM/VWS | 05-07-05 | 16-12-05/245 |  |
| `GEM-2005` | Gemeentelijke organen | VNG | 21-11-05 | 20-12-05/247 |  |
| `ZONMWSOCIALE-2005` | Sociale zekerheid | ZonMw | 21-11-05 | 29-12-05/253 |  |
| `ZONMWVOLKSGE-2005` | Volksgezondheidssubsidies | ZonMw | 21-11-05 | 29-12-05/253 |  |
| `LANDINRICH-2006` | Landinrichting | BZK/FIN/LNV/V&W/VROM | 07-07-05 | 10-01-06/7 |  |
| `JUS-2006` | Sanctiebeleid (CJIB) | JUS | 12-12-05 | 10-01-06/7 |  |
| `SOCIALEA-2006` | Sociale verzekeringen | BuZa/BZK/DEF/FIN/OCW/SZW/V&W/VROM/VWS/RWI/SVB/UWV | 14-10-05 | 12-01-06/9 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `ENERGIEBEL-2006` | Energiebeleid | BZK/DEF/EZ/FIN/LNV/OCW/SZW/V&W/VROM/VWS | 07-07-05 | 13-01-06/10 |  |
| `ENERGIEDEL-2006` | Energiedelfstoffen | BZK/DEF/EZ/FIN/LNV/OCW/SZW/V&W/VROM/VWS | 07-07-05 | 13-01-06/10 |  |
| `IV-2006` | Academische zaak, deel IV (Wetenschappelijk onderwijs 1945-1986) | EUR/Radboud UN/RUG/TUDelft/TUEind hoven/UL/UM/UU/UT/Uv A/UvT/VU/WU | 09-08-05 | 24-02-06/40 |  |
| `JUSTITIELE-2006` | Justitiële Jeugdzorg | BZK/DEF/FIN/JUS/OCW/VWS | 12-12-05 | 27-02-06/41 |  |
| `LNV-2006` | Relatienotabeleid | LNV | 19-12-05 | 28-02-06/42 |  |
| `RECHTSPERS-2006` | Rechtspersonen | BZK/DEF/EZ/FIN/JUS/LNV/OCW/SZW/V&W/CBB/UWV | 21-11-05 | 01-03-06/43 |  |
| `MILITAIR-2006` | Militair personeel | AZ/DEF/SZW/StZK | 19-12-05 | 06-03-06/46 |  |
| `BINNENVISS-2006` | Binnenvisserij | FIN/JUS/LNV/V&W | 23-01-06 | 20-03-06/56 |  |
| `CENTRALE-2006` | Centrale organisatie Werk en Inkomen | CWI/ARB | 16-02-06 | 20-03-06/56 |  |
| `POLITIE-2006` | Politie vanaf 1994 | 25 Regionale politiekorpsen/KLPD | 02-02-06 | 03-04-06/66 |  |
| `KAMERS-2006` | Kamers van Koophandel en Fabrieken | 21 KvKs/VVK | 16-02-06 | 10-04-06/71 |  |
| `SOCIALEB-2006` | Sociale voorzieningen | AZ/BZK/BuZa/DEF/EZ/FIN/JUS/LNV/OCW/SZW/VWS/V&W/UWV | 17-01-06 | 11-04-06/72 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `RVS-2006` | Tijdelijke waarneming Koninklijk gezag | RvS | 16-03-06 (Koninklijk Besluit) | 18-04-06/75 |  |
| `NOM-2006` | Cultuurbeheer | NOM | 16-03-06 (Koninklijk Besluit) | 18-04-06/75 |  |
| `HRVA-2006` | Cultuurbeheer | HrvA | 16-03-06 (Koninklijk Besluit) | 19-04-06/76 |  |
| `BEHEERA-2006` | Beheer van de Rijksbegroting | NOM/KNO | 16-03-06 (Koninklijk Besluiten) | 19-04-06/76 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `PUR-2006` | Oorlogsgetroffenen | PUR | 29-03-06 | 19-04-06/76 |  |
| `STATENGENE-2006` | Staten-Generaal | Eerste Kamer/Tweede Kamer/Verenigde Vergadering S-G | 16-03-06 (Koninklijk Besluiten) | 20-04-06/77 |  |
| `CULTUURBEH-2006` | Cultuurbeheer | Tweede Kamer | 16-03-06 (Koninklijk Besluit) | 20-04-06/77 |  |
| `PROV-2006` | Provinciale organen | IPO | 02-03-06 | 08-05-06/89 |  |
| `INTERNATIO-2006` | Internationale rechtshulp | BZK/BuZa/FIN/JUS | 23-03-06 | 22-05-06/99 |  |
| `CBP-2006` | Persoonsregistraties | CBP | 03-05-06 | 22-05-06/99 |  |
| `ADELSBELEI-2006` | Adelsbeleid en decoratiestelsel | BZK/DEF/EZ/FIN/LNV/OCW/SZW/VROM | 06-02-06 | 06-06-06/107 |  |
| `OVERKOEPEL-2006` | Overkoepelend beleid verkeer en waterstaat | BuZa/DEF/FIN/VROM/V&W | 27-03-06 | 08-06-06/109 |  |
| `STUDIEFINA-2006` | Studiefinanciering | OCW/AZ/BuZa/BZK/EZ/FIN/JUS/V&W/VWS/IBG | 19-04-06 | 04-07-06/127 31-07-06/146 (selectielijst en beschikking IBG) |  |
| `VWS-2006` | Adelsbeleid, adelsrecht en decoratiestelsel | VWS | 15-06-06 | 17-07-06/136 |  |
| `WETENSCHAP-2006` | Algemeen wetenschappelijke voorbereiding van het regeringsbeleid vanaf 1945 | OCW/BZK/DEF/EZ/FIN/V&W/VROM/LNV/CBS | 22-05-2006 | 03-08-06/149 |  |
| `OPTA-2006` | Telecommunicatie en post | OPTA | 15-08-2006 | 04-09-06/171 |  |
| `BEHEERB-2006` | Beheer van de rijksbegroting | EZ/JUS | 16-08-2006 | 11-09-06/176 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `IN-2006` | In- en uitvoerregelingen | AZ/BuZa/DEF/EZ/FIN/LNV/V&W/VWS | 15-08-2006 | 02-10-06/191 |  |
| `GENEESMIDD-2006` | Geneesmiddelen en medische hulpmiddelen | BuZa/EZ/FIN/LNV/VWS | 28-08-2006 | 03-10-06/192 |  |
| `INDUSTRIE-2006` | Industrie- en technologiebeleid | AZ/BuZA/BZK/DEF/EZ/FIN/JUS/LNV/OCW/SZW/V&W | 12-09-2006 | 17-10-06/202 |  |
| `ORADVISERING-2006` | Advisering Onderwijsraad | OR | 26-09-2006 | 19-10-06/204 |  |
| `ORBASISONDER-2006` | Basisonderwijs | OR | 26-09-2006 | 19-10-06/204 |  |
| `ORHOGER-2006` | Hoger Beroepsonderwijs | OR | 26-09-2006 | 19-10-06/204 |  |
| `ORMIDDELBAAR-2006` | Middelbaar beroepsonderwijs en Voortgezet Algemeen Volwassenenonderwijs | OR | 26-09-2006 | 19-10-06/204 |  |
| `ORSPECIAAL-2006` | Speciaal onderwijs | OR | 26-09-2006 | 19-10-06/204 |  |
| `ORVOORTGEZET-2006` | Voortgezet onderwijs | OR | 26-09-2006 | 19-10-06/204 |  |
| `ORWETENSCHAP-2006` | Wetenschappelijk onderwijs | OR | 26-09-2006 | 19-10-06/204 |  |
| `DEF-2006` | Politie vanaf 1994 | DEF | 20-10-2006 | 21-11-06/227 |  |
| `BEKOSTIGIN-2006` | Bekostiging en verzekering van de gezondheidszorg | BZK/DEF/EZ/FIN/JUS/LNV/OCW/SZW/VWS/CAK-BZ/SUO | 10-07-2006 | 28-11-06/232 |  |
| `RELATIENOT-2006` | Relatienotabeleid | FIN/VWS | 07-11-2006 | 1-12-2006/235 |  |
| `GRATIE-2006` | Gratie | AZ/BuZa/FIN/JUS/OCW/SZW/VROM | 15-08-2006 | 5-12-2006/237 |  |
| `NATUUR-2006` | Natuur- en landschapsbeheer | BuZa/OCW/VROM/VWS | 07-11-2006 | 7-12-2006/239 |  |
| `GEWASBESCH-2006` | Gewasbescherming | FIN/JUS/LNV/SZW/V&W | 04-07-2006 | 11-12-2006/241 |  |
| `BOSBOUW-2006` | Bosbouw | OCW/VWS | 09-11-2006 | 12-12-2006/242 |  |
| `VWSVOLKSGEZO-2007` | Volksgezondheidssubsidies | VWS | 20-11-2006 | 05-01-2007/4 |  |
| `CM-2007` | Ondersteunende taken Commissariaat voor de Media | CM | 14-11-2006 | 05-01-2007/4 |  |
| `RECHTERLIJ-2007` | Rechterlijke macht | JUS/5 Gerechtshoven/19 Rechtbanken | 12-12-2006 | 08-01-2007/5 |  |
| `BESTUURLIJ-2007` | Bestuurlijke en financiële organisatie lagere overheden | AZ/BuZa/BZK/DEF/EZ/FIN/JUS/LNV/OCW/SZW/V&W/VROM/VWS | 15-11-2006 | 30-01-2007/21 |  |
| `LIJKBEZORG-2007` | Lijkbezorging | BuZa/BZK/DEF/JUS/V&W/VROM/VWS | 11-01-2007 | 01-02-2007/23 |  |
| `ZONDAGSWET-2007` | Zondagswet | BZK/JUS | 22-01-2007 | 12-2-2007/30 rectificatie BZK: 6-3-2007/46 |  |
| `KWALITEIT-2007` | Kwaliteit Nederlandse wetgeving | AZ/BuZa/BZK/EZ/FIN/JUS/LNV/OCW/SZW/V&W/VWS | 21-12-2006 | 14-2-2007/32 |  |
| `INKOMENS-2007` | Inkomens- en arbeidsvoorwaardenbeleid | AZ/BuZa/BZK/DEF/EZ/FIN/JUS/LNV/OCW/SZW/V&W/VROM/VWS | 14-03-2006 | 16-2-2007/34 |  |
| `UMC-2007` | Openbare en bijzondere academische ziekenhuizen | AMC/EMC/AZM/UMC Utrecht/UMCG/LUMC | 12-1-2007 | 19-2-2007/35 |  |
| `FLORA-2007` | Flora & fauna | FIN/JUS/OCW/VWS | 25-1-2007 | 21-2-2007/37 rectificatie JUS: 1-3-2007/43 |  |
| `VERSLAVING-2007` | Verslavingsbeleid | EZ/JUS/VWS | 22-1-2007 | 26-2-2007/40 |  |
| `EZ-2007` | Stimulering midden- en kleinbedrijf | EZ | 25-1-2007 | 27-2-2007/41 |  |
| `TOERISME-2007` | Toerisme | BuZa/EZ/FIN/JUS/LNV/V&W/VWS/ANVR | 8-12-2006 | 28-2-2007/42 |  |
| `MILITAIRE-2007` | Militaire operatiën | AZ/BZK/JUS/LNV/SZW | 25-1-2007 | 5-3-2007/45 |  |
| `VOEDING-2007` | Voeding- en productveiligheid | AZ/DEF/EZ/FIN/JUS/LNV/SZW/V&W/VWS/PVE/COKZ | 29-1-2007 | 7-3-2007/47 rectificatie DEF: 13-3-2007/51 |  |
| `METROLOGIE-2007` | Metrologie | EZ/FIN | 13-3-2007 | 2-4-2007/65 |  |
| `BEVOLKINGS-2007` | Bevolkingsadministratie en reisdocumenten | AZ/BuZa/BZK/DEF/FIN/JUS/SZW/VWS | 13-3-2007 | 5-4-2007/68 |  |
| `FRIESE-2007` | Friese taal | BuZa/BZK/JUS/FIN/OCW/VWS | 12-3-2007 | 12-4-2007/71 |  |
| `BESCHERMIN-2007` | Bescherming van persoonsgegevens | AZ/BuZa/BZK/DEF/EZ/FIN/JUS/LNV/OCW/SZW/V&W/VROM/VWS | 16-3-2007 | 16-4-2007/73 |  |
| `INTERNATIOA-2007` | Internationale monetaire en financiële zaken | AZ/BuZa/BZK/EZ/FIN/LNV | 16-3-2007 | 18-4-2007/75 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `MILITAIR-2007` | Militair materieel | BuZa/BZK/DEF/EZ/FIN/JUS/V&W | 29-1-2007 | 24-4-2007/79 |  |
| `LANDBOUWKW-2007` | Landbouwkwaliteit en voedselveiligheid en kwaliteit uitgangsmateriaal en biotechnologie | BuZa/BZK/FIN/JUS/LNV/OCW/SZW/V&W/VROM/VWS/NAK/PVE/NVK | 18-10-2006 | 21-05-2007/95 |  |
| `OORLOGSGET-2007` | Oorlogsgetroffenen | AZ/BuZa/BZK/DEF/EZ/FIN/JUS/LNV/OCW/SZW/V&W/VWS/Cogis/Gebaar/RS&R/SJHF/SAIP/SAMO | 5-3-2007 | 24-05-2007/98 |  |
| `PLANNING-2007` | Planning voorzieningen gezondheidszorg | BZK/DEF/FIN/JUS/OCW/SZW/VWS | 19-4-2007 | 29-05-2007/100 |  |
| `GOEDERENVE-2007` | Goederenvervoer | OCW/V&W/CBB | 19-4-2007 | 29-05-2007/100 |  |
| `KUNSTEN-2007` | Kunsten | AZ/BuZa/EZ/FIN/JUS/VROM/VWS/FA/FBKVB/FP/FPM/MS/SvdA/FST | 19-4-2007 | 30-05-2007/101 |  |
| `GEZONDHEID-2007` | Gezondheid en welzijn van dieren | LNV/SZW/V&W/VWS | 8-5-2007 | 05-06-2007/105 |  |
| `MONUMENTEN-2007` | Monumentenzorg | BZK/LNV/VWS | 3-5-2007 | 11-06-2007/109 |  |
| `VOORLICHTI-2007` | Voorlichting van de rijksoverheid | AZ/BuZa/BZK/DEF/EZ/FIN/JUS/LNV/OCW/SZW/VROM/V&W/VWS | 3-5-2007 | 14-06-2007/112 |  |
| `INFECTIEBE-2007` | Infectiebestrijding en preventieve gezondheidszorg | BZK/LNV/OCW/VWS | 8-5-2007 | 19-06-2007/114 |  |
| `CONSTITUTI-2007` | Constitutionele Zaken | AZ/BuZa/BZK/JUS/OCW | 8-5-2007 | 21-06-2007/117 |  |
| `SBB-2007` | Natuur- en landschapsbeheer | SBB | 30-5-2007 | 26-06-2007/120 |  |
| `HERVERZEKE-2007` | Herverzekering van export- en importkredieten en investeringsgaranties | AZ/BuZa/BZK/EZ/FIN/JUS/LNV | 12-06-2007 | 12-07-2007/132 |  |
| `GRONDPRIJS-2007` | Grondprijsbeleid | FIN/LNV | 30-03-2007 | 16-07-2007/134 |  |
| `WK-2007` | Waardebepaling onroerende zaken d.m.v. belastingheffing door Rijk, gemeenten en waterschappen | WK | 28-05-2007 | 17-07-2007/135 |  |
| `KANSSPELEN-2007` | Kansspelen | EZ/FIN/JUS/VWS | 22-06-2007 | 19-07-2007/137 |  |
| `CTB-2007` | Gewasbescherming | CTB | 4-07-2007 | 24-07-2007/140 |  |
| `RIJKSHUISV-2007` | Rijkshuisvesting | AZ/BuZa/BZK/DEF/EZ/FIN/JUS/LNV/OCW/SZW/V&W/VROM/VWS | 12-03-2007 | 26-07-2007/142 |  |
| `OVV-2007` | Brandweerzorg, rampenbestrijding en crisisbeheersing | OvV | 5-07-2007 | 30-07-2007/144 |  |
| `VWSADVISERIN-2007` | Advisering in de gezondheidszorg | VWS | 25-06-2007 | 31-07-2007/145 |  |
| `JUSTITIELE-2007` | Justitiële documentatie en verklaringen omtrent gedrag | BZK/JUS | 9-07-2007 | 01-08-2007/146 |  |
| `CONSUMENTE-2007` | Consumentenbeleid | BZK/EZ/FIN/SZW/VWS | 9-07-2007 | 02-08-2007/147 |  |
| `PATIENTENB-2007` | Patiëntenbeleid | AZ/BZK/DEF/JUS/VWS/NTS/StFPGO/CCMO | 21-06-2007 | 09-08-2007/152 |  |
| `ZEEEN-2007` | Zee-en kustvisserij | FIN/LNV | 9-07-2007 | 24-09-2007/184 |  |
| `BUZABUITENLA-2007` | Nederlands buitenlands beleid | BuZa | 8-08-2007 | 02-10-2007/190 |  |
| `REGIONAAL-2007` | Regionaal en ruimtelijk economisch beleid | BZK/DEF/EZ/FIN/JUS/LNV/SZW/V&W/VROM | 21-08-2007 | 05-10-2007/193 |  |
| `GELDVOORZI-2007` | Geldvoorziening | BZK/FIN | 13-08-2007 | 08-10-2007/194 |  |
| `VOEDSELVOO-2007` | Voedselvoorziening en agrarisch markt- en prijsbeleid | EZ/FIN/JUS/LNV/OCW/SZW | 18-09-2007 | 12-10-2007/198 |  |
| `BUZAFORMATIE-2007` | Formatiebeleid, arbeidsmarktbeleid en personeelsontwikkeling en mobiliteit | BuZa | 11-09-2007 | 12-10-2007/198 |  |
| `JUSORGANISAT-2007` | Organisatie rijksoverheid | JUS | 11-09-2007 | 15-10-2007/199 |  |
| `BUZAARBEIDSA-2007` | Arbeidsvoorwaarden rijkspersoneel | BuZa | 11-09-2007 | 15-10-2007/199 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `BUZAPERSONEE-2007` | Personeelsinformatievoorzienin g en –administratie | BuZa | 11-09-2007 | 16-10-2007/200 |  |
| `BEROEPENKW-2007` | Beroepenkwaliteit | EZ/FIN/JUS/LNV/OCW/CBB/OCN/NivRA/NovAA | 20-09-2007 | 18-10-2007/202 |  |
| `NATIONALE-2007` | Nationale Ombudsman | BZK/BuZa/DEF/EZ/FIN//JUS/LNV/OCW/SZW/V&W/VWS/VROM | 13-09-2007 | 23-10-2007/204 |  |
| `PRIJSBELEI-2007` | Prijsbeleid | AZ/BuZa/BZK/DEF/EZ/FIN/JUS/LNV/OCW/SZW/V&W/VROM/VWS | 5-10-2007 | 23-10-2007/205 |  |
| `GELDZUIVER-2007` | Geldzuivering | V&W/LNV/JUS/FIN/BZK | 14-09-2007 | 25-10-2007/207 |  |
| `BUZAARBEIDSB-2007` | Arbeidsverhoudingen | BuZa | 3-10-2007 | 29-10-2007/209 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `BUITENSECT-2007` | Buitensectorale Arbeidsvoorwaarden | EZ/AZ/JUS/BuZa/VWS | 3-10-2007 | 30-10-2007/210 |  |
| `INTERNATIOB-2007` | Internationale Volksgezondheid | BuZa/OCW/VWS | 14-09-2007 | 05-11-2007/214 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `POLITIE-2007` | Politie 1945-1993 | AZ/BuZa/BZK/DEF/EZ/FIN/JUS/LNV/OCW/V&W/VWS | 8-10-2007 | 6-11-2007/215 |  |
| `JUSEMANCIPAT-2007` | Emancipatie&gelijke behandeling | JUS | 3-10-2007 | 12-11-2007/219 |  |
| `NOTARISSEN-2007` | Notarissen | JUS/FIN/EZ/KNB | 11-10-2007 | 13-11-2007/220 |  |
| `TARIEVEN-2007` | Tarieven in de gezondheidszorg | CBB/OCW/JUS/FIN/DEF/SZW/EZ/VWS/NZA | 9-10-2007 | 15-11-2007/222 |  |
| `PDIREKTA-2007` | P-Direkt/ personeelsdossier | VWS/VROM/V&W/SZW/OCW/LNV/JUS/FIN/EZ/B uZa/BZK/AZ | 16-08-200718-10-2007 | 20-11-2007/225 rectificatie: 18-12-2007/245 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `PDIREKTB-2007` | P-Direkt/ personeelsdossier | RvS/NOM/KNO/KdK/AR | 21-07-2007 (Koninklijke Besluiten) | 20-11-2007/225 rectificatie RvS: 18-12-2007/245 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `REGULERING-2007` | Regulering Toezicht Bank&kredietwezen | BZK/BuZa/EZ/AZ/FIN/LNV/JUS | 10-10-07 | 26-11-2007/229 |  |
| `BUZAARBEIDSO-2007` | Arbeidsomstandigheden | BuZa | 1-11-2007 | 30-11-2007/233 |  |
| `ADELSBELEI-2007` | Adelsbeleid, adelsrecht en decoratiestelsel | AZ/BuZa/JUS/V&W | 1-11-2007 | 05-12-2007/236 |  |
| `HBA-2008` | Hoofdbedrijfschap Afbouw | HBA | 17-12-2007 | 04-01-2008/3 |  |
| `VW-2008` | Meteorologie: KNMI | V&W | 12-12-2007 | 07-01-2008/4 |  |
| `BEDRIJFSVO-2008` | Bedrijfsvoering rechterlijke macht na 2002 | 5 Gerechtshoven/19 Rechtbanken/CBB/CRvB/RvdR | 17-12-2007 | 08-01-2008/5 |  |
| `ECONOMISCH-2008` | Economische mededinging en Industrieel eigendom | BZK/EZ/FIN/LNV/OCW/SZW/VWS | 7-12-2007 | 08-01-2008/5 |  |
| `OUDERENBEL-2008` | Ouderenbeleid | BZK/EZ/FIN/OCW/SZW/V&W/VWS | 13-12-2007 | 04-02-2008/24 |  |
| `VWS-2008` | Nationale Ombudsman | VWS | 15-01-2008 | 11-02-2008/29 |  |
| `NATUURLIJK-2008` | Natuurlijke personen | BuZa/BZK/DEF/JUS/OCW/SZW | 15-01-2008 | 13-02-2008/31 |  |
| `GEVANGENIS-2008` | Gevangeniswezen en terbeschikkingstelling | BuZa/BZK/DEF/JUS/OCW | 08-01-2008 | 25-02-2008/39 |  |
| `JUSGEFINANCI-2008` | Gefinancierde rechtsbijstand | JUS | 07-02-2008 | 10-03-2008/49 |  |
| `GERECHTSDE-2008` | Gerechtsdeurwaarders | EZ/JUS | 13-02-2008 | 10-03-2008/49 |  |
| `SFL-2008` | Letteren | SFL | 28-02-2008 | 12-03-2008/51 |  |
| `JUSZORG-2008` | Zorg voor de rechtspleging | JUS | 28-02-2008 | 17-03-2008/54 |  |
| `VERMOGENSR-2008` | Vermogensrecht | DEF/JUS/OCW/V&W | 06-03-2008 | 25-03-2008/58 |  |
| `LANDBOUWST-2008` | Landbouwstructuurbeleid | EZ/FIN/LNV/OCW/SZW/VROM/V&W/PVE/DLO/St ZHR | 15-02-2008 | 27-03-2008/60 |  |
| `MEDIA-2008` | Media, Letteren, Bibliotheken | AZ/BZK/EZ/FIN/JUS/OCW/V&W/VWS/NLPVF/StER/RNW/CM/CTCBANR | 26-01-2007 | 28-03-2008/61 |  |
| `VERZEKERIN-2008` | Toezicht verzekeringsbedrijf | AZ/BZK/BuZa/EZ/FIN/JUS/SZW/V&W/CBB | 05-03-2008 | 01-04-2008/63 |  |
| `ARBEIDSOMS-2008` | Arbeidsomstandigheden | BZK/DEF/EZ/OCW/SZW/V&W/VWS | 28-04-2008 | 04-06-2008/105 |  |
| `ARK-2008` | Algemene Rekenkamer | ARK | 23-04-2008 (Koninklijk Besluit) | 09-06-2008/108 |  |
| `SCHEEPVAAR-2008` | Scheepvaart en maritieme zaken | BuZa/BZK/DEF/EZ/FIN/JUS/SZW/V&W | 16-06-2008 | 07-07-2008/128 |  |
| `LNV-2008` | Gezondheid en welzijn van dieren | LNV | 18-06-2008 | 07-07-2008/128 |  |
| `STAYBEHIND-2008` | Stay-behind organisaties in de Koude Oorlog | AZ/DEF | 18-06-2008 | 08-07-2008/129 |  |
| `PACHTAANGE-2008` | Pachtaangelegenheden | FIN/JUS/LNV | 16-06-2008 | 14-07-2008/133 |  |
| `BRANDWEERZ-2008` | Brandweerzorg, rampenbestrijding en crisisbeheersing | AZ/BuZa/BZK/DEF/FIN/V&W/VWS | 16-06-2008 | 15-07-2008/134 |  |
| `IBG-2008` | Informatie Beheer Groep | IBG | 28-07-2008 | 19-08-2008/159 |  |
| `BURGERLUCH-2008` | Burgerluchtvaart | AZ/BuZa/DEF/FIN/JUS/LNV/OCW/V&W | 28-07-2008 | 02-09-2008/169 |  |
| `COORDINATIA-2008` | Coördinatie, handhaving en crisisbeheersing | DLO/LNV | 18-09-2008 | 22-10-2008/205 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `VOEDING-2008` | Voeding en productveiligheid | LNV/VWS (voor VWA) | 30-09-2008 | 31-10-2008/212 herplaatsing voor VWS (voor VWA) Stcrt. Nr. 219 |  |
| `VOORVWAVOEDA-2008` | Voeding en productveiligheid | LNV (voor VWA) | C/S&A/08/2187 | 31-10-2008/403 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `VOORVWAVOEDB-2008` | Voeding en productveiligheid | VWS (voor VWA) | C/S&A/08/2188 | 11-11-2008/415 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `COORDINATIB-2008` | Coördinatie, handhaving en crisisbeheersing | Dienst Landbouwkundig Onderzoek | C/S&A/08/1970 | 22-10-2008/265 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `GEZONDHEID-2009` | Gezondheid en welzijn van dieren | SRGN/SEVHKB | 18-12-2008 | 13-01-2009/7 |  |
| `CFI-2009` | Onderwijs | CFI | 15-12-2008 | 21-01-2009/13 |  |
| `EZ-2009` | algemeen wetenschappelijke voorbereiding regeringsbeleid | Centraal Plan Bureau (EZ) | C/S&A/09/325 | 12-03-2009/49 |  |
| `TELECOMMUN-2009` | Telecommunicatie en Post | EZ/V&W/AZ/BZK/BuZa/DEF/JUS/OCW/VWS | C/S&A/09/201C/S&A/09/203 C/S&A/09/197 C/S&A/09/198 C/S&A/09/199 C/S&A/09/200 C/S&A/09/202 C/S&A/09/203 C/S&A/09/182 | 11-03-2009/43, 48,68 08-05-2009 |  |
| `SIEV-2009` | Goederenvervoer | Stichting Inschrijving Eigen Vervoer | C/S&A/09/152 | 1 7-02-2009/32 |  |
| `MILIEUBEHE-2009` | Milieubeheer Milieubeheer | VROM/AZ/BZK/BuZa/DEF/EZ/FIN/JUS/LNV/OCW/SZW/V&W/VWS | C/S&A/09/817 C/S&A/09/818 C/S&A/09/819 C/S&A/09/815 C/S&A/09/820 C/S&A/09/821 C/S&A/09/822 C/S&A/09/824 C/S&A/09/825 C/S&A/09/816 C/S&A/09/814 C/S&A/09/826 C/S&A/09/823 | 24-04-2009/78 |  |
| `BFT-2009` | deelbeleidsterreinen Notariaat (over de periode vanaf 1999), de Gerechtsdeurwaarders (over de periode vanaf 2001) | Bureau Financieel Toezicht | C/S&A/09/329 | 08-04-2009/68 |  |
| `COORDINATI-2009` | Coordinatie Algemeen Regeringsbeleid | AZ/BZK/BuZa/DEF/EZ/FIN/JUS/LNV/OCW/SZW/V&W/VWS/VROM | NA/09/448 NA/09/449 NA/09/450 NA/09/451 NA/09/452 NA/09/453 NA/09/454 NA/09/455 NA/09/456 NA/09/547 NA/09/458 NA/09/459 NA/09/460 | 20-03-2009/53 |  |
| `IGZ-2009` | toezicht op de volksgezondheid en de gezondheidszorg in de periode 1945-heden | Inspectie Gezondheidszorg |  | 2009/41 |  |
| `MEDISCHE-2009` | Medische Beroepen en Opleidingen, 1945- | JUS/VWS | C/S&A/09/321 C/S&A/09/323 C/S&A/09/844 | 19-03-2009/54 24-04-2009/78 |  |
| `PDIREKT-2009` | P-direkt, deelbeleidsterrein Personeelsdossiers, 1945- | Tweede Kamer der Staten-Generaal | KB 16 april 2009, nr. 09.001007 | 2009/105 |  |
| `NLPVF-2009` | Stichting Nederlands Literair Productie en Vertalingenfonds, 1990- | Stichting Nederlands Literair Productie- en Vertalingenfonds | C/S&A/09/857 | 2009/106 |  |
| `RECHTSBIJS-2009` | De raden voor rechtsbijstand periode 1974- | De raden voor rechtsbijstand | C/S&A/09/1500 | 2009/106 |  |
| `BUITENLAND-2009` | Het Nederlands Buitenlands Beleid in de periode 1990 – | BuZA/Ontwikkelingsamenwerki ng | NA/09/1695 | 2009/10333 |  |
| `KNMG-2009` | Koninklijke Nederlandsche Maatschappij ter bevordering der Geneeskunst (KNMG) over periode vanaf 1932 | KNMG | NA/S&B/09/20245 | 2009/11265 |  |
| `WATERSTAAT-2009` | Waterstaat vanaf 2009- | V&W, VROM, OCW en SZW | NA/09/1198 NA/09/1999 NA/09/1997 NA/09/2000 | 2009/11915-11917-11885-11911 |  |
| `UNIV-2009` | Universiteiten vanaf 1985- | UvA/TUEindhoven/RUG/UM/UT/UU/WU/TUDelft/EUR/UL/Radboud UN/UT/VU | NA/09/2416 NA/09/2409 NA/09/2417 NA/09/2411 NA/09/2414 NA/09/2412 NA/09/2413 NA/09/2415 NA/09/2407 NA/09/2410 NA/09/2408 NA/09/2418 NA/09/2419 | 26-8-2009/12639 12650 12649 12657 12661 12665 12669 12643 12646 12651 12656 12664 12670 |  |
| `ZON-2009` | Zorgonderzoek Nederland 1995-2001 | Zon | NA/09/2684 | 6-10-2009/14999 |  |
| `ZONMW-2009` | Zorgonderzoek Nederland Medische Wetenschappen 2001- | ZonMw | NA/09/15006 | 6-10-2009/15006 |  |
| `MEDIAFONDS-2009` | Stimuleringsfonds Nederlandse Culturele Mediaproducties vanaf 1988 | Mediafonds | NA/09/2832 | 19-10-2009/15599 |  |
| `STE-2009` | Selectielijst van de Stichting Toezicht Effectenverkeer op het beleidsterrein Regulering & Toezicht bank- en kredietwezen over de periode 1992-2002 | Stichting Toezicht Effectenverkeer | NA/09/2920 | 27-10-2009/16072 |  |
| `JUS-2009` | Selectielijst, ingediend door het ministerie van Justitie voor de neerslag van de handelingen van het Nederlands Forensisch Instituut over de periode vanaf 1945. | JUS | NA/09/3018 | 16-11-2009/17122 |  |
| `OCW-2009` | Selectielijst, ingediend door de minister van Onderwijs, Wetenschap en Cultuur voor de neerslag van handelingen van het Rijksmuseum over de periode 1946 – 1995 | OCW | NA/09/3316 | 7-12-2009/18637 |  |
| `DEF-2009` | Selectielijst, ingediend door Minister van Defensie en de onder zijn zorg ressorterende actoren op het beleidsterrein toelating vreemdelingen over de periode vanaf 1945 (actualisatie). | DEF | NA/09/2496 | 20-11-2009/17682 |  |
| `SVP-2010` | Selectielijst, ingediend door het Stimuleringsfonds voor de pers voor de neerslag van het Stimuleringsfonds voor de pers (voorheen het Bedrijfsfonds voor de pers) op het beleidsterrein Media, Letteren en Bibliotheken over de periode vanaf 1974 | Stimuleringsfonds voor de Pers | NA/09/3561 | 6-1-2010/60 |  |
| `EXIM-2010` | Selectielijst, ingediend door de Nederlandse Bank voor de neerslag van de Nederlandse Bank en de onder haar zorg vallende actoren, de Rijkscommissie Export-, import- en investeringsgaranties en de Dagelijkse Commissie op het beleidsterrein: Herverzekering van export- en importkredieten en investeringsgaranties over de periode 1922-2008 | DNB (EXIM) | NA/09/3562 | 11-1-2010/129 |  |
| `PVK-2010` | Selectielijst, ingediend door de Nederlandse Bank voor de neerslag van de (Stichting Pensioen en) Verzekeringskamer (PKV) over de periode 1923 – 2004 | DNB (PVK) | NA/09/3563 | 11-1-2010/130 |  |
| `KBVG-2010` | Selectielijst, ingediend door de Koninklijke Beroepsorganisatie van Gerechtsdeurwaarders voor de neerslag van de KBvG over de periode vanaf 2001- | Koninklijke Beroepsorganisatie van Gerechtsdeurwaarders (KBvG) | NA/10/3671 | 25-1-2010/1007 |  |
| `TOELATING-2010` | Selectielijst, ingediend door de ministeries van Justitie, Binnenlandse Zaken en Koninkrijksrelaties, Buitenlandse Zaken, Economische Zaken, Onderwijs, Cultuur en Wetenschap, Volksgezondheid, Welzijn en Sport en Sociale Zaken en Werkgelegenheid voor de neerslag van de onder hen ressorterende actoren op het beleidsterrein toelating vreemdelingen over de periode vanaf 1945 (actualisatie). | JUS/BZK/BUZA/OCW/SZW/VWS/EZ | NA/09/3091 NA/09/3092 NA/09/3093 NA/09/3095 NA/09/3098 NA/09/3097 NA/09/3094 | 9-2-2010/1754 9-2-2010/1759 9-2-2010/1751 9-2-2010/1738 9-2-2010/1750 9-2-2010/1736 9-2-2010/1756 |  |
| `VOLKSHUISV-2010` | Selectielijst, ingediend door de ministers van Volkshuisvesting, Ruimtelijke Ordening en Milieubeheer en Landbouw, Natuurbeheer en Voedselkwaliteit voor de neerslag van de handelingen van de betrokken zorgdragers op het beleidterrein Volkshuisvesting over de periode vanaf 2009- | VROM/LNV | NA/09/3312 NA/09/3314 | 9-2-2010/1864 9-2-2010/1813 |  |
| `BANK-2010` | Selectielijst, ingediend door de Nederlandse Bank voor de neerslag van de Nederlandse Bank en de onder haar zorg vallende actoren, de Stichting Beleggerscompensatiefonds op de beleidsterreinen toezicht op het kredietwezen, het effectenverkeer, de regeling en het besluit particuliere participatiemaatschappijen en het bevorderen van de integriteit van het financiële stelsel over de periode vanaf 1952 | DNB (Stichting Beleggerscompensatiefo nds | NA/10/4409 | 19-4-2010/5874 |  |
| `LBIO-2010` | Selectielijst, ingediend door het Landelijk Bureau Inning Onderhoudsbijdragen (LBIO) voor de neerslag van het LBIO over de periode vanaf 1993 | LBIO | NA/10/4441 | 19-4-2010/5876 |  |
| `AFM-2010` | Selectielijst, ingediend door de Stichting Autoriteit Financiële Markten voor de neerslag van de Stichting Autoriteit Financiële Markten op het beleidsterrein regulering en toezicht bank- en kredietwezen voor de periode vanaf 2002 | AFM | NA/10/4422 | 19-4-2010/5877 |  |
| `FIN-2010` | Selectielijst, ingediend door de minister van Financiën voor de Belastingdienst op het terrein Douane over de periode vanaf 1996 | FIN | NA/10/4408 | 3-5-2010/6684 |  |
| `KVKS-2010` | Selectielijst, ingediend door de Kamers van Koophandel en Fabrieken Nederland in dezen optredend als gemandateerde van de Kamers van Koophandel en Fabrieken, voor de neerslag van de Kamers van Koophandel en Fabrieken over de periode vanaf 1945 | KVKs | NA/10/6572 | 21-12-2010/20483 |  |
| `FCP-2010` | Selectielijst, ingediend door de Stichting Fonds voor Cultuurparticipatie voor de neerslag van de Stichting Fonds voor Cultuurparticipatie over de periode vanaf 2008 | FCP | NA/10/6575 | 21-12-2010/20486 |  |
| `NFPK-2010` | Selectielijst, ingediend door het Nederlands Fonds voor de Podiumkunsten+ voor de neerslag van het Nederlandse Fonds voor de Podiumkunsten+ voor Cultuurparticipatie over de periode vanaf 2007 | NFPK+ | NA/10/6576 | 21-12-2010/20485 |  |
| `OOG-2010` | Selectielijst, ingediend door de Orde van Octrooigemachtigden voor de neerslag van de Orde van Octrooigemachtigden over de periode vanaf 1936 | OOG | NA/10/6574 | 21-12-2010/20489 |  |
| `NCDO-2011` | Selectielijst, ingediend door de Nationale Commissie voor internationale samenwerking en duurzame ontwikkeling voor de neerslag van de Nationale Commissie voor internationale samenwerking en duurzame ontwikkeling op het beleidsterrein ontwikkelingssamenwerking over de periode vanaf 1996 | NCDO | NA/10/6.357 | 11-01-2011/339 |  |
| `NZA-2011` | Selectielijst, ingediend door de Nederlandse Zorgautoriteit voor de neerslag van de Nederlandse Zorgautoriteit en haar rechtsvoorgangers op het beleidsterrein toezicht en regulering in de gezondheidszorg over de periode vanaf 1949. | Nza | NA/10/6723 | 17-01-2011/659 |  |
| `CBZ-2011` | Selectielijst, ingediend door het College Bouw Zorginstellingen voor de neerslag van het College Bouw Zorginstellingen over de periode 2000 tot en met 2010. | CBZ | NA/2011/7131 | 09-03-2011/4090 |  |
| `NPO-2011` | Selectielijst, ingediend door de Nederlandse Publieke Omroep voor de neerslag van de Nederlandse Publieke Omroep voor de periode vanaf 1969- | NPO | NA/2011/7541 | 06-05-2011/7817 |  |
| `RWI-2011` | Selectielijst, ingediend door de Raad voor Werk en Inkomen voor de neerslag van de Raad voor Werk en Inkomen Rijksgebouwendienst op het PIOFACH terrein voor de periode vanaf 2002- | RWI | NA/2011/7542 | 06-05-2011/7818 |  |
| `KB-2011` | Selectielijst, ingediend door de Koninklijke Bibliotheek voor de neerslag van de Koninklijke Bibliotheek voor de periode vanaf 1945- | KB | NA/2011/7762 | 26-05-2011/8814 |  |
| `NIFV-2011` | Selectielijst, ingediend door het Nederlands Instituut voor Fysieke Veiligheid voor de neerslag van het Nederlands Instituut voor Fysieke Veiligheid en taakvoorganger, voor de periode vanaf 1996- | NIFV | NA/2011/7763 | 26-05-2011/8815 |  |
| `DLO-2011` | Selectielijst, ingediend door de Stichting Dienst Landbouwkundig Onderzoek (middels de Wageningen Universiteit en Researchcentrum) voor de neerslag van de Stichting Dienst Landbouwkundig Onderzoek voor de periode vanaf 1999- | DLO | NA/2011/7776 | 26-05-2011/9083 |  |
| `RGD-2011` | Selectielijst, ingediend door het Ministerie van Volkshuisvesting, Ruimtelijke Ordening en Milieubeheer (VROM) voor de neerslag van de Rijksgebouwendienst op het beleidsterrein rijkshuisvesting voor de periode vanaf 2010- | RGD | NA/2011/7586 | 15-06-2011/10300 |  |
| `SKAL-2011` | Selectielijst, ingediend door de Stichting Skal voor de neerslag van de Stichting Skal en haar rechtsvoorgangers op het beleidsterrein Landbouwkwaliteit en voedselveiligheid en kwaliteit van het uitgangsmateriaal, voor de periode vanaf 1985- | Stichting Skal | NA/2011/7984 | 07-07-2011/12146 |  |
| `OPTA-2011` | Selectielijst, ingediend door de Onafhankelijke Post en Telecommunicatie Autoriteit voor de neerslag van de Onafhankelijke Post en Telecommunicatie Autoriteit voor de periode vanaf 1997 – | OPTA | NA/2011/7349 | 11-07-2011/12333 |  |
| `VWS-2011` | Algemeen Wetenschappelijke Voorbereiding Regeringsbeleid | VWS | NA/11/8122 | 19-08-2011/15086 |  |
| `RECHTERLIJ-2011` | Rechterlijke macht | 5 Gerechtshoven/19 Rechtbanken | NA/11/8044 | 23-09-2011/17020 |  |
| `RVS-2011` | Bestuursrechtspraak en algemene bedrijfsvoering | RvS | KB/14/11/2011 nr.11.002711 | 1-12-2011/21590 |  |
| `WS-2011` | Selectielijst, ingediend door de Unie van Waterschappen voor de neerslag van de Waterschappen voor de periode vanaf 2012 – | Unie van Waterschappen | NA/11/8858 | 7-12-2011/22255 |  |
| `SAXION-2011` | Selectielijst, ingediend door het College van Bestuur Stichting Saxion voor wat betreft de werkprocessen van Stichting Saxion en taakvoorganger Hogeschool Enschede over de periode vanaf 30 december 1988 – | Stichting Saxion | NA/11/8853 | 9-12-2011/22231 |  |
| `VJ-2011` | Selectielijst, ingediend door het Ministerie van Veiligheid en Justitie voor de administratieve neerslag van het handelen van het Centraal Justitieel Incasso Bureau (CJIB) over de periode vanaf 1990 – | V&J | NA/11/8808 | 16-12-2011/22764 |  |
| `OCW-2012` | Selectielijst, ingediend door het Ministerie van Onderwijs, Cultuur en Wetenschap voor de neerslag op het beleidsterrein Monumentenzorg, (actualisatie) over de periode vanaf 1945 – | OC&W | NA/2011/8861 | 4-1-2012/117 |  |
| `RDW-2012` | Selectielijst, ingediend door de Rijksdienst voor Wegverkeer (RDW) voor de neerslag van de handelingen de Rijksdienst voor Wegverkeer over de periode vanaf 1996 – | RDW | NA/2011/8957 | 9-1-2012/150 |  |
| `PVIS-2012` | Selectielijst, ingediend door de Productschap Vis voor de neerslag van de archiefbescheiden van het Productschap Vis over de periode vanaf 1956 – | Pvis | NA/2011/8959 | 18-1-2012/924 |  |
| `HUURCOMMISSI-2012` | Selectielijst, ingediend door het Ministerie van Binnenlandse Zaken en Koninkrijksrelaties voor de neerslag van de Huurcommissie op het beleidsterrein Wonen (Volkshuisvestiging) over de periode vanaf 2009 – | BZK (Huurcommissie) | NA/2012/8862 | 25-1-2012/1326 |  |
| `BELASTING-2012` | Selectielijst, ingediend door het Ministerie van Financiën, voor de administratieve neerslag voor wat betreft de werkprocessen van Belastingdienst, voor het onderdeel Belastingregio’s (fiscale processen), over de periode vanaf 2007 – | FIN (Belastingdienst) | NA/12/8962 | 21-2-2012/3159 |  |
| `KCB-2012` | Selectielijst, ingediend door het Kwaliteits Controle Bureau voor de neerslag van het Kwaliteits Controle Bureau over de periode vanaf 1977 – | KCB | NA/12/8998 | 5-3-2012/4152 |  |
| `BUZA-2012` | Selectielijst voor de neerslag van organisatieonderdelen van het Ministerie van Buitenlandse Zaken die belast zijn met de bedrijfsvoering van het departement 1985 – 2010 | BuZa | NA/12/8964 | 8-3-2012/4381 |  |
| `KIWA-2012` | Selectielijst, ingediend door Kiwa N.V., voor de neerslag van de handelingen per werkterrein, waarvoor Kiwa N.V. door de overheid is gemandateerd, over de periode vanaf 1996 – | KIWA | NA/2012/9320 | 3-4-2012/6438 |  |
| `POLAC-2012` | Selectielijst, ingediend door de Politieacademie voor de neerslag van de Politieacademie en rechtsvoorganger op het beleidsterrein Politie over de periode vanaf 1992 – | Politieacademie | NA/2012/9321 | 3-4-2012/6440 |  |
| `NVAO-2012` | Selectielijst, ingediend door de Nederlands-Vlaamse Accreditatieorganisatie voor de neerslag van de Nederlands-Vlaams Accreditatieorganisatie en diens taakvoorganger de Nederlandse Accreditatieorganisatie over de periode vanaf 2002 – | NVAO | NA/2012/9648 | 23 april 2012/7827 |  |
| `GEM-2012` | Gemeentelijke en intergemeentelijke organen | VNG | NA/2012/3900 (21-06-12) | 25-06-12/11906 |  |
| `PRORAIL-2012` | ProRail | ProRail | NA/12/9546 (07-06-2012) | 21-06-12/12304 |  |
| `VJ-2012` | Selectielijst, ingediend door het Ministerie van Veiligheid en Justitie, voor de neerslag van de handelingen van het Ministerie van Veiligheid en Justitie en diens taakvoorganger Ministerie van Justitie, op het beleidsterrein Toezicht Rechtspersonen, over de periode vanaf 1945- | V&J | NA/2012/9541 | 02-07-12/13216 |  |
| `METCS-2012` | BSD, voor de neerslag van de handelingen van Medisch Ethische Toetsingscommissies (METC’s) van algemene ziekenhuizen en zelfstandige stichtingen in Nederland en de Vrije Universiteit te Amsterdam, over de periode vanaf 1999 | METC’s | NA/2012/10.505 | 23-10-12/21758 |  |
| `NOVA-2012` | Selectielijst (actualisatie), ingediend door de Nederlandse Orde van Advocaten namens de Algemene Raad van de Nederlandse Orde van Advocaten en de Raden van Toezicht van de 19 orde van Advocaten in de arrondissement, voor de archiefbescheiden van Algemene Raad van de Nederlandse orde van Advocaten en de Raden van de Orden van Advocaten in de Arrondissementen, over de periode vanaf 1952- | Nederlandse Orde van Advocaten | NA/2012/8813 | 26-10-12/21783 |  |
| `VWS-2012` | Selectielijst, ingediend door de minister van Volksgezondheid, Welzijn en Sport, voor de neerslag van de handelingen van het Klantenloket EPD, zoals uitgevoerd door Nictiz (Stichting Nationaal ICT Instituut in de zorg), over de periode 2008-2011 | VWS | NA/2012/10.509 | 02-11-12/22256 |  |
| `NAKTUINBOUW-2012` | Selectielijst, ingediend door de Nederlandse Algemene Kwaliteitsdienst Tuinbouw (Naktuinbouw), voor de neerslag van de handelingen van Naktuinbouw en haar rechtsvoorgangers (NAKG, NAKB, NAKS), over de periode vanaf (1941) 1966- | NAKtuinbouw | NA/2012/10.498 | 07-11-12/22841 |  |
| `RHC-2012` | Selectielijst, ingediend door de werkgroep Selectielijst Regionaal Historische Centra, voor archiefbescheiden van Regionaal Historisch Centra met de provincie als werkgebied, over de periode vanaf 1 mei 1998 – | RHC’s | NA/2012/8812 | 09-11-12/22829 |  |
| `HOGERAAD-2012` | Selectielijst, ingediend door de Hoge Raad der Nederlanden, voor de archiefbescheiden van de Hoge Raad op het beleidsterrein rechterlijke macht, over de periode vanaf 1945- | V&J (Hoge Raad) | NA/2012/10.355 | 10-12-12/25306 |  |
| `BFT-2012` | BSD, ingediend door het Bureau Financieel Toezicht (BFT) en de Commissie van deskundigen Gerechtsdeurwaarders en de Commissie van deskundigen Notarissen, voor de neerslag van de handelingen van het Bureau Financieel Toezicht (BFT) en de Commissie van Deskundigen op de deelbeleidsterreinen: a. Integraal toezicht op de notarissen, toegevoegd notarissen en kandidaat-notarissen (financieel toezicht over de periode vanaf 1999, kwaliteits- en integriteitstoezicht over de periode vanaf 2013), b. financieel toezicht op gerechtsdeurwaarders en kandidaat-gerechtsdeurwaarders over de periode vanaf 2001, en c. toezicht op notarissen, toegevoegd notarissen, kandidaat-notarissen, accountants, belastingadviseurs, bedrijfseconomische adviseurs en onafhankelijke juridische adviseurs ten aanzien van de naleving van de Wet ter voorkoming van witwassen en financieren van terrorisme over de periode vanaf 2003. | BFT | NA/2012/11057 | 21-12-12/26590 |  |
| `BOSSCHAP-2013` | Selectielijsten, ingediend door het Bosschap, voor de neerslag van de handelingen van het Bosschap, over de periode vanaf 2009- | Bosschap | NA/2012/11.270 | 29-01-2013/1885 |  |
| `VWS-2013` | Selectielijst (actualisatie), ingediend door de minister van Volksgezondheid, Welzijn en Sport, voor de neerslag van de handelingen van het Ministerie van VWS op het beleidsterrein Planning van voorzieningen in de gezondheidszorg, over de periode vanaf 1945- | VWS | NA/2012/11.272 | 11-02-2013/3105 |  |
| `CPE-2013` | Selectielijst, ingediend door het Controlebureau voor Pluimvee, Eieren en Eiproducten (CPE), voor de neerslag van de handelingen van het CPE, over de periode 1988 – 1 juli 2012 | CPE | NA/2012/11.281 | 15-2-2013/3763 |  |
| `UMC-2013` | Selectielijsten (actualisatie), voor de neerslag van de handelingen van de Openbare en Bijzondere Universitaire Medische Centra (UMC), alsmede de bij de UMC geplaatste Medisch-Ethische Toetsingscommissies (METC’s), over de periode vanaf 1985 | UMC METC’s | NA/2012/11.274 | 22-2-2013/4469 |  |
| `WRR-2013` | Selectielijst, ingediend door de Wetenschappelijke Raad voor het Regeringsbeleid (WRR), voor de archiefbescheiden van de Wetenschappelijke Raad voor het Regeringsbeleid op het beleidsterrein algemene wetenschappelijke beleidsvoorbereiding, over de periode vanaf 2012 | WRR | NA/2013/11.287 | 10-4-2013/9246 |  |
| `PZ-2013` | Selectielijst, ingediend door het Productschap Zuivel, voor de neerslag van de handelingen van het Productschap Zuivel, over de periode vanaf 2000 | PZ | NA/2013/11.297 | 18-4-2013/10326 |  |
| `HBO-2013` | Selectielijst voor de administratieve neerslag van de openbaar gezagtaken van de bij de Vereniging van hogescholen aangesloten hogescholen: Amsterdamse Hogeschool voor de Kunsten, ArtEZ hogeschool voor de kunsten, Avans Hogeschool, Aeres Groep (CAH Vilentum en Stoas Vilentum), Christelijke Hogeschool Ede, Christelijke Hogeschool Windesheim, Codarts Rotterdam, De Haagse Hogeschool, Design Academy Eindhoven, Driestar Hogeschool, Fontys Hogescholen, Gereformeerde Hogeschool, Gerrit Rietveld Academie, Hanzehogeschool Groningen, HAS Den Bosch, Hogeschool van Arnhem en Nijmegen, Hogeschool de Kempel, Hogeschool der Kunsten Den Haag, Hogeschool Inholland, Hogeschool iPabo, Hogeschool Leiden (inclusief Hogeschool Helicon), Hogeschool Rotterdam, Hogeschool Utrecht, Hogeschool van Amsterdam, Hogeschool Van Hall Larenstein, Hogeschool voor de Kunsten Utrecht, Hotelschool Den Haag, HZ University of Applied Sciences, Iselinge Hogeschool, Katholieke Pabo Zwolle, Marnix Academie, NHL Hogeschool, NHTV internationaal hoger onderwijs Breda, Saxion (inclusief Hogeschool Edith Stein), Stenden Hogeschool, Zuyd Hogeschool, over de periode vanaf 8 oktober 1992. | Hogescholen | NA/2013/11.304 | 27-5-2013/14186 |  |
| `SAB-2013` | Selectielijst, ingediend door de Stichting Afvalstoffen & Vaardocumenten Binnenvaart, voor de administratieve neerslag van de Stichting Afvalstoffen & Vaardocumenten Binnenvaart, over de periode vanaf 1993 | SAB | NA/2013/11.953 | 20-8-2013/23204 |  |
| `FIN-2013` | Selectielijst, ingediend door de Minister van Financiën, voor de administratieve neerslag van de primaire werkprocessen van Belastingdienst/FIOD, over de periode vanaf 1945 | FIN | NA/2013/11.952 | 15-10-2013/28448 |  |
| `BHC-2013` | Selectielijst, ingediend door het Bedrijfschap Horeca en Catering, voor de neerslag van de handelingen van het Bedrijfschap Horeca en Catering, over de periode vanaf 1954 | BHC | NA/2013/12.300 | 13-12-2013/34874 |  |
| `EK-2013` | Selectielijst voor de Eerste Kamer der Staten-Generaal op het deelbeleidsterrein van personeelszaken, t.w. het personeelsdossier, over de periode vanaf 1946 | Eerste Kamer der Staten-Generaal | KB/27/11/2013 nr. 2013002424 | 31-12-2013/36674 |  |
| `BUZABUITENLA-2013` | Selectielijst, ingediend door de minister van Buitenlandse Zaken, van de archiefbescheiden op het beleidsterrein Nederlands Buitenlands Beleid, over de periode vanaf 1990 | BuZa | NA/2013/12.299 | 31-12-2013/36667 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `BUZABUITENLB-2013` | Selectielijst, ingediend door de minister van Buitenlandse Zaken, van de archiefbescheiden op het beleidsterrein Buitenland, over de periode 1945-1990 | BuZa | NA/2013/13.044 | 31-12-2013/36665 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `BUZAONTWIKKE-2013` | Selectielijst, ingediend door de minister van Buitenlandse Zaken, van de archiefbescheiden op het beleidsterrein Ontwikkelingssamenwerking, over de periode 1965-1990 | BuZa | NA/2013/13.045 | 31-12-2013/36668 |  |
| `PROV-2014` | Selectielijst, ingediend door het bestuur van het Interprovinciaal Overleg (IPO), voor archiefbescheiden van de provinciale organen ontvangen of opgemaakt vanaf 1 januari 2014 | Gedeputeerde Staten | NA/2013/13.088 | 17-01-2014/1042 |  |
| `PROVCDK-2014` | Selectielijst voor archiefbescheiden van de Commissaris van de Koning als rijksorgaan, ontvangen of opgemaakt vanaf 1 januari 2014 | Commissaris van de Koning als rijksorgaan | NA/2013/13.089 | 17-01-2014/1050 |  |
| `PARTICIPATIE-2014` | Selectielijst voor de neerslag van de handelingen van de Stichting Participatiefonds voor het onderwijs, over de periode vanaf 1995 | Participatiefonds | NA/2014/13.074 | 14-02-2014/4026 |  |
| `VERVANGINGSF-2014` | Selectielijst voor de neerslag van de handelingen van de Stichting Vervangingsfonds en Bedrijfsgezondheidszorg voor het Onderwijs, over de periode vanaf 1992 | Vervangingsfonds | NA/2014/13.075 | 14-02-2014/4027 |  |
| `DEF-2014` | Generieke selectielijst voor de archiefbescheiden van het ministerie van Defensie vanaf 1945 | DEF | NA/2014/13082 | 05-03-2014/5937 |  |
| `BKD-2014` | Selectielijst voor de documentaire neerslag van de Bloembollenkeuringsdienst (BKD), vanaf 1979 | BKD | NA/2014/13977 | 29-07-2014/21353 |  |
| `RIJKSMUSEA-2014` | BSD, i ngediend door de Vereniging van Rijksmusea (VRM), voor de neerslag van de handelingen van de Rijksmuseale instellingen, voor de periode 1946-1995 | Rijksmuseale instellingen | NA/2014/14285 | 30-07-2014/21516 |  |
| `JEUGDZORG-2014` | BSD, ingediend door Jeugdzorg Nederland, voor de neerslag van de handelingen van de Bureaus Jeugdzorg, voor de periode vanaf 1995 | Bureaus Jeugdzorg | NA/2014/14284 | 30-07-2014/21517 |  |
| `COA-2014` | Selectielijst voor de neerslag van het handelen (de processen) van het COA, periode vanaf (2011)2013 en BSD (actualisatie) voor de administratieve neerslag van het handelen van het COA in de periode 1994 – (2010)2012’ | COA | NA/2014/14088 | 15-08-2014/23119 |  |
| `DNB-2014` | Selectielijst voor de neerslag van het handelen van De Nederlandsche Bank met betrekking tot de inrichting en organisatie als centrale bank vanaf 1992, de monetaire autoriteit van 1992 tot 1999, op het beleidsterrein betalingsverkeer vanaf 1992, ten aanzie n van wetenschappelijk onderzoek vanaf 1983 en statistiek vanaf 1992, en van het handelen van de Bankraad van (1948) 1992 tot 1999 | DNB | NA/14/14102 | 8-09-2014/25072 |  |
| `COKZ-2014` | Selectielijst voor de neerslag van het handelen van het Centraal Orgaan voor Kwaliteitsaangelegenheden in de Zuivel (COKZ) en haar rechtsvoorgangers, over de periode vanaf het jaar (1901) 1975 | COKZ | NA/2014/14100 | 6-10-2014/27800 |  |
| `NFPK-2014` | Selectielijst, ingediend door het Nederlands Fonds voor de Podiumkunsten+ voor de neerslag van het Nederlandse Fonds voor de Podiumkunsten+ voor Cultuurparticipatie over de periode vanaf 2007 (actualisatie) | NFPK+ | NA/2014/14740 | 30-10-2014/31583 |  |
| `FGZP-2014` | Selectielijst voor de administratieve neerslag van de openbaar gezagtaken van de FGzP (Federatie van gezondheidszorgpsychologen) over de periode vanaf 27 februari 2002 | FGzP | NA/2014/14967 | 17-12-2014/36133 |  |
| `OU-2014` | Selectielijst voor de neerslag van de handelingen van de Open Universiteit en de onder hem ressorterende actoren op het beleidsterrein Wetenschappelijk onderwijs over de periode vanaf 1985 (voor de selectielijst zie BSD Universiteiten vanaf 1985, 26-8-2009/12639 e.v.) | OU | NA/2014/14886 | 19-12-2014/36532 |  |
| `NOM-2015` | Selectielijst voor de neerslag van het handelen van de Nationale Ombudsman, vanaf 1998, en de Kinderombudsman, vanaf 2011 | Nationale Ombudsman Kinderombudsman | KB 12/01/2015 Nr. 2015000006 | 5-2-2015/3086 |  |
| `ZFR-2015` | Selectielijst voor de neerslag van de PIOFACH-handelingen van de Ziekenfondsraad en de neerslag van haar commissies, over de periode 1949 –1999 | ZFR | NA/2015/15260 | 16-2-2015/4007 |  |
| `SACN-2015` | Selectielijst voor de neerslag van het handelen van de Stichting Airport Coordination Netherlands (SACN), over de periode vanaf 01 november 1997 | SACN | NA/2014/15051 | 20-2-2015/4679 |  |
| `BUZA-2015` | Selectielijst van het Ministerie van Buitenlandse Zaken voor de archieven gevormd vanaf de overgang naar digitale archivering in de periode (2009) 2012-2014 | BuZa | NA/2015/15261 | 3-3-2015/5623 |  |
| `EGI-2015` | Selectielijst voor de neerslag van de handelingen van de Erfgoedinspectie en haar rechtstaakvoorgangers, voor de periode vanaf (1993) 2001 | EGI | NA/2015/15414 | 27-3-2015/8328 |  |
| `SZW-2015` | Selectielijst van het Ministerie van Sociale Zaken en Werkgelegenheid voor de waardering en selectie van archiefbescheiden vanaf (2002) 2006 | SZW | NA/2015/15083 Aanvulling: NA/2025/52730706 | 27-3-2015/8231 Aanvulling: 25-09-2025/32240 |  |
| `STODEL-2015` | Selectielijst voor de neerslag van de processen van de Nederlandse loodsencorporatie ( NLc), STODEL (Stichting Opleiding en Deskundigheidsbevordering Registerloodsen), de regionale loodsencorporaties (rlc’s) en het Nederlands Loodswezen BV (NLBV) voor de periode vanaf 1988 | Loodswezen | NA/2015/15645 | 18-5-2015/13105 |  |
| `ZIN-2015` | Selectielijst voor de neerslag van het College voor Zorgverzekeringen (CVZ) voor de periode 1 juli 1999-1 april 2014 en van Zorginstituut Nederland (ZIN) voor de periode vanaf 1 april 2014 | ZIN | NA/2015/15646 | 18-5-2015/13106 |  |
| `KADASTER-2015` | Selectielijst voor de neerslag van het handelen van de Dienst voor het Kadaster en de openbare registers over de periode vanaf 1945 (actualisatie 2015) | Kadaster | NA/2015/15420 | 20-5-2015/13417 |  |
| `KNAW-2015` | Selectielijst voor het organisatiearchief van de Koninklijke Nederlandse Akademie van Wetenschappen (KNAW), gevormd in de periode vanaf 1945 | KNAW | NA/2015/15698 | 26-9-2015/17424 |  |
| `GSP-2015` | Selectielijst voor de archiefbescheiden van de overheids-NV Groningen Seaports en taakvoorgangers, voor de periode vanaf 1997 | Groningen Seaports | NA/2015/15874 | 21-7-2015/20714 |  |
| `CFV-2015` | Selectielijst voor de neerslag van de handelingen van het Centraal Fonds Volkshuisvesting, voor de periode vanaf 1988 | CFV | NA/2015/15873 | 21-8-2015/25878 |  |
| `BELASTING-2015` | Selectielijst, ingediend door het Ministerie van Financiën, voor de administratieve neerslag voor de werkprocessen van de Belastingdienst Toeslagen over de periode vanaf 2004 | FIN (Belastingdienst) | NA/2015/16012 | 25-9-2015/31399 |  |
| `FIN-2015` | Selectielijst voor de archiefbescheiden van het kerndepartement van het ministerie van Financiën vanaf 1 januari 2010 | FIN | NA/2015/16013 | 25-9-2015/31395 |  |
| `CBR-2015` | Selectielijst voor het CBR over de periode vanaf 1927 | CBR | NA/2015/15818 | 9-12-2015/44311 |  |
| `SGM-2015` | Selectielijst voor het Schadefonds Geweldsmisdrijven over de periode vanaf 1976 (actualisatie 2014) | Schadefonds Geweldsmisdrijven | NA/2015/15817 | 9-12-2015/44312 |  |
| `BZK-2016` | Selectielijst voor de Algemene Inlichtingen- en Veiligheidsdienst (AIVD) en de nog niet overgedragen archiefbescheiden van zijn voorgangers de Centrale Veiligheidsdienst (CVD) en de Binnenlandse Veiligheidsdienst (BVD) vanaf 1946 | BZK | NA/2016/16431 | 25-4-2016/20699 |  |
| `DEF-2016` | Selectielijst voor de Militaire Inlichtingen- en Veiligheidsdienst (MIVD) en de nog niet overgedragen archiefbescheiden van zijn voorgangers de MID (Marine Inlichtingendienst (1941 – 1944), Marine Intelligentiedienst (1946-1947), Militaire Inlichtingendienst van de landmacht (1949 –1972), Militaire Inlichtingendienst (1987 –2003), Landmacht Inlichtingendienst (LAMID), Luchtmacht Inlichtingendienst (LUID) en Marine Inlichtingendienst (MARID) vanaf 1945 | DEF | NA/2016/16432 | 25-4-2016/20700 |  |
| `FINANCIENA-2016` | Selectielijst, ingediend door de Minister van Financiën, voor de administratieve neerslag van de beleids- en ondersteunende processen van Belastingdienst, over de periode vanaf 2007 | FIN | NA/2016/16438 | 4-5-2016/22487 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `FINANCIENB-2016` | Selectielijst, ingediend door de Minister van Financiën, voor de administratieve neerslag van de werkprocessen van de Belastingdienst/Centrale Administratie, over de periode vanaf 2007 | FIN | NA/2016/16439 | 4-5-2016/22488 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `KK-2016` | Selectielijst voor de selectie van de administratieve neerslag van het handelen van het Kabinet van de Koning vanaf 30 april 2013 | KK | KB 17/06/2016 Nr. 2016001047 | 29-7-2016/39845 |  |
| `PDIREKTA-2016` | P-Direkt/ personeelsdossier | AZ, BZK, BZ, EZ, FIN, I&M, OCW, SZW, VWS, V&J | NA/2016/1075020 | 18-11-2016/61351 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `PDIREKTB-2016` | P-Direkt/ personeelsdossier | ARK, KK, KNO, NOM | KB 24/10/2016 Nr. 2016001830 | 18-11-2016/61358 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `UWV-2017` | Selectielijst voor de administratieve neerslag van het Uitvoeringsinstituut werknemersverzekeringen (UWV) over de periode vanaf 2014 | UWV | NA/2017/1143312 | 20-02-2017/9044 |  |
| `TNO-2017` | Selectielijst voor de administratieve neerslag van de handelingen van de Nederlandse Organisatie voor Toegepast Natuurwetenschappelijk Onderzoek (TNO) in de periode vanaf 1932 | TNO | NA/2017/1157282 | 24-03-2017/16383 |  |
| `IM-2017` | Selectielijst van het ministerie van Infrastructuur en Milieu voor de waardering en selectie van archiefbescheiden over de periode vanaf 2010 | I&M | NA/2017/1142828 | 03-04-2017/18128 |  |
| `RIVM-2017` | Selectielijst voor de administratieve neerslag van het Rijksinstituut voor Volksgezondheid en Milieu (RIVM) vanaf 1 januari 2004 | VWS, I&M | NA/2017/1170706 | 14-04-2017/20886 |  |
| `MBO-2017` | Selectielijst voor de administratieve neerslag van de openbaar gezagtaken van de MBO-instellingen over de periode vanaf 1 augustus 2017 | MBO-instellingen | NA/2017/1185648 | 30-5-2017/29487 |  |
| `KVK-2017` | Selectiedocument Kamer van Koophandel vanaf 2014 | Kamer van Koophandel | NA/2017/1193457 | 23-06-2017/34739 |  |
| `GEM-2017` | Selectielijst voor de archiefbescheiden van gemeentelijke en intergemeentelijke organen opgemaakt of ontvangen over de periode vanaf 1 januari 2017 | Gemeentelijke en intergemeentelijke organen | NA/2017/1217430 | 06-07-2017/38013 |  |
| `CIZ-2017` | Selectielijst CIZ vanaf 2005 | Centrum Indicatiestelling Zorg | NA/2017/1208828 | 24-07-2017/42011 |  |
| `KNO-2017` | Selectielijst voor de Kanselarij der Nederlandse Orden, het Kapittel voor de Civiele Orden en het Kapittel der Militaire Willems-Orde vanaf 1945 | Kanselarij der Nederlandse Orden | NA/2017/1230595 | 25-09-2017/53621 |  |
| `RVA-2017` | Selectielijst voor de neerslag van handelingen van de Raad voor Accreditatie Voor de periode vanaf 1995 | Raad voor Accreditatie | NA/2017/1241217 | 15-09-2017/51956 |  |
| `RDW-2017` | Selectielijst RDW 2017 voor het selecteren van te vernietigen en permanent te bewaren informatie vanaf 1996 | Dienst Wegverkeer | NA/2017/1240240 | 03-10-2017/55377 | Jaartal uit de titel. |
| `CSZ-2017` | Selectielijst College Sanering Zorginstellingen 1981 – (Actualisatie 2017) | College Sanering Zorginstellingen | NA/2017/1253288 | 05-10-2017/56058 |  |
| `VWS-2017` | Selectielijst Centrale Commissie Behandeling Heroïneverslaafden 1996-2010 | VWS | NA/2017/1241183 | 13-10-2017/58005 |  |
| `NZA-2017` | Selectielijst van de Stichting DBC-Onderhoud 2004-2017 en de Nederlandse Zorgautoriteit 2006- | Nza | NA/2017/1258835 | 01-11-2017/61805 |  |
| `KNB-2017` | Selectielijst voor de Koninklijke Notariële Beroepsorganisatie vanaf 2013 | KNB | NA/2017/1263254 | 01-11-2017/61800 |  |
| `CEA-2017` | Selectielijst Commissie Eindtermen Accountants-opleiding (CEA) vanaf 2005 | Fin | NA/2017/1252333 | 16-11-2017/65364 |  |
| `CM-2017` | Selectielijst voor archiefbescheiden van het Commissariaat voor de Media vanaf 1 januari 2017 | CM | NA/2017/1279308 | 24-11-2017/67168 |  |
| `PROV-2017` | Selectielijst voor archiefbescheiden van de provinciale organen ontvangen of opgemaakt vanaf 1 januari 2014 | Gedeputeerde Staten | NA/2017/1286218 | 14-12-2017/71583 |  |
| `PROVCDK-2017` | Selectielijst voor archiefbescheiden van de Commissaris van de Koning als rijksorgaan, ontvangen of opgemaakt vanaf 1 januari 2014 | Commissaris van de Koning als rijksorgaan | NA/2017/1286225 | 14-12-2017/71588 |  |
| `IFV-2018` | Selectielijst Instituut Fysieke Veiligheid van toepassing vanaf 1 januari 2013 | Instituut Fysieke Veiligheid | NA/2017/1291723 | 17-01-2018/2079 |  |
| `TUVQA-2018` | Selectielijst voor de neerslag van het handelen per werkterrein waarvoor TÜV Nederland QA B.V. door de overheid gemandateerd is vanaf 2000 | TÜV Nederland QA B.V. | NA/2018/1339883 | 05-04-2018/18840 |  |
| `COGEM-2018` | Selectielijst voor de administratieve neerslag van de Commissie Genetische Modificatie (COGEM) vanaf 1995 | Commissie Genetische Modificatie | NA/2018/1349769 | 04-05-2018/23772 |  |
| `LVNL-2018` | Selectielijst voor de archiefbescheiden van LVNL vanaf 1993 | LVNL | NA/2018/1363588 | 31-05-2018/29651 |  |
| `SVWN-2018` | Selectielijst voor de neerslag van handelingen van Stichting Visitatie Woningcorporaties Nederland voor de periode vanaf 2015 | SVWN | NA/2018/1365742 | 07-06-2018/31311 |  |
| `ACM-2018` | Selectielijst Autoriteit Consument en Markt (ACM) en voorgangers van ACM vanaf 1997 | ACM | NA/2018/1375133 NA/2026/66095104 | 29-6-2018/36077 28-9-2026/33598 |  |
| `OCW-2018` | Generieke selectielijst Onderwijs, Cultuur en Wetenschap (OCW) vanaf 2008 | OCW | NA/2018/1370571 | 03-07-2018/36531 |  |
| `RECHTSPRAAK-2018` | Bedrijfsvoering en Beleid van ‘deRechtspraak’, Selectielijst voor de waardering van alle niet-rechtszaak-gebonden stukken, ontvangen of opgemaakt vanaf 1 januari 2002 | De Rechtspraak | NA/2018/1382594 | 20-07-2018/40750 |  |
| `ECONOMISCH-2018` | Selectielijst voor de archiefbescheiden van het Ministerie van Economische Zaken en Klimaat en het Ministerie van Landbouw, Natuur en Voedselkwaliteit en taakvoorgangers vanaf 2000 | EZ/LNV | NA/2018/1368953 | 09-08-2018/44941 |  |
| `CIBG-2018` | Generieke Selectielijst voor de archiefbescheiden van het CIBG Dienst voor registers vanaf 1995-vallend onder het zorgdragerschap van het Ministerie van Volksgezondheid, Welzijn en Sport en Stichting Donorgegevens Kunstmatige Bevruchting vanaf 1995 | VWS/Stichting Donorgegevens Kunstmatige Bevruchting | NA/2018/1392382 | 27-08-2018/47836 |  |
| `KSA-2018` | Selectielijst Kansspelautoriteit 2018 voor het selecteren van te vernietigen en permanent te bewaren archiefbescheiden vanaf 1 april 2012 – | Kansspelautoriteit | NA/2018/1411294 | 26-9-2018/53738 | Jaartal uit de titel. |
| `CAK-2018` | Selectielijst voor de archiefbescheiden betreffende de publiekrechtelijke taken van het CAK vanaf 2007 en zijn bedrijfsvoeringstaken vanaf 1968 | CAK | NA/2018/1427322 | 29-10-2018/60331 |  |
| `VVN-2019` | Selectielijst van de beroepsvereniging Verpleegkundigen & Verzorgenden Nederland (V&VN) en rechtsvoorganger vanaf 2009 | Beroepsvereniging Verpleegkundigen & Verzorgenden Nederland (V&VN) | NA/2019/7945725 | 26-04-2019/22949 |  |
| `BZK-2019` | Selectielijst van het ministerie van Binnenlandse zaken en Koninkrijksrelaties voor de waardering en selectie van archiefbescheiden vanaf 1 januari 2003 | Ministerie van Binnenlandse zaken en Koninkrijkrelaties | NA/2019/8354318 | 09-08-2019/44424 |  |
| `VWS-2019` | Generieke selectielijst van het Ministerie van Volksgezondheid, Welzijn en Sport-Organisatieonderdeel: Kerndepartement vanaf 18 maart 2013 | Ministerie van Volksgezondheid, Welzijn en Sport | NA/2019/16427592 | 13-09-2019/50340 |  |
| `AFM-2019` | Selectielijst van de Stichting Autoriteit Financiële Markten vanaf 2002 | Stichting Autoriteit Financiële Markten (AFM) | NA/2019/16608716 | 24-09-2019/51978 |  |
| `DBC-2019` | Selectielijst van de Stichting DBC-Onderhoud voor de periode vanaf 2004 en de Nederlandse Zorgautoriteit voor de periode vanaf oktober 2006 | NZa en DBC-Onderhoud | NA/2019/16598933 | 27-09-2019/52785 |  |
| `NTS-2019` | Selectielijst van de Nederlandse Transplantatie Stichting vanaf 1 januari 2019 | Nederlandse Transplantatie Stichting (NTS) | NA/2019/884262 | 21-11-2019/63267 |  |
| `MFONDS-2020` | Selectielijst van Stichting Mondriaan Fonds vanaf 1 januari 2012 | Stichting Mondriaan Fonds | NA/2020/17993568 | 29-01-2020/5150 |  |
| `WK-2020` | Selectielijst van de Waarderingskamer vanaf 1 januari 2014 | Waarderingskamer | NA/2020/17993351 | 29-01-2020/5158 |  |
| `SVB-2020` | Selectielijst voor de neerslag van handelingen van de Sociale Verzekeringsbank (SVB) periode (1956-) 2004- | Sociale Verzekeringsbank (SVB) | NA/2020/17993568 | 29-01-2020/5153 |  |
| `NWO-2020` | Selectielijst van de Nederlandse organisatie voor Wetenschappelijk Onderzoek en rechtsvoorganger vanaf 1 april 1950 | Nederlandse organisatie voor Wetenschappelijk Onderzoek (NWO) | NA/2020/18000576 | 29-01-2020/5152 |  |
| `SZVK-2020` | Selectielijst van de Stichting Ziektenkostenverzekering Krijgsmacht (SZVK) vanaf 1995 | Stichting Ziektenkostenverzekerin g Krijgsmacht (SZVK) | NA/2020/18000458 | 29-01-2020/5154 |  |
| `ZIN-2020` | Selectielijst van Zorginstituut Nederland vanaf (2014) 2017 | Zorginstituut Nederland (ZiN) | NA/2020/17999481 | 29-01-2020/5160 |  |
| `UNIV-2020` | Selectielijst Universiteiten en Universitair Medische Centra 2020 | Universiteiten en Universitair Medische Centra | NA/2020/18001001 | 29-01-2020/5156 | Jaartal uit de titel. |
| `GEM-2020` | Selectielijst gemeenten en intergemeentelijke organen 2020 | Gemeenten en intergemeentelijke organen | NA/2020/21446242 | 26-02-2020/11143 | Jaartal uit de titel. |
| `TK-2020` | Selectielijst van de Tweede Kamer der Staten-Generaal vanaf 5 mei 1945 | Tweede Kamer der Staten-Generaal | Koninklijk besluit van 11 februari 2020 | 25-02-2020/10766 |  |
| `VWS-2020` | Concernbrede selectielijst van het Ministerie van Volksgezondheid, Welzijn en Sport | Ministerie van Volksgezondheid, Welzijn en Sport (VWS) en de Inspectie Gezondheidszorg en Jeugd (IGJ) | NA/2020/21664352 | 10-03-2020/13588 |  |
| `AZ-2020` | Selectielijst Ministerie van Algemene Zaken en daaronder ressorterende diensten, agentschappen, commissies en raden vanaf 2007 | Ministerie van Algemene Zaken (AZ) | NA/2020/21450102 | 10-03-2020/13567 |  |
| `MER-2020` | Selectielijst van de Commissie voor de milieueffectrapportage (Commissie m.e.r.) vanaf 1 december 1981 | Commissie voor de milieueffectrapportage | NA/2020/23911306 | 17-02-2020/21668 |  |
| `SER-2020` | Selectielijst Sociaal-Economische Raad Voor het selecteren van te vernietigen en permanent te bewaren archiefbescheiden over de periode (1956-2006) 2015- | Sociaal-Economische Raad (SER) | NA/2020/24131566 | 13-05-2020/25708 |  |
| `POLITIE-2020` | Generieke selectielijst voor de informatie van de politie, vanaf 1 januari 2013 | Nationale Politie | NA/2020/24125123 | 19-05-2020/26744 |  |
| `ZONMW-2020` | Selectielijst van ZonMw vanaf 21 mei 2001 | ZonMw | NA/2020/24478871 | 29-5-2020/28630 |  |
| `KEURMERK-2020` | Selectielijst van het Keurmerkinstituut vanaf [1997] 1998 | Keurmerkinstituut | NA/2020/24820051 | 08-07-2020/35902 |  |
| `CML-2020` | Selectielijst van CML B.V. vanaf 3 mei 2018 | CML B.V. | NA/2020/25006832 | 28-07-2020/39932 |  |
| `PROVCDK-2020` | Selectielijst voor archiefbescheiden van de commissaris van de Koning als rijksorgaan vanaf 1 januari 2020 | Commissarissen van de Koning | NA/2020/25067715 | 28-07-2020/39938 |  |
| `PROV-2020` | Selectielijst voor archiefbescheiden van de provinciale organen vanaf 1 januari 2020 | Provinciale organen | NA/2020/25005743 | 28-07-2020/39934 |  |
| `LIFTINSTITUU-2020` | Selectielijst van Liftinstituut B.V. Voor de periode vanaf 1 januari 1956 | Liftinstituut B.V. | NA/2020/25167810 | 21-08-2020/43835 |  |
| `SVDJ-2020` | Selectielijst van het Stimuleringsfond s voor de Journalistiek vanaf 2009 | Stimuleringsfonds voor de Journalistiek (SvdJ) | NA/2020/25547769 | 01-10-2020/50439 |  |
| `NIWO-2020` | Selectielijst van de Nationale en Internationale Wegvervoerorganisatie (NIWO) vanaf 1 januari 2017 voor de primaire taken vanaf 1 januari 1946 – voor de bedrijfsvoeringstaken | Nationale en Internationale Wegvervoerorganisatie (NIWO) | NA/2020/25465405 | 01-10-2020/50442 |  |
| `CGD-2020` | Selectielijst van het College gerechtelijk deskundigen vanaf 1 januari 2010 | College gerechtelijk deskundigen | NA/2020/25764072 | 23-10-2020/54751 |  |
| `DEF-2020` | Selectielijst Ministerie van Defensie vanaf (1945) 2021 | Ministerie van Defensie | NA/2020/25468131 | 18-11-2020/56944 |  |
| `CHEX-2020` | Selectielijst Chex Liftkeuringen B.V. vanaf 1 januari 2006 | Chex Liftkeuringen | NA/2020/26060131 | 30-11-2020/62167 |  |
| `RVS-2020` | Selectielijst Raad van State 2010- | Raad van State (RvS) | Koninklijk besluit van 12 november 2020 | 1-12-2020/62212 |  |
| `RECHTSPRAAK-2021` | Primair proces van ‘de Rechtspraak’, selectielijst voor de waardering van alle rechtszaak gebonden stukken, ontvangen of opgemaakt vanaf (1985) 2005 | de Rechtspraak | NA/2020/26449181 | 6-1-2021/223 |  |
| `VWS-2021` | Concernbrede selectielijst van het Ministerie van Volksgezondheid, Welzijn en Sport | Ministerie van Volksgezondheid, Welzijn en Sport (VWS), Inspectie Gezondheids-zorg en Jeugd (IGJ), College ter beoordeling van geneesmiddelen (CBG) en Sociaal Planbureau (SCP) | NA/2020/26388753 | 21-01-2021/2559 |  |
| `SKO-2021` | Selectielijst Stichting Hobéon SKO Certificatie vanaf 1 maart 2008 | Stichting Hobéon SKO Certificatie | NA/2021/2669771 | 18-2-2021/7900 |  |
| `CEA-2021` | Selectielijst van de Commissie Eindtermen Accountants-opleidingen (CEA) vanaf 2020 | Commissie Eindtermen Accountantsopleidingen (CEA) | NA/2021/26674476 | 24-02-2021/8980 |  |
| `GI-2021` | Selectielijst van de Gecertificeerde Instellingen voor jeugdbescherming en jeugdreclassering en rechtsvoorgangers vanaf 1 november 1995 | Gecertificeerde Instellingen voor jeugdbescherming en jeugdreclassering en rechtsvoorgangers | NA/2021/26549428 | 24-02-2021/8963 |  |
| `NORMEC-2021` | Selectielijst van Normec Certification BV vanaf 1 maart 2006 | Normec Certification BV | NA/2021/27003488 | 10-03-2021/11473 |  |
| `EK-2021` | Selectielijst van de Eerste Kamer der Staten-Generaal vanaf 5 mei 1945 | Eerste Kamer der Staten-Generaal | Koninklijk Besluit van 12 februari 2021 | 22-3-2021/13826 |  |
| `VVSG-2021` | Selectielijst van de Verenigde Vergadering der Staten-Generaal vanaf 5 mei 1945 | Verenigde Vergadering der Staten-Generaal | Koninklijk Besluit van 12 februari 2021 | 22-3-2021/13828 |  |
| `JENV-2021` | Selectielijst van het Ministerie van Justitie en Veiligheid en rechtsvoorgangers vanaf 5 mei 1945 | Ministerie van Justitie en Veiligheid (JenV) | NA/2021/27005737 | 12-04-2021/17848 |  |
| `VETURO-2021` | Selectielijst van Veturo B.V. vanaf 2001 | Veturo B.V. | NA/2021/27794939 | 07-05-2021/23055 |  |
| `NIDOS-2021` | Selectielijst van Stichting Nidos en haar rechtsvoorganger vanaf 1 november 1995 | Stichting Nidos en haar rechtsvoorganger | NA/2021/28170343 | 11-06-2021/29211 |  |
| `DOPING-2021` | Selectielijst Dopingautoriteit vanaf 2019 | Dopingautoriteit | NA/2021/28170133 | 11-6-2021/29214 |  |
| `CBS-2021` | Selectielijst van het Centraal Bureau voor de Statistiek (CBS) vanaf 2004 en de Centrale Commissie voor de Statistiek (CCS) voor de periode 2004-2016 | Centraal Bureau voor de Statistiek (CBS) en de Centrale Commissie voor de Statistiek (CCS) | NA/2021/28414907 | 6-7-2021/34311 |  |
| `ARCHITECTEN-2021` | Selectielijst van Bureau Architectenregister en rechtsvoorganger vanaf 1 oktober 1988 | Bureau Architectenregister | NA/2021/28679708 | 30-7-2021/36980 |  |
| `NIL-2021` | Selectielijst van Stichting Nederlands Instituut voor Lastechniek (NIL) | Nederlands Instituut voor Lastechniek (NIL) | NA/2021/29033882 | 10-9-2021/40519 |  |
| `HHC-2021` | Selectielijst van HHC/DRS B.V. vanaf augustus 2004 | HHC/DRS B.V. | NA/2021/29034414 | 10-9-2021/40521 |  |
| `DARE-2021` | Selectielijst van DARE!! Services B.V. vanaf 19 maart 1998 | DARE!! Services B.V. | NA/2021/29028403 | 10-9-2021/40523 |  |
| `SAIP-2021` | Selectielijst van de Stichting Administratie Indonesische Pensioenen en van het Ministerie van Binnenlandse Zaken en Koninkrijksrelaties inzake overzeese pensioenen en uitkeringen vanaf 1951 | Stichting Administratie Indonesische Pensioenen en het Ministerie van Binnenlandse Zaken en Koninkrijksrelaties | NA/2021/28677205 | 22-9-2021/41473 |  |
| `NFF-2021` | Selectielijst van Stichting Nederlands Fonds voor de Film vanaf 1 januari 2013 | Stichting Nederlands Fonds voor de Film | NA/2021/29947218 | 18-11-2021/46676 |  |
| `SBB-2021` | Selectielijst van de stichting Samenwerking Beroepsonderwijs Bedrijfsleven vanaf 1 augustus 2015 | Stichting Samenwerking Beroepsonderwijs Bedrijfsleven (SBB) | NA/2021/30626941 | 24-12-2021/50415 |  |
| `VERITAS-2022` | Selectielijst van Bureau Veritas Inspection and Certification The Netherlands B.V. en rechtsvoorgangers vanaf 28 januari 1985 | Bureau Veritas Inspection and Certification The Netherlands B.V. | NA/2022/3111966 | 26-01-2022/1594 |  |
| `VINCOTTE-2022` | Selectielijst van Vinçotte Nederland B.V. vanaf 11 september 1997 | Vinçotte Nederland B.V. | NA/2022/31514560 | 28-2-2022/5738 |  |
| `PROV-2022` | Selectielijst voor archiefbescheiden van de provinciale organen ontvangen of opgemaakt vanaf 1 januari 2014 tot 1 januari 2020 | Provinciale organen | NA/2022/31454164 | 8-3-2022/6491 |  |
| `PROVCDK-2022` | Selectielijst voor archiefbescheiden van de commissaris van de Koning als rijksorgaan ontvangen of opgemaakt vanaf 1 januari 2014 tot 1 januari 2020 | Commissaris van de Koning als rijksorgaan | NA/2022/31455483 | 8-3-2022/6492 |  |
| `KVK-2022` | Selectielijst van de Kamer van Koophandel vanaf 2014 | Kamer van Koophandel (KVK) | NA/2022/32048261 | 19-4-2022/10526 |  |
| `TUVSUD-2022` | Selectielijst van TÜV SÜD Nederland B.V. vanaf 25 juli 2000 | TÜV SÜD Nederland B.V. | NA/2022/33170081 | 29-7-2022/19838 |  |
| `SKH-2022` | Selectielijst van SKH B.V. vanaf 26 augustus 1996 | Selectielijst van SKH B.V. vanaf 26 augustus 1996 | NA/2022/34873753 | 14-12-2022/33651 |  |
| `KNAW-2022` | Selectielijst van de Koninklijke Nederlandse Akademie van Wetenschappen (KNAW) vanaf 1 november 2020 | Koninklijke Nederlandse Akademie van Wetenschappen (KNAW) | NA/2022/34895432 | 14-12-2022/33648 |  |
| `IBKI-2023` | Selectielijst van IBKI vanaf 1985 | IBKI | NA/2023/35384205 | 22-2-2023/5793 |  |
| `SDKB-2023` | Selectielijst van de Stichting donorgegevens kunstmatige bevruchting (Sdkb) vanaf 23 juli 2003 | Stichting donorgegevens kunstmatige bevruchting (Sdkb) | NA/2023/38741044 | 14-6-2023/16461 |  |
| `COA-2023` | Selectielijst van het Centraal Orgaan opvang asielzoekers vanaf 1 juli 1994 | Centraal Orgaan opvang asielzoekers (COA) | NA/2023/38452627 | 19-7-2023/20252 |  |
| `KB-2023` | Selectielijst van de KB vanaf 1 januari 2015 | KB | NA/2023/38929280 | 21-7-2023/20456 |  |
| `GEMMAIL-2024` | Selectielijst e-mailbewaring gemeentelijke en intergemeentelijke organen 2024 | Vereniging van Nederlandse Gemeenten (VNG) | NA/2023/39803822 | 26-7-2023/20927 | Jaartal uit de titel. |
| `DGDOUANE-2023` | Selectielijst directoraat-generaal Douane vanaf (2013) 2023 | Directoraat-generaal Douane (DG Douane) | NA/2023/41488384 | 2-11-2023/29744 |  |
| `BZ-2023` | Selectielijst van het ministerie van Buitenlandse Zaken vanaf 2015 | Ministerie van Buitenlandse Zaken (BZ) | NA/2023/42505610 | 14-12-2023/34115 |  |
| `VWS-2024` | Concernbrede selectielijst van het Ministerie van Volksgezondheid, Welzijn en Sport | Ministerie van Volksgezondheid, Welzijn en Sport | NA/2024/43929309 | 09-02-2024/3945 |  |
| `KNMG-2024` | Selectielijst Koninklijke Nederlandsche Maatschappij tot bevordering der Geneeskunst vanaf 1998 | Koninklijke Nederlandsche Maatschappij tot bevordering der Geneeskunst (KNMG) | NA/2024/45531327 | 03-05-2024/14441 |  |
| `TK-2024` | Selectielijst van de Tweede Kamer der Staten-Generaal vanaf 5 mei 1945 | Tweede Kamer der Staten-Generaal | Koninklijk besluit van 14 juni 2024 | 05-07-2024/20712 |  |
| `VERITAS-2024` | Selectielijst van Bureau Veritas Inspection and Certification The Netherlands B.V. en rechtsvoorgangers vanaf 28 januari 1985 | Bureau Veritas Inspection and Certification The Netherlands B.V. | NA/2024/49212286 | 06-12-2024/39942 |  |
| `BFT-2024` | Selectielijst van Bureau Financieel Toezicht en de Commissies van Deskundigen vanaf 1 januari 1999 | Bureau Financieel Toezicht | NA/2024/49748107 | 30-12-2024/42998 |  |
| `LVVN-2025` | Selectielijst van het ministerie van Landbouw, Visserij, Voedselzekerheid en Natuur (Landbouw, Natuur en Voedselkwaliteit tot en met 1 juli 2024) vanaf 1 januari 2024 | Ministerie van Landbouw, Visserij, Voedselzekerheid en Natuur (LVVN) | NA/2025/49685293 | 11-02-2025/4992 |  |
| `ARK-2025` | Selectielijst van de Algemene Rekenkamer vanaf 1 januari 1993 | Algemene Rekenkamer | Koninklijk besluit van 24 januari 2025 | 11-02-2025/5024 |  |
| `EZ-2025` | Selectielijst van het ministerie van Economische Zaken (Ministerie van Economische Zaken en Klimaat tot en met 1 juli 2024) vanaf januari 2024 (2018) | Ministerie van Economische Zaken (EZ) | NA/2025/49685680 | 11-02-2025/4991 |  |
| `SZW-2025` | Selectielijst van het ministerie van Sociale Zaken en Werkgelegenheid (SZW) vanaf (2002) 1 mei 2024. | Ministerie van Sociale Zaken en Werkgelegenheid (SZW) | NA/2025/50001091 | 21-02-2025/6425 |  |
| `FGZPT-2025` | Selectielijst van de Federatie van gezondheidszorgpsychologen en psychotherapeuten (FGzPt) ten aanzien van de publiekrechtelijke taken van de Commissie Registratie en Toezicht (CRT) en rechtsvoorganger vanaf 2018 | Federatie van gezondheidszorg-psychologen en psychotherapeuten (FGzPt) | NA/2025/50053779 | 25-02-2025/6811 |  |
| `DNB-2025` | Selectielijst van De Nederlandsche Bank N.V. voor haar publieke taken vanaf (2014) 2017 | De Nederlandsche Bank | NA/2025/50054680 | 25-02-2025/6808 |  |
| `SCI-2025` | Selectielijst Stimuleringsfonds Creatieve Industrie vanaf 1 september 2012 | Stimuleringsfonds Creatieve Industrie | NA/2025/52242335 | 08-05-2025/15615 |  |
| `TUVNORD-2025` | Selectielijst van TÜV NORD Nederland voor de periode vanaf 2000 | TÜV NORD Nederland | NA/2025/52251599 | 08-05-2025/15695 |  |
| `FIN-2025` | Selectielijst van het beleidsdepartement Financiën en de generieke processen van de directoraten-generaal Belastingdienst, Dienst Toeslagen en Douane | Ministerie van Financiën | NA/2025/52931853 | 16-09-2025/31394 |  |
| `TOESLAGEN-2025` | Selectielijst van de primaire processen van Dienst Toeslagen vanaf 1 april 2020 | Dienst Toeslagen | NA/2025/52930822 | 16-09-2025/31395 |  |
| `BELASTING-2025` | Selectielijst van de primaire processen van het Directoraat-Generaal Belastingdienst vanaf (2009) 2023 | Directoraat-Generaal Belastingdienst | NA/2025/52934260 | 16-09-2025/31382 |  |
| `TUVSUD-2025` | Selectielijst TÜV SÜD NEDERLAND B.V. vanaf 25 juli 2000 | TÜV SÜD NEDERLAND B.V. | NA/2025/54257733 | 29-09-2025/32638 |  |
| `ACNL-2026` | Selectielijst van Airport Coordination Netherlands (ACNL) vanaf 1 april 2020 | Airport Coordination Netherlands (ACNL) | NA/2025/54611326 | 15-01-2026/721 |  |
| `IENW-2026` | Selectielijst van het ministerie van Infrastructuur en Waterstaat voor de periode vanaf 2026 | Ministerie van Infrastructuur en Waterstaat | NA/2025/58639738 | 09-02-2026/3587 |  |
| `LETTERENFOND-2026` | Selectielijst Nederlands Letterenfonds vanaf 01-01-2010 | Stichting Nederlands Letterenfonds | NA/2025/57494561 | 16-02-2026/4223 |  |
| `NZA-2026` | Selectielijst van de Stichting DBC-Onderhoud voor de periode 2004-2017 en de Nederlandse Zorgautoriteit voor de periode vanaf oktober 2006 | Nederlands Zorgautoriteit (Nza) | NA/2025/57493842 | 30-03-2026/11974 |  |
| `RVA-2026` | Selectielijst Stichting Raad voor Accreditatie (RvA) voor de periode vanaf 1 januari 2010 | Raad voor Accreditatie (RvA) | NA/2026/62575181 | 30-03-2026/11961 |  |
| `RECHTSPRAAK-2026` | Primair proces van de Rechtspraak selectielijst voor de waardering van alle rechtszaak gebonden stukken ontvangen of opgemaakt vanaf (1985) 1990 | De Rechtspraak | NA/2026/61101201 | 29-04-2026/15616 |  |
| `APPERSOONSRE-2026` | Selectielijst voor de neerslag van de handelingen van het Ministerie van Justitie met betrekking tot de handelingen van het College Bescherming Persoonsgegevens en de Registratiekamer op het beleidsterrein Persoonsregistraties vanaf 1989 | Autoriteit Persoonsgegevens | NA/2026/62934820 | 26-05-2026/18542 |  |
| `RVR-2026` | Selectielijst van de Raad voor Rechtsbijstand vanaf (2000) 14 juni 2010 | Raad voor Rechtsbijstand | NA/2026/63321993 | 07-08-2026/29777 |  |
| `APA-2026` | Selectielijst voor de Personeelsdossiers van de Autoriteit Persoonsgegevens (AP) en rechtsvoorgangers vanaf 1 januari 2019 | Autoriteit Persoonsgegevens | NA/2026/65053433 | 31-08-2026/30541 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `APB-2026` | Selectielijst van de Autoriteit Persoonsgegevens (AP) vanaf 1 januari 2019 | Autoriteit Persoonsgegevens | NA/2026/65054091 | 31-08-2026/30540 | Volgletter: meerdere lijsten met hetzelfde toepassingsgebied in hetzelfde jaar. |
| `BES-2026` | Selectielijst van de openbare lichamen Bonaire, Sint Eustatius en Saba vanaf 10 oktober 2010 | 1. Openbaar Lichaam Bonaire 2. Openbaar Lichaam Sint Eustatius 3. Openbaar Lichaam Saba | NA/2026/66271339 | 05-10-2026/34644 |  |
| `RDW-2026` | Selectielijst van de RDW (Dienst Wegverkeer) over de periode vanaf 2018 | Dienst Wegverkeer (RDW) | NA/2026/65744823 | 05-10-2026/55377 |  |
