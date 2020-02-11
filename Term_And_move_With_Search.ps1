#Set default variable
$result = 6
#Start loop
While($result -ne 7){
$TargetOU = "OU=Disabled Users,DC=foo,DC=bar"
$FullName = Read-Host "Enter Name"
$ListofUsers = Get-ADUser -Filter "name -like '*$FullName*'" -Properties * | Select-Object name, samaccountname, emailaddress, distinguishedname | Sort-Object samaccountname
$Selection = $ListofUsers | Out-GridView -OutputMode Single
if ($Selection) {
    "You picked $Selection"
    $Reason = Read-Host "Enter the reason."
    Set-ADUser $Selection.samaccountname -Description $reason -Enabled $true
    Get-ADUser -Identity $Selection.samaccountname | Disable-ADAccount
    Move-ADObject -Identity $Selection.distinguishedname -TargetPath $TargetOU
    $shell = new-object -comobject "WScript.Shell"
    $result = $shell.popup("Continue with another user??",0,"Question",4+32)
    #Result 6 is the dialog box result of Yes
} else {
    "Cancelled"
    $result = 7
    #Result 7 is the dialog box result of No
   }
}