function Get-MigrationsSet
{
    <#
    .DESCRIPTION
        Lists the currently running + recently finished VM migrations
    .EXAMPLE
        PS C:\> Get-MigrationsSet
        Lists current and recent VM migration tasks
    .NOTES
        Created on: 20/12/2018
        Author: Chris Bradshaw @aldershotchris
    #>
    Get-Task |
    Where-Object { $_.Name -eq "RelocateVM_Task" } |
    Select-Object @{Name = "VM"; Expression = { Get-VM -Id $_.ObjectID } }, State, @{Name = "% Complete"; Expression = { $_.PercentComplete } }, StartTime
}