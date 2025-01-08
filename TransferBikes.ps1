$ErrorActionPreference = 'SilentlyContinue'
if ((Test-Path "$home\MXBikes\TracksLocation.txt") -and (Test-Path "$home\MXBikes\BikeSetupsLocation.txt") -and (Test-Path "$home\MXBikes\SetupsLocation.txt")) {
} else {
    mkdir "$home\MXBikes" | Out-Null

    'Where are your tracks stored?'
    'Example: "C:\Users\[Your user account]\Documents\PiBoSo\MX Bikes\mods\tracks"'
    $trackfolder = Read-Host

    while((Test-Path $trackfolder) -eq $false){
        cls
        "Are you sure this is the right path? We could not find this location: $trackfolder"
        "Hint: Double-check the path that you entered, and make sure that you do NOT include quotation marks"
        "Enter the correct Track folder path"
        $trackfolder = Read-Host
    }
    $trackfolder | Out-File "$home\MXBikes\TracksLocation.txt"
    cls

    'What is the file path for your "BikeSetups" folder?'
    'Example: "C:\Users\[Your user account]\Documents\PiBoSo\MX Bikes\profiles\[Your profile]\BikeSetups"'
    $bikesetupsfolder = Read-Host

    while((Test-Path $bikesetupsfolder) -eq $false){
        cls
        "Are you sure this is the right path? We could not find this location: $bikesetupsfolder"
        "Hint: Double-check the path that you entered, and make sure that you do NOT include quotation marks"
        "Enter the correct Bike Setups folder path"
        $bikesetupsfolder = Read-Host
    }
    $bikesetupsfolder | Out-file "$home\MXBikes\BikeSetupsLocation.txt"
    cls
    
    'What is the file path for your "setups" folder?'
    'Example: "C:\Users\[Your user account]\Documents\PiBoSo\MX Bikes\profiles\[Your profile]\setups"'
    $setupsfolder = Read-Host

    while((Test-Path $setupsfolder) -eq $false){
        cls
        "Are you sure this is the right path? We could not find this location: $setupsfolder"
        "Hint: Double-check the path that you entered, and make sure that you do NOT include quotation marks"
        "Enter the correct Track Setups folder path"
        $setupsfolder = Read-Host
    }
    $setupsfolder | Out-file "$home\MXBikes\SetupsLocation.txt"
    cls
}
'Loading...'

$location1 = Get-Content "$home\MXBikes\TracksLocation.txt"
$location2 = Get-Content "$home\MXBikes\BikeSetupsLocation.txt"
$location3 = Get-Content "$home\MXBikes\SetupsLocation.txt"

$tracks = Get-ChildItem "$location1\*\*"
$tracks = $tracks.BaseName
foreach ($track in $tracks) {
    mkdir "$location3\$track"
}

$bikes = Get-ChildItem $location2
$setups = Get-ChildItem $location3

foreach ($map in $setups) {
    Copy-Item $bikes $map -r -force
}