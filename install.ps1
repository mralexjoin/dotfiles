$InstallDirectory = $args[0]

$VimSettingsDirectory = "$PSScriptRoot\vim\settings"
# Vim plugins
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
    $uri,
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "$VimSettingsDirectory\plug.vim"
    )
)

# Vim settings
"source $VimSettingsDirectory\.vim" > "$InstallDirectory\_vimrc"

