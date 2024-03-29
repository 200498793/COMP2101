$env:path += ";$home/documents/github/comp2101/powershell"


function welcome {
"Good morning!!!"
write-output "Welcome to planet $env:computername Overlord $env:username"
$now = get-date -format 'HH:MM tt on dddd'
write-output "It is $now."
}

function get-cpuinfo{
get-ciminstance -class cim_processor | select-object manufacturer, model, maxclockspeed, currentclockspeed, numberofcores | format-table -autosize

}

function get-mydisks{

get-ciminstance cim_diskdrive | foreach-object{
	[PSCustomObject]@{
	Manufacturer	= $_.Manufacturer
	Model			= $_.Model
	SerialNumber	= $_.SerialNumber
	FirmwareRevision	= $_.FirmwareRevision
	Size			= $_.Size

	}

} | Format-table -autoSize
}