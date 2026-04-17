$REPO = "GemeenteArnhem/Vernietigingscockpit"

# Alle story‑issues ophalen
$stories = gh issue list `
  --repo $REPO `
  --label story `
  --state all `
  --limit 500 `
  --json number,title `
  | ConvertFrom-Json

Write-Host "Te verwijderen stories:"
$stories | ForEach-Object {
  Write-Host " - #" $_.number $_.title
}

$confirm = Read-Host "Weet je zeker dat je ALLE story issues wilt verwijderen? (yes)"

if ($confirm -eq "yes") {
  foreach ($story in $stories) {
    Write-Host "Verwijderen issue #$($story.number)"
    gh issue delete $story.number `
      --repo $REPO `
      --yes
  }
}
else {
  Write-Host "Afgebroken."
}