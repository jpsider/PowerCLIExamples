$script:ModuleName = 'PowerCLIExamples'

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'tests', "$script:ModuleName"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Function Get-Task
{ 

}
Describe "Get-MigrationsSet function for $script:ModuleName" -Tags Build {
    It "Should not return null." {
        mock -CommandName 'Get-Task' -MockWith { 
            $RawReturn = @{
                name            = "RelocateVM_Task"
                ObjectId        = 'testvm'
                state           = 'Complete'
                PercentComplete = '100%'
                StateTime       = '2/15/1992 12:05:01 AM'
            }
            $ReturnJson = $RawReturn | ConvertTo-Json
            $ReturnData = $ReturnJson | convertfrom-json
            return $ReturnData
        }
        Get-MigrationsSet | Should not be $null
    }
    It "Should not throw." {
        mock -CommandName 'Get-Task' -MockWith { 
            $RawReturn = @{
                name            = "RelocateVM_Task"
                ObjectId        = 'testvm'
                state           = 'Complete'
                PercentComplete = '100%'
                StateTime       = '2/15/1992 12:05:01 AM'
            }
            $ReturnJson = $RawReturn | ConvertTo-Json
            $ReturnData = $ReturnJson | convertfrom-json
            return $ReturnData
        }
        { Get-MigrationsSet } | Should not throw
    }
    It "Should throw." {
        mock -CommandName 'Get-Task' -MockWith { 
            throw "Get-Task failed"    
        }
        { Get-MigrationsSet } | Should throw
    }
}

