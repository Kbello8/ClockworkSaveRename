#Quick script to convert a folder full of .2h.trn files into .2h files that can be loaded into Dominions 5.

#USING THE SCRIPT:Paste script into folder full of .2h.trn files, run script.

#Expected to be used on files in the following format: crime_and_punishment_Turn_2_late_erytheia.2h.trn
#Expected output is a folder named: crime_and_punishment_Turn_2
#Expected folder contains a file named: late_erytheia.trn
#Sample input for this case would be: crime_and_punishment

$gameName = Read-Host -Prompt 'Input the Game Name.';
$gameNameLength = $gameName.length;
#String adjustment for folder name. 
$folderAdjust = 0;
$fileAdjust = 0;

# Get all files ending in .2h.trn
$files = Get-ChildItem $gameName*.2h.trn;
  ForEach ($file in $files)
  {
	#Checks if turn XX.
	If ($file.basename.substring($gameName.length+8,1)  -eq '_')  {
		$folderAdjust = 8;
		$fileAdjust = 9;
	} 
	#Checks if turn X.
	ElseIf ($file.basename.substring($gameName.length+7,1)  -eq '_'){	
		$folderAdjust = 7;
		$fileAdjust = 8;
	}
	#Checks if turn XXX.
	ElseIf ($file.basename.substring($gameName.length+9,1)  -eq '_'){
		$folderAdjust = 9;
		$fileAdjust = 10;
	}
	Else{
		"Oops."
	}
	
	#$newfile = get-childitem $file
    $folder = New-Item -type directory -name $file.basename.substring(0, $gameNameLength + $folderAdjust);
	$newfiletrn = $file.basename.substring($gameNameLength + $fileAdjust);
	Start-Sleep -Seconds 0.01
	$newfiletrn = $newfiletrn.substring(0,$newfiletrn.length-3)+".trn";
	Start-Sleep -Seconds 0.01
	Copy-Item $file -Destination $folder\$newfiletrn
  }
  pause
   