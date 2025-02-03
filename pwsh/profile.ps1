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

# powershell completion for oh-my-posh                           -*- shell-script -*-

function __oh-my-posh_debug
{
    if ($env:BASH_COMP_DEBUG_FILE)
    {
        "$args" | Out-File -Append -FilePath "$env:BASH_COMP_DEBUG_FILE"
    }
}

filter __oh-my-posh_escapeStringWithSpecialChars
{
    $_ -replace '\s|#|@|\$|;|,|''|\{|\}|\(|\)|"|`|\||<|>|&','`$&'
}

[scriptblock]${__oh_my_poshCompleterBlock} = {
    param(
        $WordToComplete,
        $CommandAst,
        $CursorPosition
    )

    # Get the current command line and convert into a string
    $Command = $CommandAst.CommandElements
    $Command = "$Command"

    __oh-my-posh_debug ""
    __oh-my-posh_debug "========= starting completion logic =========="
    __oh-my-posh_debug "WordToComplete: $WordToComplete Command: $Command CursorPosition: $CursorPosition"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $CursorPosition location, so we need
    # to truncate the command-line ($Command) up to the $CursorPosition location.
    # Make sure the $Command is longer then the $CursorPosition before we truncate.
    # This happens because the $Command does not include the last space.
    if ($Command.Length -gt $CursorPosition)
    {
        $Command=$Command.Substring(0,$CursorPosition)
    }
    __oh-my-posh_debug "Truncated command: $Command"

    $ShellCompDirectiveError=1
    $ShellCompDirectiveNoSpace=2
    $ShellCompDirectiveNoFileComp=4
    $ShellCompDirectiveFilterFileExt=8
    $ShellCompDirectiveFilterDirs=16
    $ShellCompDirectiveKeepOrder=32

    # Prepare the command to request completions for the program.
    # Split the command at the first space to separate the program and arguments.
    $Program,$Arguments = $Command.Split(" ",2)

    $RequestComp="$Program __complete $Arguments"
    __oh-my-posh_debug "RequestComp: $RequestComp"

    # we cannot use $WordToComplete because it
    # has the wrong values if the cursor was moved
    # so use the last argument
    if ($WordToComplete -ne "" )
    {
        $WordToComplete = $Arguments.Split(" ")[-1]
    }
    __oh-my-posh_debug "New WordToComplete: $WordToComplete"


    # Check for flag with equal sign
    $IsEqualFlag = ($WordToComplete -Like "--*=*" )
    if ( $IsEqualFlag )
    {
        __oh-my-posh_debug "Completing equal sign flag"
        # Remove the flag part
        $Flag,$WordToComplete = $WordToComplete.Split("=",2)
    }

    if ( $WordToComplete -eq "" -And ( -Not $IsEqualFlag ))
    {
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go method.
        __oh-my-posh_debug "Adding extra empty parameter"
        # PowerShell 7.2+ changed the way how the arguments are passed to executables,
        # so for pre-7.2 or when Legacy argument passing is enabled we need to use
        # `"`" to pass an empty argument, a "" or '' does not work!!!
        if ($PSVersionTable.PsVersion -lt [version]'7.2.0' -or
            ($PSVersionTable.PsVersion -lt [version]'7.3.0' -and -not [ExperimentalFeature]::IsEnabled("PSNativeCommandArgumentPassing")) -or
            (($PSVersionTable.PsVersion -ge [version]'7.3.0' -or [ExperimentalFeature]::IsEnabled("PSNativeCommandArgumentPassing")) -and
            $PSNativeCommandArgumentPassing -eq 'Legacy'))
        {
            $RequestComp="$RequestComp" + ' `"`"'
        } else
        {
            $RequestComp="$RequestComp" + ' ""'
        }
    }

    __oh-my-posh_debug "Calling $RequestComp"
    # First disable ActiveHelp which is not supported for Powershell
    ${env:OH_MY_POSH_ACTIVE_HELP}=0

    #call the command store the output in $out and redirect stderr and stdout to null
    # $Out is an array contains each line per element
    Invoke-Expression -OutVariable out "$RequestComp" 2>&1 | Out-Null

    # get directive from last line
    [int]$Directive = $Out[-1].TrimStart(':')
    if ($Directive -eq "")
    {
        # There is no directive specified
        $Directive = 0
    }
    __oh-my-posh_debug "The completion directive is: $Directive"

    # remove directive (last element) from out
    $Out = $Out | Where-Object { $_ -ne $Out[-1] }
    __oh-my-posh_debug "The completions are: $Out"

    if (($Directive -band $ShellCompDirectiveError) -ne 0 )
    {
        # Error code.  No completion.
        __oh-my-posh_debug "Received error from custom completion go code"
        return
    }

    $Longest = 0
    [Array]$Values = $Out | ForEach-Object {
        #Split the output in name and description
        $Name, $Description = $_.Split("`t",2)
        __oh-my-posh_debug "Name: $Name Description: $Description"

        # Look for the longest completion so that we can format things nicely
        if ($Longest -lt $Name.Length)
        {
            $Longest = $Name.Length
        }

        # Set the description to a one space string if there is none set.
        # This is needed because the CompletionResult does not accept an empty string as argument
        if (-Not $Description)
        {
            $Description = " "
        }
        @{Name="$Name";Description="$Description"}
    }


    $Space = " "
    if (($Directive -band $ShellCompDirectiveNoSpace) -ne 0 )
    {
        # remove the space here
        __oh-my-posh_debug "ShellCompDirectiveNoSpace is called"
        $Space = ""
    }

    if ((($Directive -band $ShellCompDirectiveFilterFileExt) -ne 0 ) -or
       (($Directive -band $ShellCompDirectiveFilterDirs) -ne 0 ))
    {
        __oh-my-posh_debug "ShellCompDirectiveFilterFileExt ShellCompDirectiveFilterDirs are not supported"

        # return here to prevent the completion of the extensions
        return
    }

    $Values = $Values | Where-Object {
        # filter the result
        $_.Name -like "$WordToComplete*"

        # Join the flag back if we have an equal sign flag
        if ( $IsEqualFlag )
        {
            __oh-my-posh_debug "Join the equal sign flag back to the completion value"
            $_.Name = $Flag + "=" + $_.Name
        }
    }

    # we sort the values in ascending order by name if keep order isn't passed
    if (($Directive -band $ShellCompDirectiveKeepOrder) -eq 0 )
    {
        $Values = $Values | Sort-Object -Property Name
    }

    if (($Directive -band $ShellCompDirectiveNoFileComp) -ne 0 )
    {
        __oh-my-posh_debug "ShellCompDirectiveNoFileComp is called"

        if ($Values.Length -eq 0)
        {
            # Just print an empty string here so the
            # shell does not start to complete paths.
            # We cannot use CompletionResult here because
            # it does not accept an empty string as argument.
            ""
            return
        }
    }

    # Get the current mode
    $Mode = (Get-PSReadLineKeyHandler | Where-Object {$_.Key -eq "Tab" }).Function
    __oh-my-posh_debug "Mode: $Mode"

    $Values | ForEach-Object {

        # store temporary because switch will overwrite $_
        $comp = $_

        # PowerShell supports three different completion modes
        # - TabCompleteNext (default windows style - on each key press the next option is displayed)
        # - Complete (works like bash)
        # - MenuComplete (works like zsh)
        # You set the mode with Set-PSReadLineKeyHandler -Key Tab -Function <mode>

        # CompletionResult Arguments:
        # 1) CompletionText text to be used as the auto completion result
        # 2) ListItemText   text to be displayed in the suggestion list
        # 3) ResultType     type of completion result
        # 4) ToolTip        text for the tooltip with details about the object

        switch ($Mode)
        {

            # bash like
            "Complete"
            {

                if ($Values.Length -eq 1)
                {
                    __oh-my-posh_debug "Only one completion left"

                    # insert space after value
                    [System.Management.Automation.CompletionResult]::new($($comp.Name | __oh-my-posh_escapeStringWithSpecialChars) + $Space, "$($comp.Name)", 'ParameterValue', "$($comp.Description)")

                } else
                {
                    # Add the proper number of spaces to align the descriptions
                    while($comp.Name.Length -lt $Longest)
                    {
                        $comp.Name = $comp.Name + " "
                    }

                    # Check for empty description and only add parentheses if needed
                    if ($($comp.Description) -eq " " )
                    {
                        $Description = ""
                    } else
                    {
                        $Description = "  ($($comp.Description))"
                    }

                    [System.Management.Automation.CompletionResult]::new("$($comp.Name)$Description", "$($comp.Name)$Description", 'ParameterValue', "$($comp.Description)")
                }
            }

            # zsh like
            "MenuComplete"
            {
                # insert space after value
                # MenuComplete will automatically show the ToolTip of
                # the highlighted value at the bottom of the suggestions.
                [System.Management.Automation.CompletionResult]::new($($comp.Name | __oh-my-posh_escapeStringWithSpecialChars) + $Space, "$($comp.Name)", 'ParameterValue', "$($comp.Description)")
            }

            # TabCompleteNext and in case we get something unknown
            Default
            {
                # Like MenuComplete but we don't want to add a space here because
                # the user need to press space anyway to get the completion.
                # Description will not be shown because that's not possible with TabCompleteNext
                [System.Management.Automation.CompletionResult]::new($($comp.Name | __oh-my-posh_escapeStringWithSpecialChars), "$($comp.Name)", 'ParameterValue', "$($comp.Description)")
            }
        }

    }
}

Register-ArgumentCompleter -CommandName 'oh-my-posh' -ScriptBlock ${__oh_my_poshCompleterBlock}
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

Import-Module -Name Terminal-Icons

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

# oh-my-posh init pwsh --config '~/.mytheme.omp.json' | Invoke-Expression
