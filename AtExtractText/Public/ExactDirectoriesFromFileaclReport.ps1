<#

#>
$Import = Get-Content ([Environment]::GetFolderPath("Desktop")+'\fileacl.txt')
$Report = $null
$Report = @()
foreach ($aclspec in $Import) {

    $strDir = $aclspec.split(';')[0]
    $Report += $strDir
    Out-Null <#No-op#>
    $strDir = $null
}
($Report | Measure-Object).Count
$Report | Set-Content -Path ([Environment]::GetFolderPath("Desktop")+'\dirs.txt')