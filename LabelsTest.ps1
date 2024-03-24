param($FileName, $WeiDUPath, [switch]$DisableOutput=$true)

. .\TestMod.ps1

$DisableOutput = $true

$FileName = 'LabelsTest-Clean'
$List = ''

TestMod -FileName $FileName -List $List -WeiDUPath $WeiDUPath -DisableOutput:$DisableOutput
$FileName = 'LabelsTest-Labels'
TestMod -FileName $FileName -List $List -WeiDUPath $WeiDUPath -DisableOutput:$DisableOutput
$FileName = 'LabelsTest-LAF'
TestMod -FileName $FileName -List $List -WeiDUPath $WeiDUPath -DisableOutput:$DisableOutput
$FileName = 'LabelsTest-LAFLabels'
TestMod -FileName $FileName -List $List -WeiDUPath $WeiDUPath -DisableOutput:$DisableOutput
