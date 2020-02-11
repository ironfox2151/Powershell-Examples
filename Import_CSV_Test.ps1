$computers = Import-Csv -Path C:\Users\Na\Documents\Win7CSV.csv

foreach ($Computer in $computers) {
   if (Test-Connection -ComputerName $computer.ComputerName -Count 1 -Quiet)
{
Write-host $Computer.ComputerName " Is UP"
}
   else {
    $Computer.ComputerName | Export-Csv -Path C:\Users\Name\Documents\TestedWin7.csv -Append -Verbose
   }
    
}

