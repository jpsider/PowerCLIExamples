$path = 'C:\Users\LucD\Documents\Git\PowerCLI-Example-Scripts\Scripts-New'

Invoke-ScriptAnalyzer -Path $path -Recurse |
Export-Excel -Path .\report.xlsx -WorkSheetname AnalyzeThis -TitleBold -AutoFilter -AutoSize

# PSCodeHealth can run very long!
# To be investigated if the runtime can be improved

#Get-ChildItem -Path $path -Filter *.ps1 -Recurse | 
#ForEach-Object -Process {
#    $_.FullName
#    $result = Invoke-PSCodeHealth -Path $_.FullName
#    $result.FunctionHealthRecords |
#    Add-Member -MemberType NoteProperty -Name File -Value $result.AnalyzedPath -PassThru
#} | Export-Excel -Path .\report.xlsx -WorkSheetname Health -TitleBold -AutoFilter -AutoSize -Show