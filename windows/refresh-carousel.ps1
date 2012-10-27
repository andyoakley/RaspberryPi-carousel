$WORKINGDIR=working
$SLIDESDIR=slides

md $WORKINGDIR
md $SLIDESDIR

function md5
{
	param($s)

	$hasher = [System.Security.Cryptography.MD5]::Create()
	$bytes = [System.Text.Encoding]::UTF8.GetBytes($s)

	$hashBytes = $hasher.ComputeHash($bytes)
	
	$builder = New-Object System.Text.StringBuilder
	$hashBytes | Foreach-Object { [void] $builder.Append($_.ToString("x2")) }
	$builder.ToString()
}


write-host "Generating carousel images"
write-host $(get-date)



# Generate URL snapshots
del $WORKINGDIR\*.png
foreach ($line in get-content list.txt)
{
	if ($line.startsWith("#")) { continue }

	$parts = $line.Split(",")
	$delay = $parts[0]
	$url = $parts[1]

	write-host "Snapping $url -> $(md5 $url)`r`n"
	iesnapper.exe -w 1920 -h 1080 --load-delay $delay --url "$url" --out "$WORKINGDIR/$(md5 $url).png"
}

# Switch old for new
del $SLIDESDIR\*.png
copy $WORKINGDIR\*.png $SLIDESDIR

# Push out to screens
foreach ($line in get-content rpis.txt)
{
	if ($line.startsWith("#")) { continue }

	write-host "Copying to $line"
	pscp.exe -i key.ppk $SLIDESDIR\*.png carousel@$($line):~/slides"
}
