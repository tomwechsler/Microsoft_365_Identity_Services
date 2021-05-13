Set-Location c:\
Clear-Host

#We need the PowerShell module
Install-Module MSOnline -AllowClobber -Force -Verbose

#Lets connect
Connect-MsolService

#To find the unlicensed accounts in your organization
Get-MsolUser -All -UnlicensedUsersOnly

#To find accounts that don't have a UsageLocation value
Get-MsolUser -All | where {$_.UsageLocation -eq $null}

#View all users with Displayname and UsageLocation
Get-MsolUser -All | Format-Table DisplayName,Usagelocation -AutoSize

#List the licensing plans that are available in your organization
Get-MsolAccountSku

#List the services that are available in each licensing plan
(Get-MsolAccountSku | where {$_.AccountSkuId -eq "tomms100:ENTERPRISEPACK"}).ServiceStatus

#This example shows the services to which the user jane.ford@tomrocks.xyz has access
(Get-MsolUser -UserPrincipalName jane.ford@tomrocks.xyz).Licenses.ServiceStatus

#Set UsageLocation for a specific user
Set-MsolUser -UserPrincipalName "timo.dodge@tomrocks.xyz" -UsageLocation CH

#Add a license for a specific user
Set-MsolUserLicense -UserPrincipalName "timo.dodge@tomrocks.xyz" -AddLicenses "tomms100:ENTERPRISEPACK"

#Set a license for all unlicensed users (maybe not the best option - be careful)
Get-MsolUser -All -UnlicensedUsersOnly | Set-MsolUserLicense -AddLicenses "tomms100:ENTERPRISEPACK"

#We investigate a department
Get-MsolUser -All -Department "Administration" -UnlicensedUsersOnly | Select-Object DisplayName, UsageLocation, Islicensed

#Set UsageLocation for a specific user
Set-MsolUser -UserPrincipalName "tina.schmid@tomrocks.xyz" -UsageLocation CH

#A safer way to add licenses to users
Get-MsolUser -All -Department "Administration" -UsageLocation "CH" -UnlicensedUsersOnly | Set-MsolUserLicense -AddLicenses "tomms100:ENTERPRISEPACK"