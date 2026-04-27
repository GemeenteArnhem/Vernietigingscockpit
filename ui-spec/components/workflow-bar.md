# Component: WorkflowBar

## Doel
Toont de voortgang van de vernietigingslijst binnen de workflow.

---

## Layout

Per stap:

[ icoon ]  Label — Substatus

Voorbeeld:

✔ Selectie — Voltooid  
2 Beoordeling — Huidige stap  
3 Accordering — Proceseigenaar  

---

## Stappen

- Selectie
- Beoordeling
- Accordering (proceseigenaar)
- Accordering (archivaris)
- Uitvoering
- Resultaat

---

## Gedrag

- huidige stap = actief
- vorige stappen = afgerond
- volgende stappen = disabled

---

## Input

- taak.status

---

## Mapping

init → Selectie  
beoordeling → Beoordeling  
accordering_po → Accordering (proceseigenaar)  
accordering_archivaris → Accordering (archivaris)  
uitvoering → Uitvoering  
resultaat → Resultaat  

---

## UX-regels

- niet klikbaar
- puur informatief
- altijd zichtbaar boven hoofdvlak
- tekst staat rechts van het bolletje (inline)
- geen verticale stacking (geen label onder bolletje)
- alles op één lijn (horizontaal)
- stappen verbonden met lijn