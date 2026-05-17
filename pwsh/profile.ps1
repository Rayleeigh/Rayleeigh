# =========================
# Oh My Posh Startup
# =========================

$Global:OmpThemeDir = "$HOME\.poshthemes"
$Global:OmpThemePath = "$Global:OmpThemeDir\cloud-native-azure.omp.json"
$Global:OmpThemeUrl = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/cloud-native-azure.omp.json"

if (Test-Path $Global:OmpThemePath) {
    oh-my-posh init pwsh --config $Global:OmpThemePath | Invoke-Expression
}

# =========================
# Command Registry
# =========================

$Global:ProfileCommands = [ordered]@{
    "go-git"                         = "Open ~/Documents/GitHub"
    "git-clo <user> <repo>"          = "Clone a GitHub repository"
    "git-clo <user> <repo> -Open"    = "Clone + open in VS Code"
    "open-repo <repo>"               = "Find and open a local repo in VS Code"
    "edit-profile"                   = "Open this profile in VS Code"
    "reload-profile"                 = "Reload this PowerShell profile"
    "mkcd <folder>"                  = "Create a folder and enter it"
    "cls-all"                        = "Clear screen and command history"
    "gs"                             = "Git status"
    "ga"                             = "Git add ."
    "gcmsg <message>"                = "Git commit with message"
    "gp"                             = "Git push"
    "gl"                             = "Git pull"
    "omp pull profile"               = "Download/update Oh My Posh theme"
    "omp set profile"                = "Load local Oh My Posh theme"
    "add-command <cmd> <desc>"       = "Add/update a command in this session"
    "manual"                         = "Show all available profile commands"
}

function add-command {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Command,

        [Parameter(Mandatory=$true)]
        [string]$Description
    )

    $Global:ProfileCommands[$Command] = $Description

    Write-Host ""
    Write-Host "Command added:" -ForegroundColor Green
    "{0,-35} {1}" -f "  $Command", "→ $Description" | Write-Host -ForegroundColor White
    Write-Host ""
}

# =========================
# GitHub Shortcuts
# =========================

function go-git {
    $githubDir = "$HOME\Documents\GitHub"

    if (!(Test-Path $githubDir)) {
        New-Item -ItemType Directory -Path $githubDir | Out-Null
    }

    Set-Location $githubDir
}

function git-clo {
    param(
        [string]$User,
        [string]$Repo,
        [switch]$Open
    )

    if (-not $User -or -not $Repo) {
        Write-Host "Usage: git-clo <github-user> <repository> [-Open]" -ForegroundColor Yellow
        return
    }

    $githubDir = "$HOME\Documents\GitHub"

    if (!(Test-Path $githubDir)) {
        New-Item -ItemType Directory -Path $githubDir | Out-Null
    }

    Set-Location $githubDir

    git clone "https://github.com/$User/$Repo"

    $repoPath = Join-Path $githubDir $Repo

    if (Test-Path $repoPath) {
        Set-Location $repoPath

        Write-Host ""
        Write-Host "Opened repository:" -ForegroundColor Green
        Write-Host $repoPath -ForegroundColor Cyan

        if ($Open) {
            code .
        }
    }
}

function open-repo {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Repo
    )

    $searchRoots = @(
        "$HOME\Documents\GitHub",
        "$HOME\Documents",
        "$HOME\Desktop",
        "$HOME\Downloads"
    )

    $matches = foreach ($root in $searchRoots) {
        if (Test-Path $root) {
            Get-ChildItem -Path $root -Directory -Recurse -ErrorAction SilentlyContinue |
                Where-Object {
                    $_.Name -like "*$Repo*" -and
                    (Test-Path "$($_.FullName)\.git")
                }
        }
    }

    if (-not $matches) {
        Write-Host ""
        Write-Host "Repository not found: $Repo" -ForegroundColor Red
        return
    }

    if ($matches.Count -gt 1) {
        Write-Host ""
        Write-Host "Multiple repositories found:" -ForegroundColor Yellow
        Write-Host ""

        for ($i = 0; $i -lt $matches.Count; $i++) {
            Write-Host "[$i] $($matches[$i].FullName)"
        }

        Write-Host ""
        $choice = Read-Host "Choose repository number"

        if ($choice -notmatch '^\d+$' -or [int]$choice -ge $matches.Count) {
            Write-Host "Invalid selection." -ForegroundColor Red
            return
        }

        $selected = $matches[[int]$choice]
    }
    else {
        $selected = $matches[0]
    }

    Set-Location $selected.FullName

    Write-Host ""
    Write-Host "Opening repository:" -ForegroundColor Green
    Write-Host $selected.FullName -ForegroundColor Cyan
    Write-Host ""

    code .
}

# =========================
# Oh My Posh Helper
# =========================

function omp {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("pull", "set")]
        [string]$Action,

        [Parameter(Mandatory=$true)]
        [ValidateSet("profile")]
        [string]$Target
    )

    if ($Action -eq "pull" -and $Target -eq "profile") {
        New-Item -ItemType Directory -Force $Global:OmpThemeDir | Out-Null

        Invoke-WebRequest `
            -Uri $Global:OmpThemeUrl `
            -OutFile $Global:OmpThemePath

        Write-Host "Oh My Posh theme downloaded:" -ForegroundColor Green
        Write-Host $Global:OmpThemePath -ForegroundColor Cyan
    }

    if ($Action -eq "set" -and $Target -eq "profile") {
        if (!(Test-Path $Global:OmpThemePath)) {
            Write-Host "Theme not found. Run this first:" -ForegroundColor Yellow
            Write-Host "omp pull profile" -ForegroundColor Cyan
            return
        }

        oh-my-posh init pwsh --config $Global:OmpThemePath | Invoke-Expression
        Write-Host "Oh My Posh profile loaded." -ForegroundColor Green
    }
}

# =========================
# Profile Helpers
# =========================

function edit-profile {
    code $PROFILE
}

function reload-profile {
    . $PROFILE
    Write-Host "Profile reloaded." -ForegroundColor Green
}

function mkcd {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name
    )

    New-Item -ItemType Directory -Force $Name | Out-Null
    Set-Location $Name
}

function cls-all {
    Clear-Host
    Get-History | Clear-History
}

# =========================
# Git Shortcuts
# =========================

function gs { git status }
function ga { git add . }

function gcmsg {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    git commit -m $Message
}

function gp { git push }
function gl { git pull }

# =========================
# Manual + MOTD
# =========================

function Show-CommandList {
    foreach ($cmd in $Global:ProfileCommands.GetEnumerator()) {
        "{0,-35} {1}" -f "  $($cmd.Key)", "→ $($cmd.Value)" | Write-Host -ForegroundColor White
    }
}

function manual {
    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║              PowerShell Manual              ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""

    Write-Host " Available Commands" -ForegroundColor Yellow
    Write-Host " ─────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host ""

    Show-CommandList

    Write-Host ""
}

function Show-MOTD {
    Clear-Host

    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║         GitHub PowerShell Toolkit           ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""

    Write-Host " Available Commands" -ForegroundColor Yellow
    Write-Host " ─────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host ""

    Show-CommandList
    Write-Host ""
    Write-Host " ─────────────────────────────────────────────" -ForegroundColor DarkGray
}

Show-MOTD
