# $files = fd . --max-depth 1 --type d -a
# Write-Output $files

function barrel(
    [Parameter(Mandatory=$true)]
    [string]$Dir,
    [Parameter(Mandatory=$true)]
    [String]$Extension,
    [Parameter(Mandatory=$true)]
    [String]$ImportPattern
)
{
    Write-Output "Creating barrel file for $Dir"
    $files = fd . -e $Extension $Dir --max-depth 1 --type f
    Write-Output $files
    # New-Item -ItemType file -Path "$Dir/$DirName.$Extension" -Force
    # For each $file in $files
    # echo $file
    $DirN = $Dir.Split("\")[-2]
    $barrelFile = "$Dir/$DirN.$Extension"
    New-Item -ItemType file -Path $barrelFile -Force

    foreach ($file in $files)
    {
        $fileName = $file.Split("\")[-1]
        Write-Output "Importing $fileName"
        $importText = $importPattern.Replace("{{fileName}}", $fileName)
        Write-Output $importText >> $barrelFile
    }

    $dirs = fd . $Dir --max-depth 1 --type d -a
    foreach ($dir in $dirs)
    {
        $dirName = $dir.Split("\")[-2]
        $dirName = "$dirName/$dirName.$Extension"
        Write-Output "Importing $dirName"
        $importText = $importPattern.Replace("{{fileName}}", $dirName)
        Write-Output $importText >> $barrelFile
    }
    bat $barrelFile
}
