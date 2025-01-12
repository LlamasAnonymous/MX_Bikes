$ErrorActionPreference = 'SilentlyContinue'

function filepath {
    $filepath = Read-Host
    $filepath = $filepath.Replace('"', '')

    while ((Test-Path $filepath) -eq $false) {
        cls

        'Error'
        Start-Sleep 1
        "We could not find a valid location with: $filepath
        "
        $example
        $filepath = Read-Host
        $filepath = $filepath.Replace('"', '')
    }
    "Added $filepath"
    $Global:filepath = $filepath
}

# Sets config file locations to variables
$trackconf = "$home\MXBikes\TracksLocation.txt"
$bikeconf = "$home\MXBikes\BikeSetupsLocation.txt"
$setupsconf = "$home\MXBikes\SetupsLocation.txt"

# Gets the stored paths
$location1 = Get-Content $trackconf
$location2 = Get-Content $bikeconf
$location3 = Get-Content $setupsconf

# Checks to see if the stored file paths are valid. This decides the outcome of the next if statement.
if ((Test-Path $location1) -and (Test-Path $location2) -and (Test-Path $location3)) {
    $locationcheck = $null

    'Do you want to change any folder locations? (y,n)'
    $change = Read-Host
    if ($change -eq "y") {
        $locationcheck = "check_failed"
    }
}
else {
    $locationcheck = "check_failed"
}

# If the stored location check fails, or the file paths don't exist, the script steps into this if statement
if ((Test-Path $trackconf) -eq $false -or (Test-Path $bikeconf) -eq $false -or (Test-Path $setupsconf) -eq $false -or $locationcheck -eq "check_failed") {
    # Deletes any old records of config files
    rd "$home\MXBikes" -r -Force | Out-Null
    mkdir "$home\MXBikes" | Out-Null

    cls
    
    'Where are your tracks located?'
    'Example: "C:\Users\[Your user account]\Documents\PiBoSo\MX Bikes\mods\tracks"'

    $example = '    Where are your tracks located?
    Example: "C:\Users\[Your user account]\Documents\PiBoSo\MX Bikes\mods\tracks"'
    filepath

    $Global:filepath | Out-File "$home\MXBikes\TracksLocation.txt"
    cls

    'What is the file path for your "BikeSetups" folder?'
    'Example: "C:\Users\[Your user account]\Documents\PiBoSo\MX Bikes\profiles\[Your profile]\BikeSetups"'
    $example = '    Where are your bike setups located?
    Example: "C:\Users\[Your user account]\Documents\PiBoSo\MX Bikes\profiles\[Your profile]\BikeSetups"'
    filepath

    $Global:filepath | Out-file "$home\MXBikes\BikeSetupsLocation.txt"
    cls
    
    'What is the file path for your "setups" folder?'
    'Example: "C:\Users\[Your user account]\Documents\PiBoSo\MX Bikes\profiles\[Your profile]\setups"'
    $example = '    Where are your saved setups located?
    Example: "C:\Users\[Your user account]\Documents\PiBoSo\MX Bikes\profiles\[Your profile]\setups"'
    filepath

    $Global:filepath | Out-file "$home\MXBikes\SetupsLocation.txt"
    cls
}
'Loading...'

$location1 = Get-Content $trackconf
$location2 = Get-Content $bikeconf
$location3 = Get-Content $setupsconf

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