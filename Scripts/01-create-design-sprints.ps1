$REPO = "GemeenteArnhem/Vernietigingscockpit"

Get-ChildItem backlog/00-design-sprints/*.md | ForEach-Object {
  gh issue create `
    --repo $REPO `
    --title (Get-Content $_ -TotalCount 1) `
    --body-file $_ `
    --label "design-sprint,decision"
}