$src='src\content\blog'
$outBase='public\writing'
Get-ChildItem -Path $src -Filter '*.md' | ForEach-Object {
  $slug = $_.BaseName
  $dir = Join-Path $outBase $slug
  if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
  $html = "<!doctype html>`n<html lang=\"en\">`n<head>`n  <meta charset=\"utf-8\">`n  <meta http-equiv=\"refresh\" content=\"0; url=/blog/$slug/\">`n  <link rel=\"canonical\" href=\"https://nagusubra.github.io/blog/$slug/\">`n  <title>Page moved</title>`n</head>`n<body>`n  <p>This page has moved to <a href=\"/blog/$slug/\">/blog/$slug/</a>.</p>`n</body>`n</html>"
  Set-Content -Path (Join-Path $dir 'index.html') -Value $html
  Write-Output "WROTE redirect for $slug"
}
