[Version]
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
FinishMessage=Setups have been set/overwritten.
TargetName=
FriendlyName=TransferBikeSetups
AppLaunched=pwsh ""
PostInstallCmd=<None>
AdminQuietInstCmd=
UserQuietInstCmd=
FILE0="TransferBikeSetups.ps1"
[SourceFiles]
SourceFiles0=
[SourceFiles0]
%FILE0%=
