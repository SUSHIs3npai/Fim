write-host ""
write-host "what would you like to do"
write-host ""
write-host "a) collect new baseline"
write-host "b) begin monitoring files with baseline"
write-host ""

$response = Read-host -Prompt "please enter a or b"
write-host ""

Function Calculate-file-hash($filepath){
    $fileshash = Get-FileHash -Path $filepath -Algorithm SHA512
    return $fileshash
}

Function Erase-Baseline-if-exists() {
    $baselineExists = Test-Path -path .\.baseline.txt

    if($baselineExists){
        #removing item if existing
        Remove-Item -Path .\.baseline.txt
    }

 }

if ($response -eq "A".ToUpper()) {
    Write-Host "calculate hashes and make new baseline.txt" -ForegroundColor cyan
    #delete baseline if exists
    Erase-Baseline-if-exists
    

    # cal. th ehash and store in baseline.txt
    # collect all files in target folder
    $files = Get-ChildItem -path .\files
   
    
    # for file calculate the hash
    foreach ($f in $files){
        $hash = Calculate-file-hash $f.FullName
        "$($hash.Path)|$($hash.Hash)" | out-file -filepath .\.baseline.txt -Append

    } 

    #content of the baseline
    $content = Get-Content -path .\.baseline.txt
    #$content

}


elseif ($response -eq "B".ToUpper()){
    write-host "read existing baseline.txt and start monitoring files" -ForegroundColor Yellow



    $fileHashDictionary = @{}

    #load file from baseline.txt
    $filePathsandHashes = Get-Content -path .\.baseline.txt
    #$filePathsandHashes

    foreach($f in $filePathsandHashes){
        $fileHashDictionary.add($f.Split("|")[0],$f.Split("|")[1])
        
    }
    #$fileHashDictionary.values

    #continously monitoring the files using saved baseline
    while($true){
        start-sleep -seconds 1
        #Write-Host "checking if files match..."
        $files = Get-ChildItem -path .\files
   
    
        # for file calculate the hash
        foreach ($f in $files){
            $hash = Calculate-file-hash $f.FullName

            #"$($hash.Path)|$($hash.Hash)" | out-file -filepath .\.baseline.txt -Append

            #notify if new file has been created
            if ($fileHashDictionary[$hash.Path] -eq $null){
                #check for path if yes then new file created
                Write-Host "$(Get-Date) || $($hash.Path) has been created" -ForegroundColor Green
            }

            #notify if file has been changed
            elseif ($fileHashDictionary[$hash.Path] -ne $hash.Hash){
                #file has has been changed
                Write-Host "$(Get-Date) || $($hash.Path) has been changed" -ForegroundColor Red
                
            }
            
           
        }

        foreach ($key in $fileHashDictionary.keys){
            $baselineFileexists = Test-Path -path $key
            if (-not $baselineFileexists){
                #file must be deleted
                Write-Host "$(Get-Date) || $($key) has been deleted" -ForegroundColor darkRed -BackgroundColor gray
            }
        }

    }

}

