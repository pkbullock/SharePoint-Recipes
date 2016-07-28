# Created by Paul Bullock @ Capa Creative Ltd.
# ------------------------------------------------------------------------------------------------
# Credit goes to https://msdn.microsoft.com/en-us/library/office/dn726681.aspx 
#  - Replace an expiring client secret in a SharePoint Add-in
#
# This script lists out the app principles, app details and their expiry dates to CSV
# ------------------------------------------------------------------------------------------------

# Connect to SharePoint Online
Connect-MsolService 

# File containing details of the app expiry status
$outputFile = (Resolve-Path .\).Path + "\ListOfApps.csv"

# Collect the app principles from the tenancy and output to file
$listOfApps = Get-MsolServicePrincipal  | Where-Object -FilterScript { ($_.DisplayName -notlike "*Microsoft*") -and ($_.DisplayName -notlike "autohost*") -and ($_.ServicePrincipalNames -notlike "*localhost*") } 

# Array of the app details
$appDetails = @()

foreach ($app in $listOfApps) {
    $principalId = $app.AppPrincipalId
    $principalName = $app.DisplayName

    # Collect details about the app
    Get-MsolServicePrincipalCredential -AppPrincipalId $principalId -ReturnKeyValues $true | Where-Object { ($_.Type -ne "Other") -and ($_.Type -ne "Asymmetric") } | ForEach-Object {
        $date = $_.EndDate.ToShortDateString()
       
        $appDetail = New-Object PSObject
        $appDetail | Add-Member -MemberType NoteProperty -Name "PrincpleName" -Value "$($principalName)"
        $appDetail | Add-Member -MemberType NoteProperty -Name "PrincipleId" -Value "$($principalId)"
        $appDetail | Add-Member -MemberType NoteProperty -Name "Key" -Value "$($_.KeyId)"
        $appDetail | Add-Member -MemberType NoteProperty -Name "Type" -Value "$($_.type)"
        $appDetail | Add-Member -MemberType NoteProperty -Name "ExpiryDate" -Value "$($date)"
        $appDetail | Add-Member -MemberType NoteProperty -Name "Usage" -Value "$($_.Usage)"
        $appDetail | Add-Member -MemberType NoteProperty -Name "Value" -Value "$($_.Value)"
        
        $appDetails += $appDetail

        $appDetail
    }
} 

$appDetails | Export-Csv -Path $outputFile -NoTypeInformation

Write-Host "File created: " $outputFile