#I have created a variable called adpt where I am saving the filtered output.

$adapters = Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object {$_.IPEnabled}

# i have used Write-Output for formatting the report.
Write-Host " 	"
Write-Host "++++++++++++++++++++++++---------------------------------- IP Configuration Report  ----------------------------------++++++++++++++++++++++++" 



# this foreach loop i have created to extract the details for each of the adapter which is then stored in variable named report.
$report = foreach ($adpt in $adapters ) {
    [PSCustomObject]@{
        "Adapter Description" = $adpt.Description
        "Index" = $adp.Index
        "IP Address" = $adpt.IPAddress
        "Subnet Mask" = $adpt.IPSubnet
        "DNS Domain Name" = $adpt.DNSDomain
        "DNS Server" = $adpt.DNSServerSearchOrder
        "Default Gateway" = $adpt.DefaultIPGateway
        "DHCP Server" = $adpt.DHCPServer
    }
}

#Formating the report to display it as a table using Format-Table
$report | Format-Table -AutoSize
