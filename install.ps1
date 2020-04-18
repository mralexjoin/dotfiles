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

