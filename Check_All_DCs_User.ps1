$DCs = Get-ADDomainController -Filter * 

foreach ($DC in $DCs){
Write-host $DC
Get-ADUser -Filter "samaccountname -like '*name*'" -Properties * -Server $DC.name | Select-Object -Property DistinguishedName | Write-Host

}
