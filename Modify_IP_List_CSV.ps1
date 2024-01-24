Clear-Host
Write-Host "################################  Start of Script  ################################"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
$ErrorActionPreference = 'Stop'

$IP_LIST_SOURCE = "$PSScriptRoot\IP_List.csv"
If (-Not (Test-Path -Path $IP_LIST_SOURCE)){
    Write-Host "[ERROR] $IP_LIST_SOURCE File Not found"
    Exit(0)
}

$ConfigFile = "$PSScriptRoot\C1WS-Config.json"
If (-Not (Test-Path -Path $ConfigFile)){
    Write-Host "[ERROR] Config File Not found"
    Exit(0)
}

$Config     = (Get-Content "$PSScriptRoot\C1WS-Config.json" -Raw) | ConvertFrom-Json
$Manager    = $Config.MANAGER
$APIKEY     = $Config.APIKEY
$IPLIST_ID  = 34

$API_Uri        = "/api/iplists/" + $IPLIST_ID
$C1_HOST_URI    = "https://" + $Manager + $API_Uri

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $APIKEY)
$headers.Add("api-version", 'v1')
$headers.Add("Content-Type", 'application/json')

$IP_List = Import-Csv $IP_LIST_SOURCE
$IP_List_Payload = [System.Collections.ArrayList]@()
foreach ($Item in $IP_List){
    $IP_List_Payload.add($Item.IP) 
    }

$IP_ITEM_PAYLOAD = @{
    "items" = @($IP_List_Payload)
} 

$IP_ITEM_PAYLOAD_JSON = $IP_ITEM_PAYLOAD | ConvertTo-Json -Depth 4
$IP_ITEM_PAYLOAD_JSON

try {
    $SystemSettings =  Invoke-RestMethod -Uri $C1_HOST_URI -Method Post -Headers $Headers -Body $IP_ITEM_PAYLOAD_JSON
    Write-Host "[INFO]  Connection Successful"

    $SystemSettings = $SystemSettings | ConvertTo-Json -Depth 4
    Write-Host $SystemSettings
}
catch {
    Write-Host "[ERROR]	Failed to retreive System Settings.	$_"
    Exit
}