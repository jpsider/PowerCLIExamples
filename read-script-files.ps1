$path = 'C:\Users\LucD\Documents\Git\PowerCLI-Example-Scripts\Scripts'

Get-ChildItem -Path $path -Filter *.ps1 -Recurse |
Select-Object -Property FullName,
    @{N='Function';E={
        $ast = [System.Management.Automation.Language.Parser]::ParseFile($_.FullName,[ref]$null,[ref]$null)
        ($ast.FindAll({$args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst]}, $false)).Count
    }}