# Begrippenlijst Cockpit-termijntriggers

| Kenmerk | Waarde |
|---|---|
| Naam | Cockpit-termijntriggers |
| Identificatie | `urn:vernietigingscockpit:begrippenlijst:cockpit-termijntriggers:1.0` |
| Versie | 1.0 |
| Type | Open |
| Basis | ADR-0005; MDTO `termijnTriggerStartLooptijd` (MDTO heeft hiervoor geen begrippenlijst) |

De gebeurtenis waarna de looptijd van de bewaartermijn start (`bewaartermijn.termijnTriggerStartLooptijd`).

De lijst volgt de afleidingswijzen van `brondatumArchiefprocedure` uit de ZGW Catalogi API. Voor bronnen buiten ZGW is hij aangevuld. De `begripCode` is bij ZGW-afkomst gelijk aan de ZGW-waarde, zodat stekkers voor zaaksystemen één op één kunnen mappen.

| Code | Label | Definitie | Herkomst |
|---|---|---|---|
| `afgehandeld` | Afgehandeld | De zaak of het dossier is afgehandeld (einddatum). | ZGW |
| `ander_datumkenmerk` | Ander datumkenmerk | Een ander datumkenmerk van het object, zoals vastgelegd in de bron. | ZGW |
| `eigenschap` | Eigenschap | De datum uit een benoemde eigenschap van de zaak. | ZGW |
| `gerelateerde_zaak` | Gerelateerde zaak | De afhandeling van een gerelateerde zaak. | ZGW |
| `hoofdzaak` | Hoofdzaak | De afhandeling van de hoofdzaak. | ZGW |
| `ingangsdatum_besluit` | Ingangsdatum besluit | De ingangsdatum van het besluit bij de zaak. | ZGW |
| `termijn` | Termijn | Een vaste termijn na afhandeling (procestermijn). | ZGW |
| `vervaldatum_besluit` | Vervaldatum besluit | De vervaldatum van het besluit bij de zaak. | ZGW |
| `zaakobject` | Zaakobject | Een datum van een object dat bij de zaak hoort. | ZGW |
| `afsluiten_dossier` | Afsluiten dossier | Het dossier of de serie is afgesloten (MDTO-event *Bevriezing*). | Cockpit |
| `einde_relatie` | Einde relatie | Einde van een relatie met de betrokkene, zoals een dienstverband, contract of inschrijving. | Cockpit |
| `overlijden_betrokkene` | Overlijden betrokkene | Overlijden van de betrokkene. | Cockpit |
| `vervallen_geldigheid` | Vervallen geldigheid | Een vergunning, beschikking of document is niet meer geldig. | Cockpit |
