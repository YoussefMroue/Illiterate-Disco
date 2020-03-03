$data = Get-ChildItem Data;
$jsonData = $data | ForEach-Object -Process{
    Get-Content $_.FullName | ConvertFrom-Json;
}
$Reps = @{};
foreach ($bill in $jsonData) {
    $members = $bill.votes.Present + $bill.votes.'Not Voting' + $bill.votes.Aye + $bill.votes.Nay;
    foreach($member in $members){
        if($member.id){
            if(!$Reps.Contains($member.id)){
                $Reps.Add($member.id,$member);
            }
        }
    }
}
foreach ($bill in $jsonData) {
    Write-Host $bill.number
    foreach($key in $Reps.Keys){
        try{
            $Reps[$key] | Add-Member -MemberType NoteProperty -Name "h$($bill.number)" -Value "O"
        }
        catch{
            Write-Host $key
        }
    }
    foreach($member in $bill.votes.Present){
        if($member.id){
            if($Reps.Contains($member.id)){
                $Reps[$member.id] | Add-Member -MemberType NoteProperty -Name "h$($bill.number)" -Value "P" -Force
            }
        }
    }
    foreach($member in $bill.votes.Nay){
        if($member.id){
            if($Reps.Contains($member.id)){
                $Reps[$member.id] | Add-Member -MemberType NoteProperty -Name "h$($bill.number)" -Value "N" -Force
            }
        }
    }
    foreach($member in $bill.votes.No){
        if($member.id){
            if($Reps.Contains($member.id)){
                $Reps[$member.id] | Add-Member -MemberType NoteProperty -Name "h$($bill.number)" -Value "N" -Force
            }
        }
    }
    foreach($member in $bill.votes.Aye){
        if($member.id){
            if($Reps.Contains($member.id)){
                $Reps[$member.id] | Add-Member -MemberType NoteProperty -Name "h$($bill.number)" -Value "Y" -Force
            }
        }
    }
    foreach($member in $bill.votes.Yea){
        if($member.id){
            if($Reps.Contains($member.id)){
                $Reps[$member.id] | Add-Member -MemberType NoteProperty -Name "h$($bill.number)" -Value "Y" -Force
            }
        }
    }
}

