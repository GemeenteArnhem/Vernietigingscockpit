$REPO = "GemeenteArnhem/Vernietigingscockpit"

# Stories die expliciet BINNEN MVP vallen
$mvpStories = @(
  "US_001","US_002","US_003","US_004","US_006","US_008","US_010",
  "US_013","US_015","US_017","US_018","US_019","US_020","US_021",
  "US_022","US_023","US_028","US_029","US_030","US_032","US_033",
  "US_034","US_035","US_036","US_038","US_040","US_043"
)

# Alle story issues ophalen
$stories = gh issue list `
  --repo $REPO `
  --label story `
  --state all `
  --limit 500 `
  --json number `
  | ConvertFrom-Json

foreach ($story in $stories) {

  $issueNumber = $story.number

  # Volledige issue ophalen (body + labels)
  $issue = gh issue view $issueNumber `
    --repo $REPO `
    --json body,labels `
    | ConvertFrom-Json

  # US-code uit body halen
  if ($issue.body -match "US_\d+") {

    $code = $matches[0]
    $labelNames = $issue.labels.name
    $isMvp = $mvpStories -contains $code
    $hasBoundary = $labelNames -contains "mvp-boundary"

    if ($isMvp -and $hasBoundary) {
      Write-Host "❌ mvp-boundary VERWIJDEREN bij $code (issue #$issueNumber)"
      gh issue edit $issueNumber `
        --repo $REPO `
        --remove-label "mvp-boundary"
    }

    elseif (-not $isMvp -and -not $hasBoundary) {
      Write-Host "➕ mvp-boundary TOEVOEGEN bij $code (issue #$issueNumber)"
      gh issue edit $issueNumber `
        --repo $REPO `
        --add-label "mvp-boundary"
    }

    else {
      Write-Host "✓ $code is correct gelabeld"
    }
  }
  else {
    Write-Host "⚠️ Geen US-code gevonden in issue #$issueNumber (overgeslagen)"
  }
}