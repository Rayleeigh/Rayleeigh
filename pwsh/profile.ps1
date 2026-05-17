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
    "ai-tools" = @{
    Summary    = "List installed AI coding tools"
    Usage      = "ai-tools"
    Parameters = @()
    Details    = "Checks common AI coding CLI tools like Claude Code, Codex, Cursor, Aider, Gemini, and more."
    }
    "go-git" = @{
        Summary    = "Open ~/Documents/GitHub"
        Usage      = "go-git"
        Parameters = @()
        Details    = "Creates ~/Documents/GitHub if missing, then moves your terminal into it."
    }

    "git-clo <user> <repo>" = @{
        Summary    = "Clone a GitHub repository"
        Usage      = "git-clo microsoft vscode"
        Parameters = @(
            "<user> = GitHub username or organization"
            "<repo> = Repository name only"
        )
        Details    = "Clones https://github.com/<user>/<repo> into ~/Documents/GitHub."
    }

    "git-clo <user> <repo> -Open" = @{
        Summary    = "Clone + open in VS Code"
        Usage      = "git-clo microsoft vscode -Open"
        Parameters = @(
            "<user> = GitHub username or organization"
            "<repo> = Repository name only"
            "-Open  = Optional flag. Opens the cloned repo in VS Code"
        )
        Details    = "Clones the repository, enters the folder, then opens it with code ."
    }

    "open-repo <repo>" = @{
        Summary    = "Find and open a local repo in VS Code"
        Usage      = "open-repo vscode"
        Parameters = @(
            "<repo> = Full or partial local repository folder name"
        )
        Details    = "Searches Documents/GitHub, Documents, Desktop, and Downloads for matching Git repositories."
    }

    "edit-profile" = @{
        Summary    = "Open this profile in VS Code"
        Usage      = "edit-profile"
        Parameters = @()
        Details    = "Opens your PowerShell profile file in VS Code."
    }

    "reload-profile" = @{
        Summary    = "Reload this PowerShell profile"
        Usage      = "reload-profile"
        Parameters = @()
        Details    = "Reloads your profile without restarting PowerShell."
    }

    "mkcd <folder>" = @{
        Summary    = "Create a folder and enter it"
        Usage      = "mkcd my-project"
        Parameters = @(
            "<folder> = Folder name or path to create"
        )
        Details    = "Creates the folder if missing, then moves into it."
    }

    "cls-all" = @{
        Summary    = "Clear screen and command history"
        Usage      = "cls-all"
        Parameters = @()
        Details    = "Clears the terminal screen and the current session command history."
    }

    "gs" = @{
        Summary    = "Git status"
        Usage      = "gs"
        Parameters = @()
        Details    = "Shortcut for git status."
    }

    "ga" = @{
        Summary    = "Git add ."
        Usage      = "ga"
        Parameters = @()
        Details    = "Stages all changed files in the current Git repository."
    }

    "gcmsg <message>" = @{
        Summary    = "Git commit with message"
        Usage      = 'gcmsg "Update profile tools"'
        Parameters = @(
            "<message> = Commit message wrapped in quotes"
        )
        Details    = "Creates a Git commit using the provided message."
    }

    "gp" = @{
        Summary    = "Git push"
        Usage      = "gp"
        Parameters = @()
        Details    = "Pushes committed changes to the configured remote branch."
    }

    "gl" = @{
        Summary    = "Git pull"
        Usage      = "gl"
        Parameters = @()
        Details    = "Pulls latest changes from the configured remote branch."
    }

    "omp pull profile <theme>" = @{
        Summary    = "Download an Oh My Posh theme"
        Usage      = "omp pull profile cloud-native-azure"
        Parameters = @(
            "pull      = Download/update action"
            "profile   = Theme profile target"
            "<theme>   = Theme name without .omp.json"
        )
        Details    = "Downloads a theme from the official Oh My Posh themes repository into ~/.poshthemes."
    }

    "omp list themes" = @{
        Summary    = "List locally installed Oh My Posh themes"
        Usage      = "omp list themes"
        Parameters = @(
            "list   = List action"
            "themes = Local themes target"
        )
        Details    = "Lists all .omp.json theme files stored in ~/.poshthemes."
    }

    "omp set profile <theme>" = @{
        Summary    = "Load a local Oh My Posh theme"
        Usage      = "omp set profile cloud-native-azure"
        Parameters = @(
            "set      = Load/apply action"
            "profile  = Theme profile target"
            "<theme>  = Local theme name without .omp.json"
        )
        Details    = "Loads the selected local Oh My Posh theme and reloads the PowerShell profile."
    }

    "add-command <cmd> <summary>" = @{
        Summary    = "Add/update a command in this session"
        Usage      = 'add-command "deploy <env>" "Deploy project" "deploy prod" @("<env> = Target environment") "Deploys the project."'
        Parameters = @(
            "<cmd>        = Command name/signature"
            "<summary>    = Short description"
            "<usage>      = Optional usage example"
            "<parameters> = Optional parameter list"
            "<details>    = Optional detailed explanation"
        )
        Details    = "Adds or updates a command in the current in-memory command registry."
    }

    "manual" = @{
        Summary    = "Show compact command overview"
        Usage      = "manual"
        Parameters = @()
        Details    = "Shows all registered profile commands in compact format."
    }

    "manual -Advanced -Search <cmdlet>" = @{
        Summary    = "Show detailed paginated manual"
        Usage      = "manual -Advanced -Search ai-tools -PageSize 5"
        Parameters = @(
            "-Advanced = Show detailed command documentation"
            "-Search   = Optional command search keyword"
            "-PageSize = Optional number of commands per page"
        )
        Details    = "Shows detailed command help with usage, parameters, explanations, and optional search filtering."
    }
}

