$script:ModuleName = 'PowerCLIExamples'

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'tests', "$script:ModuleName"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Disable-SSLValidation function for $script:ModuleName" -Tags Build {
    It "Should Return null." {
        Disable-SSLValidation | Should be $true
    }
}