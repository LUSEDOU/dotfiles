$Dotfiles = "${HOME}\dotfiles"
$Work = "${HOME}\work"

$env:PATH = $env:PATH + ";${HOME}\AppData\Roaming\npm"
$env:PATH = $env:PATH + ";${HOME}\.local\bin"
$env:PATH = $env:PATH + ";${HOME}\.local\bin\scripts"


function link ($target, $link)
{
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

# Set-Location $env:USERPROFILE\dotfiles && nvim .
function dotfiles
{
    Set-Location $Dotfiles
    Invoke-Expression -Command "nvim ."
}

function tt
{
    fd . $Work $Dotfiles $Home  -t d -d 2 -H | fzf | Set-Location
}

# . $profile
function szz
{
    . $PROFILE
}

function touch
{
    New-Item -ItemType File $args[0]
}
function mkcd
{
    New-Item -ItemType Directory $args[0] | Set-Location
}
function rmrf
{
    Remove-Item -Recurse -Force $args[0]
}
function init
{
    # neofetch
    # C:\Users\dolurilu\scoop\shims\komorebic.exe start -c "$Env:USERPROFILE\komorebi.json" --whkd
    # Start-Process C:\Users\dolurilu\stuff\yasb\yasb.bat -Windowstyle hidden
}
function restart
{
    komorebic.exe stop
    Get-Process -Name komorebi | Stop-Process
    Get-Process -Name whkd | Stop-Process
    Get-Process -Name python | Stop-Process
}

function which
{
    Get-Command $args[0]
}

Set-Alias -Name vim -Value nvim
Set-Alias -Name lg -Value lazygit


# Flutter
function ddg
{
    fvm dart pub get $args
}
function ffg
{
    fvm flutter pub get $args
}
function dd
{
    fvm dart $args
}
function ff
{
    fvm flutter $args
}
function ffr
{
    fvm flutter run $args
}
function Invoke-GitClone
{
    param (
        [Parameter(Mandatory=$true)]
        [string]$Repository,
        [string]$Directory = ("$Home/stuff"),
        [string]$Domain = 'github.com',
        [bool]$UseSSH = $true
    )
    $url = "https://$Domain/$Repository"

    if ($UseSSH)
    {
        $url = "git@${Domain}:$Repository.git"
    }
    $Directory = Join-Path $Directory $Repository.Split('/')[-1]
    Write-Output 'Cloning repository in ' $Directory
    git clone $url $Directory
}
Set-Alias -Name gg -Value Invoke-GitClone
Set-Alias -Name mamba -Value C:\Users\dolor\mambaforge\Library\bin\mamba.BAT

Import-Module -Name Terminal-Icons
#
if (Get-Command 'starship' -ErrorAction SilentlyContinue)
{
    function Invoke-Starship-PreCommand
    {
        if ($global:profile_initialized -ne $true)
        {
            $global:profile_initialized = $true
            Initialize-Profile
        }
    }
    Invoke-Expression (&starship init powershell)
}
