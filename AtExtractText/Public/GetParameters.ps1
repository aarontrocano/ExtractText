<#

#>
<#Set-Variable -Option Constant CONSTANT_ARRAY_STATE @('Low','Average','High') #>
function Get-TCPConnections {
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $True, ValueFromPipeline = $True)]   
        [Alias('hostname')]
        [string[]]$Computername,
        [Parameter(Mandatory = $True)]
        [Validateset('ESTABLISHED', 'LISTENING', 'CLOSE_WAIT')]
        [string[]]$state,
        [string]$errorlog = ([Environment]::GetFolderPath("Desktop") + '\conn' + '\ConnectionError' + (get-date -format 'MM-dd-yyyy') + '.txt'),
        [switch]$Logerrors   
    )
    Write-Verbose -Message "$Computername $state" -Verbose

    $regexPattern = @($state | ForEach-Object {[regex]::Escape($_)}) -join '|'

    #netstat -ano | Select-String -Pattern 'CLOSE_WAIT'
    netstat -ano | Select-String -Pattern $state
    #netstat -ano | Select-String -Pattern $regexPattern
}