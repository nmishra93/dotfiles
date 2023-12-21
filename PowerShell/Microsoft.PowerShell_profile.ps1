# Configure oh-my-posh with a specific theme
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\stelbent-compact.minimal.omp.json" | Invoke-Expression

# Import the Terminal-Icons module for enhanced icons in the terminal
Import-Module -Name Terminal-Icons

# Quick shortcut to start Notepad
function n { notepad $args }

# Function to start a new elevated process
# If arguments are supplied, a single command is started with admin rights
# If no arguments, a new admin instance of PowerShell is started
function admin {
    if ($args.Count -gt 0) {   
        $argList = "& '" + $args + "'"
        Start-Process "$psHome\pwsh.exe" -Verb runAs -ArgumentList $argList
    } else {
        Start-Process "$psHome\pwsh.exe" -Verb runAs
    }
}

# Shortcut to list files in the current directory
function ll { Get-ChildItem -Path $pwd -File }

# Shortcuts to navigate to specific directories and open them in VS Code
function g { Set-Location $HOME\Documents\Github }
function tt { Set-Location "$HOME\Documents\tidytuesday"; code . }
function da { Set-Location "$HOME\Documents\Data Analysis"; code . }
function bli { Set-Location "$HOME\OneDrive - Scripps Research\Desktop Files\Data Analysis\BLI"; code . }

# Shortcuts to open the current directory in VS Code
function c { code . }

# Git-related functions
function gcom {
    git add .
    git commit -m "$args"
}

function lazyg {
    git add .
    git commit -m "$args"
    git push
}

# Function to create an empty file
function touch($file) {
    "" | Out-File $file -Encoding ASCII
}

# Function to find the executable location of a command
function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}

# Recursive force removal of a directory
function rmrf($path) {
    Remove-Item $path -Recurse -Force
}

# Remove a file or directory
function rm($path) {
    Remove-Item $path
}

# Move a file or directory to a new destination
function mv($path, $dest) {
    Move-Item $path $dest -Force -Recurse
}

# Copy a file or directory to a new destination
function cp($path, $dest) {
    Copy-Item $path $dest -Force -Recurse
}

# Reboot the computer
function reboot() {
    Restart-Computer
}

# Shutdown the computer
function shutdown() {
    Stop-Computer
}

# Display the first n lines of a file
function head($path, $lines = 10) {
    Get-Content $path | Select-Object -First $lines
}

# Open File Explorer at a specific path
function x($path = ".") {
    explorer $path
}

# Functions for working with zip and unzip operations
function unzip {
    # Expand the archive in the same directory
    Expand-Archive -Path $args[0] -DestinationPath .
}

function zip {
    # Compress the archive in the same directory
    Compress-Archive -Path $args[0] -DestinationPath "$($args[0]).zip"
}

function unzipr {
    # Expand the archive in the same directory and remove the original zip file
    Expand-Archive -Path $args[0] -DestinationPath .
    Remove-Item $args[0]
}

function zipr {
    # Compress the archive in the same directory and remove the original files
    Compress-Archive -Path $args[0] -DestinationPath "$($args[0]).zip"
    Remove-Item $args[0]
}

# Function to get the public IP address using an external service
function Get-PubIP {
    (Invoke-WebRequest http://ifconfig.me/ip).Content
}

# Function to navigate to a directory even if the path is a file
function gotodir($dir) {
    if ((Get-Item $dir -ErrorAction SilentlyContinue) -is [System.IO.DirectoryInfo]) {
        cd $dir
    } else {
        cd (Split-Path -Path $dir)
    }
}

# Function to find files by filename
function find-file($name) {
    Get-ChildItem -Recurse -Filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        $place_path = $_.Directory
        Write-Output "${place_path}\${_}"
    }
}

# Aliases for commonly used commands
set-alias -name gd -value gotodir
set-alias -name ff -value find-file
Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin
