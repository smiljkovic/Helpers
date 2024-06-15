$filename=$args[0]


$P = Import-Csv -Path $filename
$P | Format-Table

.\adb\adb.exe disconnect

# Process each row
$P | ForEach-Object {
    # Display the value of the "Name" column for the current row
    Write-Output ($_."No." +" "+$_."Name" +" "+ $_."IP address") 
	.\adb\adb.exe connect $_."IP address"
	$DEV = .\adb\adb.exe devices -l
	Write-Output $DEV
	
	$OBLOAPP = ".\SW\WiseIntercom.apk"
	$WALLPAPERAPP = ".\SW\Wallpaperly.apk"
	
	.\adb\adb.exe install $OBLOAPP
	.\adb\adb.exe install $WALLPAPERAPP
	.\adb\adb.exe disconnect
	
}


#Read more: https://www.sharepointdiary.com/2021/02/import-csv-in-powershell.html#ixzz8d4QvIA6e

#.\adb connect 192.168.1.10
