$data1 = @'
write-host  "Hello World"
'@
$data2 = @'
function Get-WhatEVer{
    write-host "Hello world"
}
'@
$data3 = @'
function Get-WhatEVer1{
    write-host "Hello world"
}
function Get-WhatEVer2{
    write-host "Hello world"
}
'@

$ast1 = [System.Management.Automation.Language.Parser]::ParseInput($data1, [ref]$null, [ref]$null)
$f= $ast1.FindAll({$args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst]}, $true)
$f.Count

$ast2 = [System.Management.Automation.Language.Parser]::ParseInput($data2, [ref]$null, [ref]$null)
$f = $ast2.FindAll({$args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst]}, $true)
$f.Count

$ast3 = [System.Management.Automation.Language.Parser]::ParseInput($data3, [ref]$null, [ref]$null)
$f = $ast3.FindAll({$args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst]}, $true)
$f.Count