# =========================
# Registry Helper
# =========================

function add-command {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Command,

        [Parameter(Mandatory=$true)]
        [string]$Summary,

        [string]$Usage = $Command,

        [string[]]$Parameters = @(),

        [string]$Details = $Summary
    )

    $Global:ProfileCommands[$Command] = @{
        Summary    = $Summary
        Usage      = $Usage
        Parameters = $Parameters
        Details    = $Details
    }

    Write-Host ""
    Write-Host "Command added:" -ForegroundColor Green
    "{0,-35} {1}" -f "  $Command", "→ $Summary" | Write-Host -ForegroundColor White
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
        [ValidateSet("pull", "set", "list")]
        [string]$Action,

        [Parameter(Mandatory=$true)]
        [ValidateSet("profile", "themes")]
        [string]$Target,

        [string]$Theme
    )

    if ($Action -eq "pull" -and $Target -eq "profile") {

        if (-not $Theme) {
            Write-Host "Usage: omp pull profile <theme-name>" -ForegroundColor Yellow
            Write-Host "Example: omp pull profile cloud-native-azure" -ForegroundColor Cyan
            return
        }

        New-Item -ItemType Directory -Force $Global:OmpThemeDir | Out-Null

        $themeFile = "$Theme.omp.json"
        $themePath = Join-Path $Global:OmpThemeDir $themeFile
        $themeUrl = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/$themeFile"

        Invoke-WebRequest `
            -Uri $themeUrl `
            -OutFile $themePath

        Write-Host ""
        Write-Host "Oh My Posh theme downloaded:" -ForegroundColor Green
        Write-Host $themePath -ForegroundColor Cyan
        Write-Host ""
    }

    if ($Action -eq "list" -and $Target -eq "themes") {

        if (!(Test-Path $Global:OmpThemeDir)) {
            Write-Host "No local Oh My Posh themes found." -ForegroundColor Yellow
            return
        }

        $themes = Get-ChildItem -Path $Global:OmpThemeDir -Filter "*.omp.json"

        if (-not $themes) {
            Write-Host "No local Oh My Posh themes found." -ForegroundColor Yellow
            return
        }

        Write-Host ""
        Write-Host "╔══════════════════════════════════════════════╗" -ForegroundColor Cyan
        Write-Host "║          Local Oh My Posh Themes            ║" -ForegroundColor Green
        Write-Host "╚══════════════════════════════════════════════╝" -ForegroundColor Cyan
        Write-Host ""

        foreach ($theme in $themes) {
            $themeName = $theme.Name -replace "\.omp\.json$", ""
            Write-Host "  $themeName" -ForegroundColor Cyan
        }

        Write-Host ""
    }

    if ($Action -eq "set" -and $Target -eq "profile") {

        if (-not $Theme) {
            Write-Host "Usage: omp set profile <theme-name>" -ForegroundColor Yellow
            Write-Host "Example: omp set profile cloud-native-azure" -ForegroundColor Cyan
            return
        }

        $themePath = Join-Path $Global:OmpThemeDir "$Theme.omp.json"

        if (!(Test-Path $themePath)) {
            Write-Host "Theme not found locally:" -ForegroundColor Red
            Write-Host $themePath -ForegroundColor Cyan
            Write-Host ""
            Write-Host "Download it first with:" -ForegroundColor Yellow
            Write-Host "omp pull profile $Theme" -ForegroundColor Cyan
            return
        }

        $Global:OmpThemePath = $themePath

        oh-my-posh init pwsh --config $themePath | Invoke-Expression

        Write-Host ""
        Write-Host "Oh My Posh theme loaded:" -ForegroundColor Green
        Write-Host $themePath -ForegroundColor Cyan
        Write-Host ""

        . $PROFILE
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
# AI Helpers
# =========================

function ai-tools {

    $tools = [ordered]@{
        "GitHub Copilot CLI" = "gh"
        "OpenAI CLI"         = "openai"
        "Claude Code"        = "claude"
        "Codex CLI"          = "codex"
        "Cursor"             = "cursor"
        "Windsurf"           = "windsurf"
        "Aider"              = "aider"
        "Continue CLI"       = "continue"
        "Gemini CLI"         = "gemini"
        "Qwen Code"          = "qwen"
        "Cline"              = "cline"
        "Tabby"              = "tabby"
    }

    $installed = @()

    foreach ($tool in $tools.GetEnumerator()) {

        $cmd = Get-Command $tool.Value -ErrorAction SilentlyContinue

        if ($cmd) {
            $installed += [PSCustomObject]@{
                Name = $tool.Key
                Command = $tool.Value
                Path = $cmd.Source
            }
        }
    }

    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║          Installed AI Coding Tools          ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""

    if ($installed.Count -eq 0) {
        Write-Host "No supported AI coding tools detected." -ForegroundColor Yellow
        Write-Host ""
        return
    }

    foreach ($tool in $installed) {

        Write-Host " Tool:    " -ForegroundColor Yellow -NoNewline
        Write-Host $tool.Name -ForegroundColor Green

        Write-Host " Command: " -ForegroundColor Yellow -NoNewline
        Write-Host $tool.Command -ForegroundColor Cyan

        Write-Host " Path:    " -ForegroundColor Yellow -NoNewline
        Write-Host $tool.Path -ForegroundColor White

        Write-Host ""
    }
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
        "{0,-35} {1}" -f "  $($cmd.Key)", "→ $($cmd.Value.Summary)" | Write-Host -ForegroundColor White
    }
}

