Import-Module ActiveDirectory
foreach ($item in (Import-CSV C:\Users\name\Documents\users.csv -Delimiter ",")) {
      $userMail = $item.ContactEmail
      $userSAM = Get-ADUser -Filter {mail -eq $userMail} | Select-Object -ExpandProperty SamAccountName
      Write-Host $item.WfnName","$UserSAM 
      
}


