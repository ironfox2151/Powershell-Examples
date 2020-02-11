$HomedriveUsers = Get-ADUser -Filter {(HomeDrive -ne '$Null') -and (Enabled -ne 'True')} -Property Name,Enabled,DisplayName,DistinguishedName,HomeDirectory,HomeDrive,SamAccountName
ForEach ($HomedriveUser  in $HomedriveUsers)
 {
    set-aduser -Identity $HomedriveUser.SamAccountName -clear HomeDrive,HomeDirectory
}
