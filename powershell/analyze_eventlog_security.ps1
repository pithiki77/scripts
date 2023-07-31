$d = Get-EventLog -Log Security -Newest 200 | Where-Object {$_.InstanceID -eq 5152}

## Now the variable $d contains all of the events for dropped packets.  Doing a $d | gm will show the lack of options.  So we will use mjlinor’s secret sauce to parse the message fields and make those important fields a property of the object.

$d | ForEach-Object {$_.message -match "Source Address:\s+(\S+)">$null;$_ | Add-Member -membertype noteproperty -name "SrcIP" -value $matches[1]}

$d | ForEach-Object {$_.message -match "Destination Address:\s+(\S+)">$null;$_ | Add-Member -membertype noteproperty -name "DstIP" -value $matches[1]}

$d | ForEach-Object {$_.message -match "Source Port:\s+(\S+)">$null;$_ | Add-Member -membertype noteproperty -name "SrcPort" -value $matches[1]}

$d | ForEach-Object {$_.message -match "Destination Port:\s+(\S+)">$null;$_ | Add-Member -membertype noteproperty -name "DstPort" -value $matches[1]}

## Now running a $d | gm should show the additional properties of this object.  And running the following command will actually give us readable information!

##  $d | ft TimeGenerated, SrcIP, SrcPort, Direction, DstIP, DstPort, Protocol -autosize

## $d | Where-Object -Property SrcPort -EQ 443| ft TimeGenerated, SrcIP, SrcPort, Direction, DstIP, DstPort, Protocol -autosize

$d | Where-Object -Property SrcIP -NE 10.11.12.18| Where-Object -Property SrcIP -NE 10.11.12.34|Where-Object -Property SrcIP -NE 192.168.1.142|Where-Object -Property SrcIP -NE 192.168.0.201| format-table TimeGenerated, SrcIP, SrcPort, Direction, DstIP, DstPort, Protocol -autosize