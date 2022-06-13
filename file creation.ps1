
$userName = Read-host -Prompt "enter user name"

for ($test = 0; $test -lt 7; $test++)
{
    $character = [char](97 + $test)
    new-item C:\users\$userName\Documents\fim\files\$character.txt
    set-content C:\users\$userName\Documents\fim\files\$character.txt "$character$character$character$character"
    
}


#Get-Content C:\users\$userName\Documents\fim\.baseline.txt