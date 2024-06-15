$filename=$args[0]


$P = Import-Csv -Path $filename
$P | Format-Table



# Process each row
$P | ForEach-Object {
    # Display the value of the "Name" column for the current row
    
	.\adb\adb.exe disconnect
	Write-Output ($_."No." +" "+$_."Name" +" "+ $_."IP address") 
	.\adb\adb.exe connect $_."IP address"
	$DEV = .\adb\adb.exe devices -l
	Write-Output $DEV
	#If ($DEV | %{$_ -match "v907"}) 
	
	$backgroundFile = ".\SW\bg_default.webp"
	#.\adb\adb.exe root
	#.\adb\adb.exe remount
	.\adb\adb.exe push $backgroundFile /dnake/data/bg/
	
	.\adb\adb.exe reboot
	
}


#Read more: https://www.sharepointdiary.com/2021/02/import-csv-in-powershell.html#ixzz8d4QvIA6e

#.\adb connect 192.168.1.10
