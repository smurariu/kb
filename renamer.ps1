$match = "ReferenceApi" 
$replacement = Read-Host "Please enter a solution name (ex: ActualApi)"

$files = Get-ChildItem $(get-location) -filter *$match* -Recurse

$files |
    Sort-Object -Descending -Property { $_.FullName } |
    Rename-Item -newname { $_.name -replace $match, $replacement } -force

$files = Get-ChildItem $(get-location) -include *.cs, *.csproj, *.sln, *.yml, *.json, Dockerfile -Recurse 

foreach($file in $files) 
{ 
    ((Get-Content $file.fullname) -creplace $match, $replacement) | set-content $file.fullname 
}

Write-Host "Done! Press enter to close."
$Host.UI.ReadLine()
