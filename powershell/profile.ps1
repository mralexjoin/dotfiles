Import-Module posh-git
Import-Module oh-my-posh

Set-Theme Agnoster
$env:LC_ALL="ru_RU.UTF-8"

[console]::InputEncoding = [System.Text.Encoding]::UTF8
[console]::OutputEncoding = [System.Text.Encoding]::UTF8

$PSReadLineOptions = @{
    EditMode = "Vi"
    HistoryNoDuplicates = $true
    ViModeIndicator = "Cursor"
}

Set-PSReadLineOption @PSReadLineOptions
Set-PSReadLineKeyHandler -Chord "k" -ViMode Command -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord "j" -ViMode Command -Function HistorySearchForward

