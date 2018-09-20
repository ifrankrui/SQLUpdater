function Get-UpdateServerList
{

[CmdletBinding()]

    param 
    (
    [Parameter(Mandatory)]
    [String] $CSVName  ##CSV name includes CSV file path and anme
    )
    process
    {
    try
        {
        $List = Import-Csv $CSVName

        ForEach ($item in $List)

            {
            
            $ComputerName = $item.("ComputerName")
            $InstanceName = $item.("InstanceName")
            $Version=$item.("Version")
            $ServicePack=$item.("ServicePack")
            $CU=$item.("CU")

            Update-SqlServer -ComputerName $ComputerName -InstanceName $InstanceName -ServicePack $ServicePack -CumulativeUpdate $CU
            }

        } 
    catch
        {
        ##echo "$(Get-date)      $_"
        Erroroutput -Exception $_  -ErrorDetails $_
        }
    }
}


function ErrorOutput
{
Param 
(
 [Parameter(Mandatory)]
 [String] $Exception,
 [System.Management.Automation.ErrorRecord] $ErrorDetails
)


"$(Get-date)      $Exception" | Out-File $PSScriptRoot\Output.txt -Append
$ErrorDetails | Out-File $PSScriptRoot\Output.txt -Append

}

Get-UpdateServerList

