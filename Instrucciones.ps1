# Ejercicio 1 BASE DE DATOS

(Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content

# Collect password 
$adminSqlLogin = "cloudadmin"
$password = Read-Host "Your username is 'cloudadmin'. Please enter a password for your Azure SQL Database server that meets the password requirements"
# Prompt for local ip address
$ipAddress = Read-Host "Disconnect your VPN, open PowerShell on your machine and run '(Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content'. Please enter the value (include periods) next to 'Address': "
Write-Host "Password and IP Address stored"

# Get resource group and location and random string
$resourceGroupName = "lavelozRG"
New-AzResourceGroup -Name $resourceGroupName -Location "francecentral"
$resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like $resourceGroupName
# $uniqueID = Get-Random -Minimum 100000 -Maximum 1000000
$uniqueID = "jun2021bmvb"
$location = $resourceGroup.Location
# The logical server name has to be unique in the system
$serverName = "bus-server$($uniqueID)"
# The sample database name
$databaseName = "bus-db"    
Write-Host "Please note your unique ID for future exercises in this module:"  
Write-Host $uniqueID
Write-Host "Your resource group name is:"
Write-Host $resourceGroupName
Write-Host "Your resources were deployed in the following region:"
Write-Host $location
Write-Host "Your server name is:"
Write-Host $serverName


# Create a new server with a system wide unique server name
$server = New-AzSqlServer -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -Location $location `
    -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminSqlLogin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))
# Create a server firewall rule that allows access from the specified IP range and all Azure services
$serverFirewallRule = New-AzSqlServerFirewallRule `
    -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -FirewallRuleName "AllowedIPs" `
    -StartIpAddress $ipAddress -EndIpAddress $ipAddress 
$allowAzureIpsRule = New-AzSqlServerFirewallRule `
    -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -AllowAllAzureIPs
# Create a database
$database = New-AzSqlDatabase  -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -DatabaseName $databaseName `
    -Edition "GeneralPurpose" -Vcore 4 -ComputeGeneration "Gen5" `
    -ComputeModel Serverless -MinimumCapacity 0.5
Write-Host "Database deployed."

# Ejercicio 2 Azure Function
$resourceGroupName = "lavelozRG"
$resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like $resourceGroupName
#$uniqueID = Get-Random -Minimum 100000 -Maximum 1000000
$location = $resourceGroup.Location
# Azure function name
#$azureFunctionName = $("azfunc$($uniqueID)")
$azureFunctionName = "azfunclavelozbmvb2021"
# Get storage account name
$storageAccountName = (Get-AzStorageAccount -ResourceGroup $resourceGroupName).StorageAccountName
$storageAccountName

#$storageAccountName = $("storageaccount$($uniqueID)")
$storageAccountName = "azsalavelozbmvb2021"
$storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroupName -AccountName $storageAccountName -Location $location -SkuName Standard_GRS

$functionApp = New-AzFunctionApp -Name $azureFunctionName `
    -ResourceGroupName $resourceGroupName -StorageAccount $storageAccountName `
    -FunctionsVersion 3 -RuntimeVersion 3 -Runtime dotnet -Location $location