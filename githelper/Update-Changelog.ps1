param(
    [Parameter(Mandatory = $true)]
    [string]$Version,

    [string]$Date = (Get-Date -Format 'yyyy-MM-dd'),

    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path $PSScriptRoot -Parent
$changelogFile = Join-Path $repoRoot 'CHANGELOG.md'

if (-not (Test-Path $changelogFile)) {
    throw "CHANGELOG.md nicht gefunden: $changelogFile"
}

function Normalize-Version {
    param([string]$Value)

    $normalized = $Value.Trim()
    if ($normalized.StartsWith('v')) {
        $normalized = $normalized.Substring(1)
    }

    if ($normalized -notmatch '^\d+\.\d+\.\d+$') {
        throw "Ungueltige Version: '$Value' (erwartet: MAJOR.MINOR.PATCH oder vMAJOR.MINOR.PATCH)"
    }

    return $normalized
}

function Update-Changelog {
    param(
        [string]$Content,
        [string]$ReleaseVersion,
        [string]$ReleaseDate
    )

    $escapedVersion = [regex]::Escape($ReleaseVersion)
    if ($Content -match "(?m)^## \[$escapedVersion\]") {
        throw "CHANGELOG.md enthaelt bereits einen Abschnitt fuer Version $ReleaseVersion."
    }

    $pattern = '(?s)(?<header>.*?## \[Unreleased\]\s*\r?\n)(?<unreleased>.*?)(?<rest>\r?\n## \[[^\]]+\].*)'
    if ($Content -notmatch $pattern) {
        throw "CHANGELOG.md: Abschnitt [Unreleased] nicht gefunden oder kein Release-Abschnitt darunter."
    }

    $header = $Matches['header'].TrimEnd()
    $unreleased = $Matches['unreleased'].Trim()
    $rest = $Matches['rest'].TrimStart()

    if (-not $unreleased) {
        throw "CHANGELOG.md: Abschnitt [Unreleased] ist leer."
    }

    $newSection = "## [$ReleaseVersion] - $ReleaseDate`n`n$unreleased"

    return "$header`n`n$newSection`n`n$rest`n"
}

$releaseVersion = Normalize-Version -Value $Version
$changelogContent = Get-Content $changelogFile -Raw -Encoding UTF8
$newChangelog = Update-Changelog -Content $changelogContent -ReleaseVersion $releaseVersion -ReleaseDate $Date

Write-Host "CHANGELOG.md: [Unreleased] -> [$releaseVersion] - $Date"
if ($DryRun) {
    Write-Host "[DryRun] CHANGELOG.md wuerde aktualisiert."
    return
}

Set-Content -Path $changelogFile -Value $newChangelog.TrimEnd() -Encoding UTF8
Add-Content -Path $changelogFile -Value '' -Encoding UTF8
Write-Host "CHANGELOG.md aktualisiert."
