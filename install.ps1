$VimSettingsDirectory = "$PSScriptRoot\vim\settings"
# Vim plugins
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
    $uri,
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "$VimSettingsDirectory\plug.vim"
    )
)

$VimSettings = "$VimSettingsDirectory\.vim"
# Vim settings
"source $VimSettings" > "$HOME\_vimrc"

# Neovim settings
$NeovimSettingsDirectoryOut = "$env:LOCALAPPDATA\nvim"
New-Item -ItemType Directory -Force -Path "$NeovimSettingsDirectoryOut" > $null
"source $VimSettings" > "$NeovimSettingsDirectoryOut\init.vim"

# VsVim
$VsVimSettingsDirectoryOut = "$HOME\vsvim"
$VsVimCommonSettings = "$HOME\vsvim\common.vim"
New-Item -ItemType Directory -Force -Path "$VsVimSettingsDirectoryOut" > $null
"source $VimSettingsDirectory\common.vim" > "$VsVimCommonSettings"
"source $VsVimCommonSettings" > "$HOME\_vsvimrc"
"source $VimSettingsDirectory\vs.vim" >> "$HOME\_vsvimrc"

# Powershell
Install-Module -Name posh-git   -Force -Scope CurrentUser
Install-Module -Name oh-my-posh -Force -Scope CurrentUser

$PSConfigOutPath = "$([Environment]::GetFolderPath("MyDocuments"))\PowerShell"
New-Item -ItemType Directory -Force -Path "$PSConfigOutPath" > $null
$PSConfigIn  = "$PSScriptRoot\powershell\profile.ps1"
$PSConfigOut = "$PSConfigOutPath\Microsoft.PowerShell_profile.ps1"
". $PSConfigIn" > $PSConfigOut

