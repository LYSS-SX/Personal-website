param(
  [int]$Width = 320,
  [int]$Limit = 0,
  [string]$ProjectRoot = ''
)

$ErrorActionPreference = 'Stop'
$repoRoot = if ($ProjectRoot) { (Resolve-Path -LiteralPath $ProjectRoot).Path } else { Split-Path -Parent $PSScriptRoot }
$dataPath = Join-Path $repoRoot 'portfolio-data.js'
$raw = Get-Content -Raw -Encoding utf8 -LiteralPath $dataPath
$json = $raw -replace '^\s*window\.PORTFOLIO_DATA\s*=\s*', '' -replace ';\s*$', ''
$data = $json | ConvertFrom-Json
$ffmpegLink = (Get-Command ffmpeg -ErrorAction Stop).Source
$ffmpeg = (Get-Item -LiteralPath $ffmpegLink).Target
if (-not $ffmpeg) { $ffmpeg = $ffmpegLink }
$projects = @($data.aiProducts) + @($data.renderProducts)
$sources = @($projects | ForEach-Object { $_.images } | ForEach-Object { $_.src } | Where-Object { $_ } | Select-Object -Unique)
if ($Limit -gt 0) { $sources = @($sources | Select-Object -First $Limit) }

foreach ($relativeSource in $sources) {
  $source = Join-Path $repoRoot $relativeSource
  if (-not (Test-Path -LiteralPath $source)) {
    Write-Warning "Missing source: $relativeSource"
    continue
  }

  $assetRelative = $relativeSource -replace '^assets-v8[/\\]', ''
  $relativeOutput = [IO.Path]::ChangeExtension($assetRelative, '.webp')
  $output = Join-Path $repoRoot (Join-Path 'assets-v8\wall-thumbs' $relativeOutput)
  $outputDir = Split-Path -Parent $output
  New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

  & $ffmpeg -hide_banner -loglevel error -y -i $source `
    -vf "scale=$Width`:-2:force_original_aspect_ratio=decrease" `
    -frames:v 1 -c:v libwebp -quality 64 -compression_level 5 $output
  if ($LASTEXITCODE -ne 0) { throw "ffmpeg failed: $relativeSource" }
}

$total = (Get-ChildItem -LiteralPath (Join-Path $repoRoot 'assets-v8\wall-thumbs') -Recurse -File | Measure-Object Length -Sum).Sum
Write-Output "Generated $($sources.Count) wall thumbnails ($([math]::Round($total / 1MB, 2)) MB)."
