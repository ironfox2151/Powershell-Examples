$timestamp = Get-date -Verbose -Format FileDateTime
Start-Transcript -Path $env:USERPROFILE\Documents\Logs\InactiveUserSearch\$timestamp.log 

#Log Cleanup
$TDate = Get-Date
$OldLogDate = $TDate.AddDays(-30)
Get-ChildItem -Path $env:USERPROFILE\Documents\Logs\InactiveUserSearch\ | Where-Object {$_.LastWriteTime -lt $OldLogDate } | Remove-Item

#Today's Date
$Date = Get-Date -DisplayHint Date 

#Get Today's Date minus 90 days
$Date = (Get-Date).AddDays(-90) 

#Get Today's Date minus 90 days in timestamp format
$dateTimestamp = (Get-Date).addDays(-90).ToFileTime()

#OU to move inactive users to
$TargetOU = "OU=Disabled Users,DC=foo,DC=bar"

#Find users that have not been created within 90 days and have not logged in for 90 days
#This also only targets the users within the store OUs
$InactiveUsers = Get-ADUser -filter * -properties SamAccountName,lastlogontimestamp,WhenCreated,Name,DistinguishedName,Enabled,PasswordLastSet,CannotChangePassword,EmailAddress,PasswordNeverExpires |
 where {($_.enabled) -and 
 ($_.lastlogontimestamp -lt $datetimestamp) -and
 ($_.whenCreated -lt $Date) -and
 ($_.CannotChangePassword -notlike "TRUE") -and
 ($_.PasswordNeverExpires -notlike "TRUE") -and
 ($_.distinguishedname -notlike "*OU=Disabled Users,DC=foo,DC=bar") -and
 ($_.distinguishedname -notlike"*OU=Internal,OU=Group,DC=foo,DC=bar")
  } 


 ForEach ($user in $InactiveUsers)
 {
    # Retrieve Distinguished Name of User.
    #$User = (Get-ADUser -Identity $_.samAccountName)

    # Set user Discription
    Set-ADUser $User.SamAccountName -Description "Auto Disabled - 90 Days inactiviy - on $date" -Enabled $false  -Verbose

    #Disable User
    Get-ADUser -Identity $User.samAccountName | Disable-ADAccount -Verbose

    # Move user to target OU.
    Move-ADObject -Identity $User -TargetPath $TargetOU -Verbose
   
}

Stop-Transcript