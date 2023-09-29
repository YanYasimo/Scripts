#########################################################################
# File: Compress_same_files.ps1
# Author: Yan Moura
# Contact: yanmoura142529@gmail.com
# 10/08/2023

# Describe: This Script was created for porpouse of compress files with same name but different extensions
#########################################################################

$TargetFolder = (Resolve-Path .\).Path + "\"
echo $TargetFolder

Get-ChildItem -Recurse -File |
Group-Object -Property Directory,BaseName |
Where-Object Count -gt 1 | foreach-object{
    $string = $_.Name.Split(',')
    $path = $string[0]
    $basename = $string[1].TrimStart(' ')
    $targetFile = $TargetFolder + $basename + ".*"
    $destinationFile = $TargetFolder + $basename + ".zip"

    Compress-Archive -Path $targetFile -CompressionLevel Fastest -DestinationPath $destinationFile
}
