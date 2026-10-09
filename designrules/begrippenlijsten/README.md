# Begrippenlijsten

MDTO is leidend voor benaming, begrippen en informatiemodel (ADR-0005). Waar een veld een begrip bevat (`begripGegevens`), komt de waarde uit een begrippenlijst:

1. **MDTO-begrippenlijsten** (Nationaal Archief, MDTO 1.0 / MDTO-XML 1.0.1). Die gaan altijd voor:
   - Aggregatieniveaus (open, maar in dit ecosysteem **alleen** de MDTO-waarden: Archief, Serie, Dossier, Archiefstuk; ADR-0005, B-M2)
   - EventTypeLijst (open)
   - Waarderingen (**gesloten**: B, V, N)
   - Relatietypen (betrokkene) en Relatietypen (informatieobject) (open)
   - BeperkingGebruikTypeLijst (open)
   - ChecksumAlgoritme (open; dit ecosysteem gebruikt SHA-256)
2. **Eigen begrippenlijsten** van het Vernietigingscockpit-ecosysteem. Die worden alleen gebruikt waar MDTO geen begrip heeft, of als uitbreiding van een *open* MDTO-lijst.

| Begrippenlijst | Bestand | Gebruikt in |
|---|---|---|
| Cockpit-eventtypen | [cockpit-eventtypen.md](cockpit-eventtypen.md) | `audit_event.event_type` naast de MDTO EventTypeLijst |
| Cockpit-configuratie-eventtypen | [cockpit-configuratie-eventtypen.md](cockpit-configuratie-eventtypen.md) | `configuratie_event.event_type` |
| Cockpit-vernietigingsmethoden | [cockpit-vernietigingsmethoden.md](cockpit-vernietigingsmethoden.md) | Stekker API `Vernietigingsuitvoering.vernietigingsmethode` |
| Cockpit-uitsluitredenen | [cockpit-uitsluitredenen.md](cockpit-uitsluitredenen.md) | uitsluitreden van een vernietigingskandidaat |
| Cockpit-termijntriggers | [cockpit-termijntriggers.md](cockpit-termijntriggers.md) | `bewaartermijn.termijnTriggerStartLooptijd` |
| Cockpit-dekkingInTijdtypen | [cockpit-dekkingintijdtypen.md](cockpit-dekkingintijdtypen.md) | `dekkingInTijd.dekkingInTijdType` |

## Regels

- Elke lijst heeft een **naam**, een **identificatie** (URN) en een **versie**. In een `begripGegevens` verwijst `begripBegrippenlijst` naar de lijst:

  ```json
  {
    "begripLabel": "Vernietigingsopdracht",
    "begripBegrippenlijst": {
      "verwijzingNaam": "Cockpit-eventtypen",
      "verwijzingIdentificatie": {
        "identificatieKenmerk": "urn:vernietigingscockpit:begrippenlijst:cockpit-eventtypen:1.0",
        "identificatieBron": "Vernietigingscockpit architectuur"
      }
    }
  }
  ```

- Labels zijn hoofdlettergevoelig en worden letterlijk opgeslagen en getoond (geen vertaaltabel).
- Een **gesloten** lijst wijzigt alleen via een ADR-wijziging. Een **open** lijst wijzigt via een pull request op dit bestand. De versie gaat dan omhoog: minor bij een toevoeging, major bij een verwijdering of betekeniswijziging.
- Een label wordt nooit hergebruikt met een andere betekenis.
- Vastgelegde events behouden hun labels. Bij een major versie blijft de oude versie hier beschreven, zodat historische events interpreteerbaar blijven.
