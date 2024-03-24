# Usage

### multiple tests, use weidu.exe from game dir
```powershell
.\LabelsTest.ps1
```

###  multiple tests, using custom weidu path, output is disabled
```powershell
.\LabelsTest.ps1 -WeiDUPath 'D:\Programs\Cygwin-WeiDU-x64\home\a\weidu\weidu.asm.exe' -DisableOutput
```

### single test, use weidu.exe from game dir
```powershell
.\stratagems-LAFLabels.ps1
```

### single test, using custom weidu path, output is disabled
```powershell
.\stratagems-LAFLabels.ps1 -WeiDUPath 'D:\Programs\Cygwin-WeiDU-x64\home\a\weidu\weidu.asm.exe'  -DisableOutput
```