<#

#>
$WorkDayfiles = Get-ChildItem ([Environment]::GetFolderPath("Desktop")+'\workday\') | Sort-Object -Property Name | Select-Object -ExpandProperty FullName

$WorkDayReport = $null
$WorkDayReport = @()
foreach ($filespec in $WorkDayfiles) {
    
    $Sent = (Select-String -Path $filespec -Pattern "Sent: (.*)").Matches.Groups[1].Value
    $FullName = (Select-String -Path $filespec -Pattern "Full Name: (.*)").Matches.Groups[1].Value
    $FirstName = (Select-String -Path $filespec -Pattern "First Name: (.*)").Matches.Groups[1].Value
    $LastName = (Select-String -Path $filespec -Pattern "Last Name: (.*)").Matches.Groups[1].Value
    $EmployeeID = (Select-String -Path $filespec -Pattern "Employee ID: (.*)").Matches.Groups[1].Value
    $WorkLocation = (Select-String -Path $filespec -Pattern "Work Location: (.*)").Matches.Groups[1].Value
    $Manager = (Select-String -Path $filespec -Pattern "Manager: (.*)").Matches.Groups[1].Value
    $TermDate = (Select-String -Path $filespec -Pattern "effective on (.*)").Matches.Groups[1].Value
    
    Write-Host $filespec

    $obj = new-object -Typename PsObject

    $obj | Add-Member -MemberType NoteProperty -Name Sent -Value $Sent
    $obj | Add-Member -MemberType NoteProperty -Name FullName -Value $FullName 
    $obj | Add-Member -MemberType NoteProperty -Name FirstName -Value $FirstName
    $obj | Add-Member -MemberType NoteProperty -Name LastName -Value $LastName
    $obj | Add-Member -MemberType NoteProperty -Name EmployeeID -Value $EmployeeID
    $obj | Add-Member -MemberType NoteProperty -Name WorkLocation -Value $WorkLocation
    $obj | Add-Member -MemberType NoteProperty -Name Manager -Value $Manager
    $obj | Add-Member -MemberType NoteProperty -Name TermDate -Value $TermDate

    $WorkDayReport += $obj
}
$WorkDayReport| Export-Csv -Path ([Environment]::GetFolderPath("Desktop")+'\workday.csv') -NoTypeInformation


