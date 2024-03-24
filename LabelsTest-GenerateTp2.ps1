

function NewLabelsTest {

    $core = 'BACKUP ~weidu_external/backup/LabelsTest~', 'AUTHOR ""', 'VERSION ~0.1.0~'
    $laf = @"
    DEFINE_ACTION_FUNCTION Test STR_VAR input = "" BEGIN
        PRINT ~input: %input%~
    END
"@
    $always = @()
    $always += "ALWAYS"
    $always += "    MKDIR ~weidu_external/backup/LabelsTest~"
    $always += "$laf"
    $always += "END"

    $ID = 'LabelsTest'

    $length = 16
    $characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.ToCharArray()
    
    # Clean
    $tp2Clean = @()
    $tp2Clean += $core
    $tp2Clean += $always
    1..1000 | % {
    
        $ComponentName = -join ($characters | Get-Random -Count $length)
        
        #$Designated = Get-Random -Minimum 10000 -Maximum 99999
        $Designated = $_
    
        $tp2Clean += "BEGIN $ComponentName DESIGNATED $Designated GROUP $ComponentName"
        $tp2Clean += "PRINT ~$ComponentName $Designated~"
        $tp2Clean += ""
        $tp2Clean += "`r`n"
    }

    # Labels
    $tp2Labels = @()
    $tp2Labels += $core
    $tp2Labels += $always
    1..1000 | % {
    
        $ComponentName = -join ($characters | Get-Random -Count $length)
        
        #$Designated = Get-Random -Minimum 10000 -Maximum 99999
        $Designated = $_
    
        $tp2Labels += "BEGIN $ComponentName DESIGNATED $Designated LABEL $ComponentName GROUP $ComponentName"
        $tp2Labels += "PRINT ~$ComponentName $Designated~"
        $tp2Labels += ""
        $tp2Labels += "`r`n"
    }

    # LAF
    $tp2LAF = @()
    $tp2LAF += $core
    $tp2LAF += $always
    1..1000 | % {
    
        $ComponentName = -join ($characters | Get-Random -Count $length)
        
        #$Designated = Get-Random -Minimum 10000 -Maximum 99999
        $Designated = $_
    
        $tp2LAF += "BEGIN $ComponentName DESIGNATED $Designated GROUP $ComponentName"
        $tp2LAF += "LAF Test STR_VAR input = `"$ComponentName $Designated`" END"
        $tp2LAF += "`r`n"
        
    }

    # Labels + LAF
    $tp2LabelsLAF = @()
    $tp2LabelsLAF += $core
    $tp2LabelsLAF += $always
    1..1000 | % {
    
        $ComponentName = -join ($characters | Get-Random -Count $length)
        
        #$Designated = Get-Random -Minimum 10000 -Maximum 99999
        $Designated = $_
    
        $tp2LabelsLAF += "BEGIN $ComponentName DESIGNATED $Designated LABEL $ComponentName GROUP $ComponentName"
        $tp2LabelsLAF += "LAF Test STR_VAR input = `"$ComponentName $Designated`" END"
        $tp2LabelsLAF += "`r`n"
    }

    New-Item -ItemType File -Name "$ID-Clean.tp2" -Path $ID -Value ($tp2Clean -join "`r`n") -Force
    New-Item -ItemType File -Name "$ID-Labels.tp2" -Path $ID -Value ($tp2Labels -join "`r`n") -Force
    New-Item -ItemType File -Name "$ID-LAF.tp2" -Path $ID -Value ($tp2LAF -join "`r`n") -Force
    New-Item -ItemType File -Name "$ID-LabelsLAF.tp2" -Path $ID -Value ($tp2LabelsLAF -join "`r`n") -Force

}

cd $PSScriptRoot

NewLabelsTest
