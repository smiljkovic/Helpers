$filename=$args[0]


$P = Import-Csv -Path $filename
$P | Format-Table

# Process each row
$P | ForEach-Object {
    # Display the value of the "Name" column for the current row
    Write-Output $_."First Name"
}


#Read more: https://www.sharepointdiary.com/2021/02/import-csv-in-powershell.html#ixzz8d4QvIA6e

#.\adb connect 192.168.1.10
