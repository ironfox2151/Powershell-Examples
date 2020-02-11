$timestamp = Get-date -Verbose -Format FileDateTime
Start-Transcript -Path $env:USERPROFILE\Documents\Logs\CleanDisabledComputer\$timestamp.log 

#Log Cleanup
$TDate = Get-Date
$OldLogDate = $TDate.AddDays(-30)
Get-ChildItem -Path $env:USERPROFILE\Documents\Logs\CleanDisabledComputer\ | Where-Object {$_.LastWriteTime -lt $OldLogDate } | Remove-Item

$computers = Get-ADComputer -Filter {Enabled -eq $False} -SearchBase "DC=foo,DC=bar" -Server FMG-DC1 | 
Where-Object -NotLike -Property DistinguishedName -Value ("*OU=Computers1,DC=foo,DC=bar*") |
Where-Object -NotLike -Property DistinguishedName -Value ("*OU=Computers2,OU=OU=Computers1,DC=foo,DC=bar*") |
Where-Object -NotLike -Property DistinguishedName -Value ("*OU=Servers,DC=foo,DC=bar*")

ForEach( $computer in $computers ) { 
   
       Move-ADObject -Identity $computer -TargetPath "OU=Computers2,OU=OU=Computers1,DC=foo,DC=bar"
     
   
} 

Stop-Transcript
