# ADR 0002 – Contractharmonisatie cockpit

## Status
Besloten

## Datum
2026-09-29

## Context

Het bouwplan voor de Vernietigingscockpit benoemt in paragraaf 1.3 negen inconsistenties tussen ui-spec, technische architectuur, OpenAPI-contracten, mockup en teststekker. Deze inconsistenties blokkeren verdere implementatie, omdat statusnamen, resultaatwaarden, kandidaatvelden, governance-overgangen en repository-inrichting anders uit elkaar gaan lopen.

ADR-0001 legt vast dat de vernietigingskandidaat de uitwisseleenheid is. De ui-spec-state-machine noemt zichzelf de enige bron van waarheid voor taakstatussen. De stekker-OpenAPI is leidend voor stekkerresultaten.

## Beslissing

De volgende harmonisatiebesluiten zijn normerend voor ontwerp en implementatie:

- De ui-spec-state-machine is canoniek voor taakstatussen: `init`, `beoordeling`, `accordering_po`, `accordering_archivaris`, `vrijgegeven`, `uitvoering`, `resultaat`, `archief`.
- `GEPLAND`, `LOPEND`, `VOLTOOID` en `VERTRAAGD` zijn afgeleide weergavestatussen op taakdefinitieniveau, geen workflowstatussen.
- De OpenAPI-enum voor uitvoeringsresultaten is canoniek: `SUCCESS`, `FAILED`, `SKIPPED`, `NOT_FOUND`, `CHANGED`.
- Het datamodel gebruikt `vernietigingskandidaat`, niet `vernietigingsobject`.
- De kandidaatvelden `aantalObjecten` en `aantalBetrokkenen` zijn leidend in API, code en zichtbare UI-labels.
- De cockpit bouwt alleen tegen de stekker-specificatie; de teststekker moet spec-conform worden gemaakt.
- De archivaris geeft in de cockpit inhoudelijk vrij met de overgang `accordering_archivaris -> vrijgegeven`. Daarna start de recordmanager de technische vernietiging met `POST /taken/{id}/vernietigingsopdracht`.
- Configuratiewijzigingen krijgen een apart insert-only `configuratie_event`-log met dezelfde garanties als het taak-auditlog.
- Voor de overgang `beoordeling -> accordering_po` gebruikt de cockpit-API `POST /taken/{id}/beoordeling/voorleggen`.
- De webapp wordt ondergebracht in `apps/cockpit-web` met npm workspaces. Tailwind 3.4 blijft voorlopig canoniek; een upgrade naar Tailwind 4 wordt na de MVP-basis apart beoordeeld.

## Overwegingen

- Een enkele set workflowstatussen voorkomt dubbele transitiemodellen in backend, frontend en documentatie.
- De OpenAPI-specificatie is het contract met stekkers en moet daarom leidend zijn voor resultaatwaarden.
- `vernietigingskandidaat`, `aantalObjecten` en `aantalBetrokkenen` sluiten aan op ADR-0001 en het stekkercontract.
- De extra status `vrijgegeven` maakt de functiescheiding expliciet: inhoudelijke vrijgave door de archivaris is iets anders dan de technische vernietigingsopdracht door de recordmanager.
- Tailwind 3.4 beperkt migratierisico in de MVP, omdat de mockup daarop al draait.

## Alternatieven

- De technische statusset `AANGEMAAKT...AFGEROND` behouden. Dit is verworpen omdat het een tweede workflowtaal naast de ui-spec introduceert.
- `GEPLAND/LOPEND/VOLTOOID/VERTRAAGD` als echte taakstatussen gebruiken. Dit is verworpen omdat deze waarden beter passen als afgeleide dashboardstatussen.
- `indienen` gebruiken als endpointnaam voor de overgang naar accordering. Dit is verworpen omdat `voorleggen` beter beschrijft wat de recordmanager doet.
- Direct upgraden naar Tailwind 4. Dit is uitgesteld omdat het nu geen functionele MVP-winst oplevert en wel migratierisico introduceert.

## Gevolgen

- Architectuurdocumentatie en ui-spec API-mapping moeten worden bijgewerkt naar deze termen en endpoints.
- De UI-mockdata en types worden geharmoniseerd op `VernietigingsKandidaat`, `aantalObjecten` en `aantalBetrokkenen`.
- Backend-implementatie moet de workflowstatus `vrijgegeven` opnemen in de transitiematrix en autorisatieguards.
- Teststekker-issues moeten worden aangemaakt voor ontbrekende batch-endpoints, status `PARTIAL` en OAuth2.
- Tailwind 4 blijft uit scope voor de eerste MVP-harmonisatie.
