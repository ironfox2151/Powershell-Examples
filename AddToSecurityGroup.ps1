import-Module ActiveDirectory
foreach ($item in (Import-CSV C:\Users\joscher\Documents\users.csv -Delimiter ",")) {
    Add-ADGroupMember -Identity "CN=Jsmith,OU=Security Groups,DC=foo,DC=bar" -Members $item.SAM
}

#Get-ADGroup -Filter {name -like "HR Checklist"}