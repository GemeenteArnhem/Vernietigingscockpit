$REPO = "GemeenteArnhem/Vernietigingscockpit"

# Bestaande story-issues ophalen (idempotentie)
$existingStories = gh issue list `
  --repo $REPO `
  --label story `
  --state all `
  --limit 500 `
  --json title `
  | ConvertFrom-Json

$existingTitles = $existingStories.title

Get-ChildItem backlog/03-stories/*.md | ForEach-Object {

  # US-code robuust uit bestandsnaam halen (onafhankelijk van type streepje)
  if ($_.Name -match "^US\D*(\d{3})") {
    $storyCode = "US-$($matches[1])"
  } else {
    Write-Host "❌ Geen US-code in bestandsnaam: $($_.Name)"
    return
  }

  # Eerste regel opschonen: '# STORY ' verwijderen
  $rawFirstLine = Get-Content $_ -TotalCount 1
  $cleanTitle = $rawFirstLine -replace "^#\s*STORY\s*", ""

  # Definitieve GitHub-titel
  $title = "$storyCode $cleanTitle"

  $body = Get-Content $_ -Raw

  if ($existingTitles -contains $title) {
    Write-Host "Overslaan (bestaat al): $title"
  }
  else {
    Write-Host "Aanmaken story: $title"

    gh issue create `
      --repo $REPO `
      --title $title `
      --body $body `
      --label "story" | Out-Null
  }
}