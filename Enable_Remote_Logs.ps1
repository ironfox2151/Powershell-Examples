$Computer = Read-Host "Enter Computer Name"
$PSTools = "C:\Users\user\Documents\Scripts\SysinternalsSuite"

# Enables Powershell Remoting
Param ([Parameter(Mandatory=$true)]
[System.String[]]$Computer)
ForEach ($comp in $computer ) {
    Start-Process -Filepath $PSTools -Argumentlist "\\$comp -h -d winrm.cmd quickconfig -q" -Credential $cred
	Write-Host "Enabling WINRM Quickconfig" -ForegroundColor Green
	Write-Host "Waiting for 60 Seconds......." -ForegroundColor Yellow
	Start-Sleep -Seconds 60 -Verbose	
    Start-Process -Filepath $PSTools -Argumentlist "\\$comp -h -d powershell.exe enable-psremoting -force" -Credential $cred
	Write-Host "Enabling PSRemoting" -ForegroundColor Green
    Start-Process -Filepath $PSTools -Argumentlist "\\$comp -h -d powershell.exe set-executionpolicy RemoteSigned -force" -Credential $cred
	Write-Host "Enabling Execution Policy" -ForegroundColor Green	
    Test-Wsman -ComputerName $comp
}          

#Invoke-Command -ComputerName $Computer -ScriptBlock {Get-NetFirewallRule -DisplayGroup "Remote Event Log Management" | Enable-NetFirewallRule} -UseSSL

