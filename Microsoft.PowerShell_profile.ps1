# 出力エンコーディングをUTF-8に設定
$OutputEncoding = [System.Text.Encoding]::UTF8
# コンソールの入出力エンコーディングをUTF-8（65001）に設定
[Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Cursor

Set-Alias ls Get-Childitem

Set-Alias rm Remove-Item
Set-Alias cp Copy-Item
Set-Alias mv Move-Item

function prompt {
    $path = Get-Location
    Write-Host "PS" "$path" -NoNewline -ForegroundColor Cyan 
    return "> "
}
