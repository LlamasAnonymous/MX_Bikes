cls

function filepath {
    while (Test-Path $Global:filepath -eq $false) {
        "We could not find the filepath: $Global:filepath"
        Start-Sleep 1
        'Enter the path that you want use to store your "TransferBikes.ps1" file, long term.'
        
    }
}

'You can copy a file path by selecting the file, and using "CTRL + Shift + C"'
Start-Sleep 1
'Where will your "TransferBikes.ps1" file be stored long-term (I recommend putting this in a safe place)?'
Start-Sleep 1
'Example: C:\Users\[Your Username]\Documents\Scripts'
''
$Global:filepath = Read-Host
filepath

cls

While (((Test-Path $Global:filepath) -eq $false) -or ((Test-Path "$home\MXBikes\Ps1Location.txt") -eq $false)) {
    'We couldnt find that file path. Make sure that you did not include quotation marks. Try entering the file path again.'
    'Example: C:\Users\[Your Username]\Documents\Scripts'
    $Global:filepath = Read-Host
    cls
}
$Global:filepath | Out-File "$home\MXBikes\Ps1Location.txt"


'This part is IMPORTANT!! Do NOT include quotation marks in the file path
You can copy a file path by selecting the file, and using "CTRL + Shift + C"
Where will your "TransferBikes.exe" file be stored (This will show the shortcut where to look)?
Example: C:\Users\[Your Username]\Documents\Scripts'
$storedexe = Read-Host
$storedexe = "C:\Users\gjbro\OneDrive\Scripts\MXBikes\"
#$storedexe = "C:\Users\gjbro\OneDrive\Scripts\MXBikes\TransferBikes.exe"
cls

While (((Test-Path $storedexe) -eq $false) -or ((Test-Path "$home\MXBikes\ExeLocation.txt") -eq $false)) {
    'We couldnt find that file path. Make sure that you did not include quotation marks. Try entering the file path again.'
    'Example: C:\Users\[Your Username]\Documents\Scripts\'
    $storedexe = Read-Host
    cls
}
$Global:filepath | Out-File "$home\MXBikes\ExeLocation.txt"


Move-Item "$home\Downloads\TransferBikes.ps1" "$home" | Out-Null

$applaunched = 'pwsh "' + $Global:filepath + '"'

$file0 = '"TransferBikes.ps1"'

New-Item "$home\TransferBikes.sed" -Force -Value "[Version]
Class=IEXPRESS
SEDVersion=3
[Options]
PackagePurpose=InstallApp
ShowInstallProgramWindow=0
HideExtractAnimation=0
UseLongFileName=0
InsideCompressed=0
CAB_FixedSize=0
CAB_ResvCodeSigning=0
RebootMode=N
InstallPrompt=%InstallPrompt%
DisplayLicense=%DisplayLicense%
FinishMessage=%FinishMessage%
TargetName=%TargetName%
FriendlyName=%FriendlyName%
AppLaunched=%AppLaunched%
PostInstallCmd=%PostInstallCmd%
AdminQuietInstCmd=%AdminQuietInstCmd%
UserQuietInstCmd=%UserQuietInstCmd%
SourceFiles=SourceFiles
[Strings]
InstallPrompt=This will overwrite any saved bike config on all maps
DisplayLicense=
FinishMessage=
TargetName=$storedexe
FriendlyName=TransferBikeSetups
AppLaunched=$applaunched
PostInstallCmd=<None>
AdminQuietInstCmd=
UserQuietInstCmd=
FILE0=$file0
[SourceFiles]
SourceFiles0=$home\
[SourceFiles0]
%FILE0%="


$link = '"' + "$home\MXB Transfer Bike Setups.lnk" + '"'

New-Item "$home\MXBshortcut.ps1" -Force -Value 'New-Item -ItemType SymbolicLink "$home\MXB Transfer Bike Setups.lnk" -Target $storedexe -Force'

# "-Verb runas" allows you to run the program as Admin
Start-Process pwsh "$home\MXBshortcut.ps1"  -Verb runas

Move-Item "$home\MXB Transfer Bike Setups.lnk" "$home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"

iexpress

