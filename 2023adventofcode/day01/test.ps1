$data_tocompile = get-content "C:\Users\panos\git\scripts\2023adventofcode\day01\rawdata.txt"

$data_tocompile | Measure-Object

write-host "first line"
$data_tocompile[0]
write-host
write-host "lastline"
$data_tocompile[-1]
write-host "datarow length " $data_tocompile.length

#for ($l=0;$l -le $data_tocompile.Length-1;$l++ )
for ($l=0;$l -le 2;$l++ )
{

    write-host "datarow" $l "length " $data_tocompile[$l].length

    for ($i=0;$i -le $data_tocompile[$l].Length-1;$i++ )
    {

        write-host $i "     "  $data_tocompile[$l][$i]
        if ($data_tocompile[$l][$i] -match "^\d+$")
        {
            write-host "found number" $data_tocompile[$l][$i]
            $raw[$l][0] = $data_tocompile[$l][$i]
        }


    }


}