function manual {
    param(
        [switch]$Advanced,
        [string]$Search,
        [int]$PageSize = 5
    )

    $commands = @($Global:ProfileCommands.GetEnumerator())

    if ($Search) {
        $commands = @(
            $commands | Where-Object {
                $_.Key -like "*$Search*" -or
                $_.Value.Summary -like "*$Search*" -or
                $_.Value.Usage -like "*$Search*" -or
                $_.Value.Details -like "*$Search*"
            }
        )
    }

    if (-not $Advanced) {
        Write-Host ""
        Write-Host "╔══════════════════════════════════════════════╗" -ForegroundColor Cyan
        Write-Host "║              PowerShell Manual              ║" -ForegroundColor Green
        Write-Host "╚══════════════════════════════════════════════╝" -ForegroundColor Cyan
        Write-Host ""

        Write-Host " Command Overview" -ForegroundColor Yellow
        Write-Host " ─────────────────────────────────────────────" -ForegroundColor DarkGray
        Write-Host ""

        foreach ($cmd in $commands) {
            "{0,-35} {1}" -f "  $($cmd.Key)", "→ $($cmd.Value.Summary)" | Write-Host -ForegroundColor White
        }

        Write-Host ""
        Write-Host "Tip: Run 'manual -Advanced' for detailed help." -ForegroundColor DarkGray
        Write-Host "Tip: Run 'manual -Advanced -Search git-clo' to search." -ForegroundColor DarkGray
        Write-Host ""
        return
    }

    if ($commands.Count -eq 0) {
        Write-Host ""
        Write-Host "No commands found matching: $Search" -ForegroundColor Red
        Write-Host ""
        return
    }

    $total = $commands.Count
    $page = 0
    $totalPages = [Math]::Ceiling($total / $PageSize)

    while ($page * $PageSize -lt $total) {
        Clear-Host

        $start = $page * $PageSize
        $end = [Math]::Min($start + $PageSize - 1, $total - 1)

        Write-Host ""
        Write-Host "╔══════════════════════════════════════════════╗" -ForegroundColor Cyan
        Write-Host "║          Advanced PowerShell Manual         ║" -ForegroundColor Green
        Write-Host "╚══════════════════════════════════════════════╝" -ForegroundColor Cyan
        Write-Host ""

        if ($Search) {
            Write-Host " Search: $Search" -ForegroundColor Yellow
        }

        Write-Host " Page $($page + 1) of $totalPages" -ForegroundColor Yellow
        Write-Host " ─────────────────────────────────────────────" -ForegroundColor DarkGray
        Write-Host ""

        for ($i = $start; $i -le $end; $i++) {
            $cmd = $commands[$i]

            Write-Host " Command:   " -ForegroundColor Yellow -NoNewline
            Write-Host "$($cmd.Key)" -ForegroundColor Green

            Write-Host " Usage:     " -ForegroundColor Yellow -NoNewline
            Write-Host "$($cmd.Value.Usage)" -ForegroundColor Cyan

            Write-Host " Summary:   " -ForegroundColor Yellow -NoNewline
            Write-Host "$($cmd.Value.Summary)" -ForegroundColor White

            Write-Host " Parameters:" -ForegroundColor Yellow

            if ($cmd.Value.Parameters -and $cmd.Value.Parameters.Count -gt 0) {
                foreach ($param in $cmd.Value.Parameters) {
                    Write-Host "   - $param" -ForegroundColor White
                }
            }
            else {
                Write-Host "   - None" -ForegroundColor DarkGray
            }

            Write-Host " Details:   " -ForegroundColor Yellow -NoNewline
            Write-Host "$($cmd.Value.Details)" -ForegroundColor White
            Write-Host ""
        }

        if ($end -ge ($total - 1)) {
            Write-Host "End of manual." -ForegroundColor DarkGray
            Write-Host ""
            break
        }

        $next = Read-Host "Press Enter for next page, or type q to quit"

        if ($next -eq "q") {
            break
        }

        $page++
    }
}

function Show-MOTD {
    Clear-Host

    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║         GitHub PowerShell Toolkit           ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""

    Write-Host " Command Overview" -ForegroundColor Yellow
    Write-Host " ─────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host ""

    Show-CommandList

    Write-Host ""
    Write-Host " Examples" -ForegroundColor Yellow
    Write-Host " ─────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host ""

    Write-Host "  go-git" -ForegroundColor Cyan
    Write-Host "  git-clo microsoft vscode -Open" -ForegroundColor Cyan
    Write-Host "  open-repo vscode" -ForegroundColor Cyan
    Write-Host "  omp pull profile" -ForegroundColor Cyan
    Write-Host "  omp set profile" -ForegroundColor Cyan
    Write-Host "  manual -Advanced -Search <cmdlet>" -ForegroundColor Cyan
    Write-Host ""
    Write-Host " ─────────────────────────────────────────────" -ForegroundColor DarkGray
}

Show-MOTD
