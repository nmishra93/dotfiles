oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\stelbent-compact.minimal.omp.json" | Invoke-Expression

# Import Terminal Icons
Import-Module -Name Terminal-Icons

# Quick shortcut to start notepad
function n { notepad $args }

# Simple function to start a new elevated process. If arguments are supplied then 
# a single command is started with admin rights; if not then a new admin instance
# of PowerShell is started.
function admin {
    if ($args.Count -gt 0) {   
        $argList = "& '" + $args + "'"
        Start-Process "$psHome\pwsh.exe" -Verb runAs -ArgumentList $argList
    } else {
        Start-Process "$psHome\pwsh.exe" -Verb runAs
    }
}

function ll { Get-ChildItem -Path $pwd -File }
function g { Set-Location $HOME\Documents\Github }
function tt {
    Set-Location "$HOME\Documents\tidytuesday"
    code .
}
function da { 
    Set-Location "$HOME\Documents\Data Analysis" 
    code .
}
function bli {
    Set-Location "$HOME\OneDrive - Scripps Research\Desktop Files\Data Analysis\BLI"
    code .
}
function c {
    code .
}
function gcom {
    git add .
    git commit -m "$args"
}
function lazyg {
    git add .
    git commit -m "$args"
    git push
}

function touch($file) {
    "" | Out-File $file -Encoding ASCII
}

function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}

function rmrf($path)
{
    Remove-Item $path -Recurse -Force
}

function rm($path)
{
    Remove-Item $path
}

function mv($path, $dest)
{
    Move-Item $path $dest -Force -Recurse
}

function cp($path, $dest)
{
    Copy-Item $path $dest -Force -Recurse
}

function reboot()
{
    Restart-Computer
}

function shutdown()
{
    Stop-Computer
}

function head($path, $lines = 10)
{
    Get-Content $path | Select-Object -First $lines
}

function x($path = ".")
{
    explorer $path
}

function unzip {
    #    expand in smae directory
    Expand-Archive -Path $args[0] -DestinationPath .
}

function zip {
    # compress in same directory
    Compress-Archive -Path $args[0] -DestinationPath "$($args[0]).zip"
}

function unzipr {
    # expand in same directory and remove zip
    Expand-Archive -Path $args[0] -DestinationPath .
    Remove-Item $args[0]
}

function zipr {
    # compress in same directory and remove original
    Compress-Archive -Path $args[0] -DestinationPath "$($args[0]).zip"
    Remove-Item $args[0]
}

function Get-PubIP {
    (Invoke-WebRequest http://ifconfig.me/ip ).Content
}

# go to a directory even in path is a file.
function gotodir($dir) {
	if ((get-item $dir -erroraction silentlycontinue ) -is [system.io.directoryinfo]) {
		cd $dir
	} else {
		cd (split-path -path $dir)
	}
}

# find files by filename
function find-file($name) {
        Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
                $place_path = $_.directory
                Write-Output "${place_path}\${_}"
        }
}

# ------------------------------Aliases------------------------------
set-alias -name gd -value gotodir
set-alias -name ff -value find-file

# Set UNIX-like aliases for the admin command, so sudo <command> will 
# run the command with elevated rights.
Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin
