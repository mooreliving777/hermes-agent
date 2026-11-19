# Hermes MCP preflight: read-only, Windows PowerShell
# This script does not install packages, register an MCP server, edit settings, start an agent,
# read messages, or invoke any model API. Run it only on a host you control.
$ErrorActionPreference = "Stop"

Write-Host "Hermes Agent / Mellow AI OS read-only preflight"
Write-Host "Hostname: $env:COMPUTERNAME"

$hermes = Get-Command hermes -ErrorAction SilentlyContinue
if ($null -eq $hermes) {
  Write-Host "HERMES: NOT INSTALLED OR NOT ON PATH"
} else {
  Write-Host "HERMES: executable found"
  try { & hermes --version } catch { Write-Host "HERMES: version check failed: $($_.Exception.Message)" }
}
$claude = Get-Command claude -ErrorAction SilentlyContinue
if ($null -eq $claude) {
  Write-Host "CLAUDE CODE: NOT FOUND ON PATH"
} else {
  Write-Host "CLAUDE CODE: executable found"
}

$hermesConfig = Join-Path $env:USERPROFILE ".hermes\config.yaml"
if (Test-Path -LiteralPath $hermesConfig -PathType Leaf) {
  Write-Host "HERMES CONFIG: present (contents intentionally not read)"
} else {
  Write-Host "HERMES CONFIG: not found in default location"
}
Write-Host "MCP DISCOVERY: NOT TESTED. Review messaging permissions before connecting."
Write-Host "NO INSTALL, AUTH, NETWORK CALLS, OR SETTINGS CHANGES PERFORMED."
