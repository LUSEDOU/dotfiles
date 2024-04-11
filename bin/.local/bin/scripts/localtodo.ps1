# localTodo.ps1
# Find the nearest TODO | WIP file in the current directory
# and open it in the default viewer
#
# Usage:
# localTodo.ps1
# localTodo.ps1 -wip
# localTodo.ps1 -todo
# localTodo.ps1 -all (default)

function Get-TodoFile
{
    param (
        [Parameter(Mandatory=$true)]
        [string]$pattern
    )
    $files = fd $pattern -tf -H
    if ($null -eq $files)
    {
        Write-Host "No $pattern files found"
        return
    }
    $file = ''
    if ($files.Count -gt 1)
    {
        $file = $files | fzf
    } else
    {
        $file = $files
    }

    if ($null -eq $file)
    {
        return
    }

    $command = ''
    if ($file -match '\.md$')
    {
        $command = "glow $file -p"
    } else
    {
        $command = "bat $file -p --paging=always"
    }

    Invoke-Expression $command
}


Get-TodoFile -pattern "todo|wip"
