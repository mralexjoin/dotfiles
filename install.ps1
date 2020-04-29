if ($PSVersionTable.PSVersion.Major -lt 6) {
    throw "Version of PowerShell has to be not less than 6.0.0"
}

# Powershell
Install-Module -Name posh-git   -Force -Scope CurrentUser
Install-Module -Name oh-my-posh -Force -Scope CurrentUser

$VimSettingsDirectory = "$PSScriptRoot\vim\settings"
# Vim plugins
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
    $uri,
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "$VimSettingsDirectory\plug.vim"
    )
)

function Source-Vim-Config($In, $Out)
{
    "source $In" > $Out
}

function Make-Symbolic-Link($In, $Out)
{
    New-Item -ItemType SymbolicLink -Force -Value $In -Path $Out > $null
}

$VimSettings = "$VimSettingsDirectory\.vim"
@(
    @(
        $(Get-Item function:Source-Vim-Config),
        "$VimSettings",
        "$HOME\_vimrc"
    ),
    @(
        $(Get-Item function:Source-Vim-Config),
        "$VimSettings",
        "$env:LOCALAPPDATA\nvim\init.vim"
    ),
    @(
        $(Get-Item function:Source-Vim-Config),
        "$VimSettingsDirectory\common.vim",
        "$HOME\vsvim\common.vim"
    ),
    @(
        $(Get-Item function:Source-Vim-Config),
        "$VimSettingsDirectory\vs.vim",
        "$HOME\_vsvimrc"
    ),
    @(
        $(Get-Item function:Make-Symbolic-Link),
        "$PSScriptRoot\powershell\profile.ps1",
        "$([Environment]::GetFolderPath("MyDocuments"))\PowerShell\Microsoft.PowerShell_profile.ps1"
    ),
    @(
        $(Get-Item function:Make-Symbolic-Link),
        "$PSScriptRoot\conemu\settings.xml",
        "$env:APPDATA\ConEmu.xml"
    )
) | foreach {
   New-Item -ItemType Directory -Force -Path $(Split-Path -Path $_[2] -Parent) > $null
   & $_[0] $_[1] $_[2]
}