$Reps.Values | Export-CSV "Data_Fixed.csv"
# SIG # Begin signature block
# MIIMRQYJKoZIhvcNAQcCoIIMNjCCDDICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUa23c/4ktqIQPm42CkpnU1rEa
# F8egggedMIIC/DCCAeSgAwIBAgIQbQhRPjUMbLdCalxtWJR9pTANBgkqhkiG9w0B
# AQsFADAWMRQwEgYDVQQDDAtWaWN0b3IgWmVuZzAeFw0xODAxMzAxODE1MTVaFw0z
# ODAxMzAxODI1MTVaMBYxFDASBgNVBAMMC1ZpY3RvciBaZW5nMIIBIjANBgkqhkiG
# 9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt4/Cg4TfHt6jthAQUinCXF42VuoeaTVz8ZEE
# bPfGSlHNkEvst1B+Ygjmhxz7h/URf6rPBXNg3uF5LqFo+h7slLvgTeMA8evjgDfm
# rTppX+wRene1TXEZXRwAwvuKncd4kN+Tgl3V8LeBo7kDFQXDHc9tp6JhqqRq5NWu
# IBSGEMML230VsKMyjgU4meH0s3Z63PwqnGToppquEhLjM799o4sx24aAFRdFPMbi
# TgPQuggOVnLJ1eg0bSEVpAcI+xzLtMzgBc9AU30GclbXZ1vLoKD2WtwASej8cHiH
# DwCrTXcjGCSb4d6ZrH6utc66Zt2k0TUOi5VVxt70oMkQqiunpQIDAQABo0YwRDAO
# BgNVHQ8BAf8EBAMCB4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMwHQYDVR0OBBYEFFIb
# i89LLKSKTkJBXLnlILvMo3FjMA0GCSqGSIb3DQEBCwUAA4IBAQBD640CQueQOgS3
# +js/ElDanfjMlhTD5xKgNekXJyIA2iS3mYcTZAGNmK32vMT5gmN0jJhh8x4boebd
# QUEnjAmH0np7T+Qb8XZfNyL3lPqdovRMkNh17/hWRcMAAKJoSGxq7f+hfLEhHfsF
# yd8gI1YywdrbZPW0FFNenqqujNCeNOocfZmWLvE0awixaZUVIZMsw0pJ/yZub/M8
# 4s71dvTV+J/hTDyReURh0IIp/ywNgf8acVUtgC6zyMna6weAbGRrqO5vRf6vJN/h
# iHi0/KKRnX4wP/OKdh4JJXIEXmt5HZ86GaCBDg7lyOm8KxMcMGseiPjdR8oYIq1B
# oOnSzeKuMIIEmTCCA4GgAwIBAgIPFojwOSVeY45pFDkH5jMLMA0GCSqGSIb3DQEB
# BQUAMIGVMQswCQYDVQQGEwJVUzELMAkGA1UECBMCVVQxFzAVBgNVBAcTDlNhbHQg
# TGFrZSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxITAfBgNV
# BAsTGGh0dHA6Ly93d3cudXNlcnRydXN0LmNvbTEdMBsGA1UEAxMUVVROLVVTRVJG
# aXJzdC1PYmplY3QwHhcNMTUxMjMxMDAwMDAwWhcNMTkwNzA5MTg0MDM2WjCBhDEL
# MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
# BxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxKjAoBgNVBAMT
# IUNPTU9ETyBTSEEtMSBUaW1lIFN0YW1waW5nIFNpZ25lcjCCASIwDQYJKoZIhvcN
# AQEBBQADggEPADCCAQoCggEBAOnpPd/XNwjJHjiyUlNCbSLxscQGBGue/YJ0UEN9
# xqC7H075AnEmse9D2IOMSPznD5d6muuc3qajDjscRBh1jnilF2n+SRik4rtcTv6O
# KlR6UPDV9syR55l51955lNeWM/4Og74iv2MWLKPdKBuvPavql9LxvwQQ5z1IRf0f
# aGXBf1mZacAiMQxibqdcZQEhsGPEIhgn7ub80gA9Ry6ouIZWXQTcExclbhzfRA8V
# zbfbpVd2Qm8AaIKZ0uPB3vCLlFdM7AiQIiHOIiuYDELmQpOUmJPv/QbZP7xbm1Q8
# ILHuatZHesWrgOkwmt7xpD9VTQoJNIp1KdJprZcPUL/4ygkCAwEAAaOB9DCB8TAf
# BgNVHSMEGDAWgBTa7WR0FJwUPKvdmam9WyhNizzJ2DAdBgNVHQ4EFgQUjmstM2v0
# M6eTsxOapeAK9xI1aogwDgYDVR0PAQH/BAQDAgbAMAwGA1UdEwEB/wQCMAAwFgYD
# VR0lAQH/BAwwCgYIKwYBBQUHAwgwQgYDVR0fBDswOTA3oDWgM4YxaHR0cDovL2Ny
# bC51c2VydHJ1c3QuY29tL1VUTi1VU0VSRmlyc3QtT2JqZWN0LmNybDA1BggrBgEF
# BQcBAQQpMCcwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20w
# DQYJKoZIhvcNAQEFBQADggEBALozJEBAjHzbWJ+zYJiy9cAx/usfblD2CuDk5oGt
# Joei3/2z2vRz8wD7KRuJGxU+22tSkyvErDmB1zxnV5o5NuAoCJrjOU+biQl/e8Vh
# f1mJMiUKaq4aPvCiJ6i2w7iH9xYESEE9XNjsn00gMQTZZaHtzWkHUxY93TYCCojr
# QOUGMAu4Fkvc77xVCf/GPhIudrPczkLv+XZX4bcKBUCYWJpdcRaTcYxlgepv84n3
# +3OttOe/2Y5vqgtPJfO44dXddZhogfiqwNGAwsTEOYnB9smebNd0+dmX+E/CmgrN
# Xo/4GengpZ/E8JIh5i15Jcki+cPwOoRXrToW9GOUEB1d0MYxggQSMIIEDgIBATAq
# MBYxFDASBgNVBAMMC1ZpY3RvciBaZW5nAhBtCFE+NQxst0JqXG1YlH2lMAkGBSsO
# AwIaBQCgeDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEM
# BgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqG
# SIb3DQEJBDEWBBRrhEBb8XusnSHFGsVczol8YBoqrjANBgkqhkiG9w0BAQEFAASC
# AQCg9QOAyBAiRwioAkicAwbtavWiH8IAZTr8ZXHMFCN5EfudLvl9rvR6A989ZWYi
# rZHzjevs4jW1njtCWMtepIYptaroegUVU7AyDjMEtOpkF4F8k9sfxdtdIdFilYq7
# yo5P5dF0fKLstCjHAqGD3/dKnCH32GD6CzmhVbxpAdB9cFzpnF5ABS0Ov7pJfA0i
# Jr5EBiKY6BbBAgDX8yJ5jqpJwWVN3es3gnbqNd1xVUDTG9rptY64JyktjwRFshsZ
# BhuOz48GGayEHCZ3BUOp/oBBXL7sXXmiiYrpZeY0wUnzRtLGMPikkHINDGArGVLD
# RWYbRKGjvnWsjdEDDVb2pIWPoYICQzCCAj8GCSqGSIb3DQEJBjGCAjAwggIsAgEB
# MIGpMIGVMQswCQYDVQQGEwJVUzELMAkGA1UECBMCVVQxFzAVBgNVBAcTDlNhbHQg
# TGFrZSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxITAfBgNV
# BAsTGGh0dHA6Ly93d3cudXNlcnRydXN0LmNvbTEdMBsGA1UEAxMUVVROLVVTRVJG
# aXJzdC1PYmplY3QCDxaI8DklXmOOaRQ5B+YzCzAJBgUrDgMCGgUAoF0wGAYJKoZI
# hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNDIzMjM0NjQ4
# WjAjBgkqhkiG9w0BCQQxFgQUHZTM/1FM+dWbRlIKTnWVzQoLijEwDQYJKoZIhvcN
# AQEBBQAEggEAgajVwPc9YzsqDUybI7uPHApfyydF9euDaed9tFLCY3OePAXvWtOE
# hiLYJsYYjsW34B/zL496lpJ/a7H8kwe9T/tFvI+8yPBiIPtRGFXtXCd6ctW9jngM
# iSF5JPM0PNYTpC2QQHJGMWz27NAj3PqTgppXC5Og9w7g67J84/8EGj0HqD5nojap
# zMd3hQOGcTrc6np0YNa+p+IAypO37ckfeHWc76V/zezDpOq3pZWYdQfiS2x9f4RM
# FHgaBf/RxWRI0FZK6Wyunx5BNR+hkisF2KW2J2ZvosR9qotLxqXFtAIZv0Q2tULn
# UnY/bj/5DkiclyQttQ6oCodACuvY3GKA/Q==
# SIG # End signature block
