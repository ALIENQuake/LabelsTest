function TestMod {
    param (
        [string]$FileName,
        [string]$List,
        [string]$WeiDUPath,
        [switch]$DisableOutput
    )

    $WeiduExePath = Join-Path -Path $PSScriptRoot -ChildPath 'weidu.exe'
    $WeiduConfPath = Join-Path -Path $PSScriptRoot -ChildPath 'weidu.conf'

    if (-not (Test-Path $WeiduExePath)) {
        throw "Error: The weidu.exe is missing. Please copy WeiDU into the gamedir as weidu.exe."
    }

    if (-not (Test-Path $WeiduConfPath)) {
        throw "Error: The weidu.conf is missing. Please launch setup-weidu.exe once."
    }

    if (-not $FileName) {
        throw "Error: FileName is empty."
    }

    $ID = if ($FileName -like 'setup-*') { ($FileName -split '-')[1] } else { ($FileName -split '-')[0] }

    $StartDate = Get-Date -Format "HH:MM:ss"

    if (-not $WeiDUPath -or -not (Test-Path $WeiDUPath)) {
        $WeiDUPath = $WeiduExePath
    }
    
    $WeiDUVersionFromExe = (@(& "$WeiDUPath" --version )[0] -split 'version ')[1]

    Write-Host "$StartDate : ID: $ID | Tp2 BaseName: $FileName"
    Write-Host "$StartDate : Weidu Path: $WeiDUPath"
    Write-Host "$StartDate : WeiDU Version: $WeiDUVersionFromExe"
    if ($List) {
        Write-Host "List: $List"
        Write-Host ""
    }

    $Tp2FullPath = Join-Path -Path $PSScriptRoot -ChildPath "$ID\$FileName.tp2"

    if (-not (Test-Path $Tp2FullPath)) {
        throw "FileName dosent exist at $ID\$FileName."
    }

    $List = @($List -split ' ')
    if ($DisableOutput){
        $out = Measure-Command -Expression {
            if ($List) {
                & "$WeiDUPath" "$Tp2FullPath" --no-exit-pause --noautoupdate --language 0 --force-install-list $List | Out-Null
            } else {
                & "$WeiDUPath" "$Tp2FullPath" --no-exit-pause --noautoupdate --language 0 --yes | Out-Null
            }
        } -OutVariable Duration
    } else {
        $out = Measure-Command -Expression {
            if ($List) {
                & "$WeiDUPath" "$Tp2FullPath" --no-exit-pause --noautoupdate --language 0 --force-install-list $List | Out-Default
            } else {
                & "$WeiDUPath" "$Tp2FullPath" --no-exit-pause --noautoupdate --language 0 --yes | Out-Default
            }
        } -OutVariable Duration
    }

    & $WeiDUPath "$Tp2FullPath" --no-exit-pause --noautoupdate --language 0 --uninstall | Out-Null

    Remove-Item (Join-Path -Path $PSScriptRoot -ChildPath 'override') -Recurse -Force
    Remove-Item (Join-Path -Path $PSScriptRoot -ChildPath 'weidu_external') -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item (Join-Path -Path $PSScriptRoot -ChildPath 'weidu.log') -Force -ErrorAction SilentlyContinue

    Write-Host ""

    $TotalMinutes = "{0:n2}" -f $Duration.TotalMinutes
    $TotalSeconds = "{0:n0}" -f $Duration.TotalSeconds
    $TotalMilliseconds = "{0:n0}" -f $Duration.TotalMilliseconds

    Write-Host "$StartDate :TotalMinutes: $TotalMinutes" -ForegroundColor Green
    Write-Host "$StartDate :TotalSeconds: $TotalSeconds" -ForegroundColor Green
    Write-Host "$StartDate :TotalMilliseconds: $TotalMilliseconds" -ForegroundColor Green
    Write-Host ""
}
