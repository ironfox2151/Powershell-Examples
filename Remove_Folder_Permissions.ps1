
#https://4sysops.com/archives/managing-ntfs-permissions-with-powershell/


Get-ChildItem –Path "\\10.0.0.250\e$" –Recurse -Depth 0 -Directory | Get-NTFSAccess -Account foo\jsmith -ExcludeInherited | Remove-NTFSAccess 
