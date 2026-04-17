$REPO = "GemeenteArnhem/Vernietigingscockpit"
$featureIssueMap = Get-Content backlog/feature-issue-map.json | ConvertFrom-Json
$storyFeatureMap = Import-PowerShellDataFile backlog/story-feature-map.psd1

$stories = gh issue list `
  --repo $REPO `
  --label story `
  --state all `
  --limit 500 `
  --json number,title

foreach ($story in $stories) {

  $storyIssue = $story.number
  $title = $story.title

  if ($title -match "US-\d+") {
    $storyCode = $matches[0]

    foreach ($featureKey in $storyFeatureMap.Keys) {
      if ($storyFeatureMap[$featureKey] -contains $storyCode) {

        $featureIssue = $featureIssueMap.$featureKey

        Write-Host "Koppelen $storyCode → FEATURE #$featureIssue"

        # Comment bij de story
        gh issue comment $storyIssue `
          --repo $REPO `
          --body "Deze user story valt onder FEATURE #$featureIssue."

        # Checklistregel bij de feature
        gh issue comment $featureIssue `
          --repo $REPO `
          --body "- [ ] #$storyIssue $title"
      }
    }
  }
}