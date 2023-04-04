# I have created a function which will collect info about system hardware.

function Get-SystemHardwareDetails{
    $systemHardwareDetail = Get-WmiObject -Class Win32_ComputerSystem
    $GSHD = [PSCustomObject]@{
        "Hardware Manufacturer" = $systemHardwareDetail.Manufacturer
        "Hardware Model" = $systemHardwareDetail.Model
        "Total Physical Memory" = "{0:N2} GB" -f ($systemHardwareDetail.TotalPhysicalMemory / 1GB)
        "Hardware Description" =$systemHardwareDetail.Description
        "System Type" = $systemHardwareDetail.SystemType
    }
    return $GSHD

}

# I have created a function which will collect info about Oprating system.
function Get-OperatingSystemDetails {
    $OperatingSystemDetail = Get-CimInstance -ClassName Win32_OperatingSystem
    $OSD=[PSCustomObject]@{
        "System Name" = $OperatingSystemDetail.Caption
        "Version Number" = $OperatingSystemDetail.Version
    }
return $OSD
}

# I have created a function which will collect info about the processor of system.
function Get-ProcessorDetails {
   $processor = Get-WmiObject -Class Win32_Processor
    $output = @()
    $output += "Name: $($processor.Name)"
    $output += "Number of Cores: $($processor.NumberOfCores)"
    $output += "Speed: $($processor.MaxClockSpeed) MHz"
    if ($processor.L1CacheSize -ne $null) {
        $output += "L1 Cache Size: $($processor.L1CacheSize / 1KB) KB"
    } else {
        $output += "L1 Cache Size: N/A"
    }
    if ($processor.L2CacheSize -ne $null) {
        $output += "L2 Cache Size: $($processor.L2CacheSize / 1KB) KB"
    } else {
        $output += "L2 Cache Size: N/A"
    }
    if ($processor.L3CacheSize -ne $null) {
        $output += "L3 Cache Size: $($processor.L3CacheSize / 1KB) KB"
    } else {
        $output += "L3 Cache Size: N/A"
    }
    return $output
    
}


# I have created a function which will collect info about Memory of the system.
function Get-RAMmemory {
   $RAMmemory = Get-WmiObject -Class Win32_PhysicalMemory
    $totalMemory = 0
    $GRAM = foreach ($RAM in $RAMmemory) {
        [PSCustomObject]@{
            Vendor = $RAM.Manufacturer
            Description = $RAM.Description
            Capacity = "{0:N2} GB" -f ($RAM.Capacity / 1GB)
            'Bank/Slot' = $RAM.DeviceLocator
            'Memory Type' = $RAM.MemoryType
            Speed = $RAM.Speed
        }
        $totalMemory += $RAM.Capacity
    }
    
    Write-Host "Total RAM installed: $(('{0:N2}' -f ($totalMemory / 1GB))) GB"
  $GRAM | Format-Table -AutoSize

 }

# I have created a function which will collect info about Disk drive of the system.
function Get-DiskDriveDetails{
 $diskdrives = Get-CIMInstance CIM_diskdrive

  foreach ($disk in $diskdrives) {
   $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
    foreach ($partition in $partitions) {
            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
	$freeSpace = [math]::Round(($logicaldisk.FreeSpace / $logicaldisk.Size) * 100, 2)
		$GDD = [PSCustomObject]@{

			Manufacturer=$disk.Manufacturer
                                                          Model=$disk.Model     
			 Size = "{0:N2} GB" -f ($logicaldisk.Size / 1GB)
               			"Free Space" = "{0:N2} GB" -f ($logicaldisk.FreeSpace / 1GB)
			"Free space in %" = "$freeSpace%"
			                                                     }
		 $GDD 
           }
      }
  }

}
                                                         
# I have created a function which will collect info about Video controller.
function Get-VideoControllerDetails {
    $videoDetail = Get-WmiObject -Class Win32_VideoController
    $GVCD= foreach ($vd in $videoDetail) {
        [PSCustomObject]@{
            Vendor = $vd.VideoProcessor
            Description = $vd.Description
            Resolution = "{0}x{1}" -f $vd.CurrentHorizontalResolution, $v.CurrentVerticalResolution
        }
    }
    $GVCD | Format-List
}

# I have created a function which will collect info about IP Configuration.
function Get-IPconfiguration{
$adapters = Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object {$_.IPEnabled}
$report = foreach ($adpt in $adapters ) {
    [PSCustomObject]@{
        "Adapter Description" = $adpt.Description
        "Index" = $adp.Index
        "IP Address(es)" = $adpt.IPAddress
        "Subnet Mask(s)" = $adpt.IPSubnet
        "DNS Domain Name" = $adpt.DNSDomain
        "DNS Server(s)" = $adpt.DNSServerSearchOrder
       "Default Gateway(s)" = $adpt.DefaultIPGateway
        "DHCP Server(s)" = $adpt.DHCPServer
    }
}
$report | Format-Table -AutoSize

}



# i have used Write-Output for formatting the report.
Write-Host " 	"
Write-Host "++++++++++++++++++++++++---------------------------------- System Information Report  ----------------------------------++++++++++++++++++++++++" 

Write-Output "			Hardware Detail"
Write-Output "--------------------------------------------------------------------------------------------------------------------------------------"
#system hardware function.
Get-SystemHardwareDetails


Write-Output "			Oprating System Detail"
Write-Output "--------------------------------------------------------------------------------------------------------------------------------------"
#system hardware function.
Get-OperatingSystemDetails

Write-Output "			Processor Detail"
Write-Output "--------------------------------------------------------------------------------------------------------------------------------------"
#system hardware function.
Get-ProcessorDetails 

Write-Output "			RAM Memory Detail"
Write-Output "--------------------------------------------------------------------------------------------------------------------------------------"
#system hardware function.
Get-RAMmemory 

Write-Output "			Disk Drive Detail"
Write-Output "--------------------------------------------------------------------------------------------------------------------------------------"
#system hardware function.
Get-DiskDriveDetails | Format-Table -AutoSize


Write-Host "			IP Configuration Detail"
Write-Host "--------------------------------------------------------------------------------------------------------------------------------------"
#system hardware function.
Get-IPconfiguration

Write-Host "			Video Controller Detail"
Write-Host "--------------------------------------------------------------------------------------------------------------------------------------"
#system hardware function.
Get-VideoControllerDetails
