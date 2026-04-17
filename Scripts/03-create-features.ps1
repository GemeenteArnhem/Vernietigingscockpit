$REPO = "GemeenteArnhem/Vernietigingscockpit"
$featureMap = @{}

Get-ChildItem backlog/02-features/*.md | ForEach-Object {

  $featureKey = $_.Name.Substring(0,2)
  $title = Get-Content $_ -TotalCount 1

  Write-Host "Aanmaken feature $featureKey : $title"

  # Feature aanmaken
  gh issue create `
    --repo $REPO `
    --title $title `
    --body-file $_ `
    --label "feature" | Out-Null

  # Laat GitHub even bijwerken
  Start-Sleep -Milliseconds 500

  # Laatste issue ophalen (betrouwbaar)
  $issueNumber = gh issue list `
    --repo $REPO `
    --limit 1 `
    --json number `
    --jq '.[0].number'

  if ($issueNumber) {
    $featureMap[$featureKey] = [int]$issueNumber
    Write-Host "Feature $featureKey gekoppeld aan issue #$issueNumber"
  } else {
    Write-Error "❌ Kon issue-nummer niet ophalen voor feature $featureKey"
  }
}

$featureMap | ConvertTo-Json | Out-File backlog/feature-issue-map.json