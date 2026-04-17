$REPO = "GemeenteArnhem/Vernietigingscockpit"

Get-ChildItem backlog/01-epics/*.md | ForEach-Object {
  gh issue create `
    --repo $REPO `
    --title (Get-Content $_ -TotalCount 1) `
    --body-file $_ `
    --label "epic"
}