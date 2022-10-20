$Source = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*
$source2 = Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*
$Uninstall = ($Source + $source2) | Where-Object {($_.Publisher -like '*Oracle*')-and ($_.DisplayName -like 'Java*')} | select UninstallString
$UninstallStrings = $Uninstall.UninstallString -replace "MsiExec.exe ","MsiExec.exe /qn " -replace "/I","/X"
ForEach($UninstallString in $UninstallStrings){& cmd /c "$UninstallString"}

Remove-Item $env:Programfiles\Java\ -Force -Recurs
Remove-Item ${env:Programfiles(x86)}\Java\ -Force -Recurs

