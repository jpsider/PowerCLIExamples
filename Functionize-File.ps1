<#
.SYNOPSIS
    Takes a PowerShell file and converts the contents to a function if they aren't
.PARAMETER ScriptPath
    The filepath to the file you want to functionize
.PARAMETER OutputPath
    The filepath to the output file. If nothing is specified the file is modified in-place
#>
function Functionize-File() {
    param(
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true,
            Position=1)]
        $ScriptPath,
        
        [Parameter(
            Mandatory=$false,
            ValueFromPipeline=$false,
            Position=2
        )]
        $OutputPath = $ScriptPath
    )
    
    $tokens = @()
    $errors = @()
    $AST = [System.Management.Automation.Language.Parser]::ParseFile($ScriptPath, [ref] $tokens, [ref] $errors)
    
    if ($errors.Count -gt 0) {
        $errors | ForEach-Object {Write-Error $_}
        throw "There was an error processing the script."
    }

    $functionASTs = $AST.FindAll({$args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst]}, $false)
    if ($functionASTs.Count -gt 0) {
        Write-Host "The script contains functions. Exiting."
    } else {
        Write-Host "The script contains no functions. Functionizing it!"
        Write-Host "Writing function to '$OutputPath'"
        # Build function name
        $functionName = ($ScriptPath | Split-Path -Leaf) -replace '.ps1',''
        Set-Content -Path $OutputPath -Value ("function $functionName() {")
        Add-Content -Path $OutputPath -Value $AST.ToString()
        Add-Content -Path $OutputPath -Value '}'
    }
}