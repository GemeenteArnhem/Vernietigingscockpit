# ADR 0004 – Idempotency-Key verplicht in stekker-spec v1.1

## Status
Voorgesteld (concept, nog vast te stellen)

> Opgenomen in Stekker API v2.0.0 (ADR-0005) in plaats van v1.1.0. De foutcode bij een ontbrekende sleutel is `IDEMPOTENCY_KEY_MISSING`.

## Datum
2026-10-03

## Context

De cockpit roept stekkers aan vanuit een worker die kan crashen, kan worden herstart of een antwoord kan missen (time-out, verbroken verbinding). Een muterend verzoek wordt dan herhaald. In de praktijktests (scenario C en D, oktober 2026) leidde dat zonder bescherming tot dubbele selecties en het risico op dubbele vernietigingen of batches.

Stekker-spec v1.0.0 kent een header `Idempotency-Key`, maar:

- hij is **optioneel** (`required: false`) op `POST /vernietigingen`, `POST /vernietigingen/{id}/batches` en `POST /vernietigingen/{id}/vrijgeven`;
- hij **ontbreekt** op `POST /selecties`;
- de spec beschrijft niet wat een stekker met een herhaalde sleutel moet doen.

Sinds CC-7 en CC-8 beschermt de cockpit zichzelf: werk wordt geclaimd (één worker tegelijk) en elke uitvoeringsstap wordt vastgelegd, met vaste sleutels per stap. Bij een gemist antwoord is de cockpit echter afhankelijk van de stekker om een herhaling te herkennen. Voor `POST /selecties` is er nu geen enkele bescherming.

## Beslissing

In stekker-spec **v1.1.0** (minor, achterwaarts verenigbaar voor cockpits die de header al sturen):

1. `Idempotency-Key` is **verplicht** op alle muterende verzoeken: `POST /selecties`, `POST /vernietigingen`, `POST /vernietigingen/{id}/batches` en `POST /vernietigingen/{id}/vrijgeven`.
2. Semantiek:
   - zelfde sleutel en zelfde inhoud → de stekker voert niets opnieuw uit en geeft hetzelfde antwoord (status en body) als de eerste keer;
   - zelfde sleutel met andere inhoud → `409 Conflict` met foutcode `IDEMPOTENCY_KEY_REUSED`;
   - ontbreekt de sleutel → `400 Bad Request`.
3. Een stekker bewaart sleutels minimaal **7 dagen**, ruim langer dan een uitvoering duurt.
4. De sleutel is een string van maximaal 200 tekens; de cockpit bepaalt het formaat. De cockpit gebruikt vaste sleutels per eigen record: `selectie-<selectieId>`, `vernietiging-<vernietigingId>`, `vernietiging-<vernietigingId>-batch-<n>` en `vernietiging-<vernietigingId>-vrijgeven`.

## Overwegingen

- Idempotentie hoort bij de partij die de bijwerking uitvoert. Alleen de stekker weet of een verzoek al is verwerkt toen het antwoord verloren ging.
- Een verplichte header maakt het gedrag toetsbaar met de stekker-implementatiechecklist.
- Een minor-versie volstaat: de cockpit stuurt de sleutels al, behalve bij `POST /selecties`.

## Alternatieven

- **Optioneel laten.** De cockpit blijft dan bij gemiste antwoorden afhankelijk van goed gedrag van elke stekker; niet toetsbaar.
- **Alleen de cockpit laten beschermen** (claims en vastlegging). Dat dekt een gemist antwoord niet af: de cockpit weet dan niet of de stekker het verzoek heeft verwerkt.
- **Een eigen zoek-endpoint** (`GET /vernietigingen?cockpitTaakId=`) om na een fout te controleren. Dat is complexer en geeft race-condities; idempotentie is de gangbare oplossing.

## Gevolgen

- Spec: `stekker-openapi-spec` naar v1.1.0, parameter `IdempotencyKey` op `required: true` en toegevoegd aan `POST /selecties`; foutcode `IDEMPOTENCY_KEY_REUSED`; de checklist in `designrules/api/stekker-api-implementatiechecklist.md` aanvullen.
- Teststekker: idempotentie ook voor `POST /selecties`, sleutel verplicht, 409 bij hergebruik met andere inhoud.
- Cockpit: `Idempotency-Key` meesturen op `POST /selecties` (de overige stuurt hij al).
- Bestaande stekkers: binnen een overgangstermijn naar v1.1; tot die tijd blijft de cockpit zich zelf beschermen.
