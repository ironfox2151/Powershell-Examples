$Computers = Get-Content C:\windows\file.txt
Foreach ($Computer in $Computers)
{
    #Ping Test. If PC is shut off, script will stop for the current PC in pipeline and move to the next one.
    if (Test-Connection -ComputerName $Computer -Count 1 -Quiet)
    {
        # do productive stuvv here
    } else {
        # do error (no connection available) stuff here
        #break      # <- abort loop
        #continue  # <- skip just this iteration, but continue loop
        #return    # <- abort code, and continue in caller scope
        #exit      # <- abort code at caller scope 
    }
} # bottom of foreach loop

'Starting'

function Test-Function {
    $fishtank = 1..10

    Foreach ($fish in $fishtank)
    {
        if ($fish -eq 7)
        {
            #break      # <- abort loop
            #continue  # <- skip just this iteration, but continue loop
            #return    # <- abort code, and continue in caller scope
            exit      # <- abort code at caller scope 
        }

        "fishing fish #$fish"

    }
    'Done.'
}

Test-Function


'Script done!'