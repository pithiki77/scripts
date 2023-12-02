$data_tocompile = get-content ..\scripts\2023adventofcode\day01\rawdata.txt


$data_tocompile | Measure-Object

write-host "first line"
$data_tocompile[0]
write-host
write-host "lastline"
$data_tocompile[-1]
write-host "datarow length " $data_tocompile.length

Set-Content ..\scripts\2023adventofcode\day01\data.txt "" -NoNewline

for ($l=0;$l -le $data_tocompile.Length-1;$l++ )
#for ($l=0;$l -le 2;$l++ )
{

    write-host "                                  datarow" ($l+1) "length " $data_tocompile[$l].length

    for ($i=0;$i -le $data_tocompile[$l].Length-1;$i++ )
    {

        write-host "character position" $i "     "  $data_tocompile[$l][$i]
        if ($data_tocompile[$l][$i] -match "^\d+$")
        {
            write-host "                  found number" $data_tocompile[$l][$i]
            add-Content ..\scripts\2023adventofcode\day01\data.txt $data_tocompile[$l][$i] -NoNewline
            $i=$data_tocompile[$l].Length-1
        }

        
    }

    for ($i=$data_tocompile[$l].Length-1;$i -ge 0;$i-- )
    {

        write-host "character position" $i "     "  $data_tocompile[$l][$i]
        if ($data_tocompile[$l][$i] -match "^\d+$")
        {
            write-host "                  found number back" $data_tocompile[$l][$i]
            add-Content ..\scripts\2023adventofcode\day01\data.txt $data_tocompile[$l][$i] -NoNewline
            $i=0
        }

        
    }

    add-Content ..\scripts\2023adventofcode\day01\data.txt ""

}

$finaldata = Get-Content ..\scripts\2023adventofcode\day01\data.txt

$finaldata.Length

[int32]$sum=0
for ($k=0;$k -le $finaldata.Length-1;$k++){
[int32]$sum+=$finaldata[$k]
}


$sum