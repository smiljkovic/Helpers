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
	#If ($DEV | %{$_ -match "v907"}) 
	if( $DEV -imatch "v907" )
	{
		Write-Output "v907 indoor monitor"
		[xml]$sysCfg = Get-Content -Path .\v907\update_no_logo\product\cfg\sys.xml
		
		$sysCfg.sys.talk.family = $_."No."
		$tmpFile = ".\sys.xml"
		Write-Output $sysCfg.sys.talk.family
		$sysCfg.Save($tmpFile)
		.\adb\adb.exe root
		.\adb\adb.exe push $tmpFile /dnake/cfg/
		.\adb\adb.exe reboot
		
		
		Remove-Item $tmpFile
	}
	else
	{
		if( $DEV -imatch "904" )
		{
			Write-Output "904 indoor monitor"
			[xml]$sysCfg = Get-Content -Path .\H618\update_nologo\product\cfg\sys.xml
		
			$sysCfg.sys.talk.family = $_."No."
			$tmpFile = ".\sys.xml"
			Write-Output $sysCfg.sys.talk.family
			$sysCfg.Save($tmpFile)
			.\adb\adb.exe root
			.\adb\adb.exe push $tmpFile /dnake/cfg/
			.\adb\adb.exe reboot		
			
			Remove-Item $tmpFile
			
		}
		else
		{
			Write-Output "UNKNOWN indoor monitor!!!"
		}
	}
	.\adb\adb.exe disconnect
	
}


#Read more: https://www.sharepointdiary.com/2021/02/import-csv-in-powershell.html#ixzz8d4QvIA6e

#.\adb connect 192.168.1.10
