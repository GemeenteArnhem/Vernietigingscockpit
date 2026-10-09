# Begrippenlijst Cockpit-configuratie-eventtypen

| Kenmerk | Waarde |
|---|---|
| Naam | Cockpit-configuratie-eventtypen |
| Identificatie | `urn:vernietigingscockpit:begrippenlijst:cockpit-configuratie-eventtypen:1.0` |
| Versie | 1.0 |
| Type | Open |
| Basis | ADR-0005 §5, ADR-0006 |

Eventtypen voor het globale configuratielog (`configuratie_event`). Deze events gaan niet over een informatieobject. Daarom komen ze niet uit de MDTO EventTypeLijst.

| Label | Definitie | Actor | Vervangt (ADR-0003) |
|---|---|---|---|
| Stamgegevens geïmporteerd | Afdelingen en medewerkers zijn geïmporteerd of bijgewerkt. | gebruiker, systeem | MASTER_DATA_IMPORTED |
| Taakdefinitie aangemaakt | Een taakdefinitie is aangemaakt. | gebruiker | TASK_DEFINITION_CREATED |
| Taakdefinitie verwijderd | Een taakdefinitie is verwijderd: echt als er nooit uitvoeringen waren, anders logisch. | gebruiker | TASK_DEFINITION_DELETED |
| Gebruiker gekoppeld | Een gebruiker (OIDC `sub`) is eenmalig aan een medewerker gekoppeld. | systeem | USER_LINKED |
| Stekker aangemaakt | Stekker aangemaakt met configuratieversie 1. | gebruiker | CONNECTOR_CREATED |
| Stekker gewijzigd | Nieuwe configuratieversie van een stekker. | gebruiker | CONNECTOR_UPDATED |
| Stekker gedeactiveerd | Stekker op inactief gezet; historie blijft. | gebruiker | CONNECTOR_DEACTIVATED |
| Stekker geactiveerd | Inactieve stekker weer actief gezet. | gebruiker | CONNECTOR_ACTIVATED |
| Stekker verwijderd | Stekker verwijderd; alleen als hij nooit is gebruikt. | gebruiker | CONNECTOR_DELETED |
| Instelling gewijzigd | Een instelling van de organisatie is gewijzigd, zoals de bewaartermijn van de werkkopie. Oude en nieuwe waarde staan in de details. | gebruiker | (nieuw, ADR-0006) |
| Verificatie archief mislukt | Bij de hercontrole vóór het verwijderen van een werkkopie kwam het gearchiveerde pakket niet overeen met zijn MDTO-beschrijving; er is niet verwijderd. | systeem | (nieuw, ADR-0006) |
| Werkkopie verwijderd | De werkkopie van een vernietigingsdossier is uit de cockpit verwijderd; er is een grafsteen vastgelegd. Uitdrukkelijk **geen** MDTO *Vernietigen*. | systeem | (nieuw, ADR-0006) |
