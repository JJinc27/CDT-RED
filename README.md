# ExploreKills Script
This PowerShell script is designed to create a disruptive environment on a Windows machine. It continuously kills explorer.exe, closes the Task Manager (taskmgr.exe), and minimizes all open windows except for Notepad. Notepad will periodically display a banner text reading `NO MORE DESKTOP`.

## Features
* Kills explorer.exe every 20 seconds: This will terminate and restart Windows Explorer, disrupting the normal desktop environment.

* Closes Task Manager (taskmgr.exe) every 6 seconds: This prevents users from manually stopping the script.

* Minimizes all open windows except for Notepad: This minimizes all applications, including PowerShell, with the exception of Notepad, which displays a banner.

* Displays a banner in Notepad: A custom banner text is displayed reading `NO MORE DESKTOP`.

## Requirements
Windows Server 2016

PowerShell with ExecutionPolicy set to Bypass

Administrator privileges to kill system processes like explorer.exe and taskmgr.exe

## How to Use
### Step 1: Download the Script
Download the script explorekills.ps1 and place it in a directory of your choosing.
I picked C:\Users\Public\Libraries as it is a hidden folder by default.

### Step 2: Run the Script
Open PowerShell as Administrator.

Execute the script with the following command:
`powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File C:\Users\Public\Libraries\explorekills.ps1`
* `-WindowStyle Hidden` ensures that the PowerShell window does not appear when the script is running.

* `-ExecutionPolicy Bypass` allows the script to bypass the default execution policy and run without restrictions.

### Step 3: The Script Will Start Running
The script will begin closing windows, killing explorer.exe every 20 seconds, and closing Task Manager every 6 seconds.

Notepad will display the banner text continuously.

## Stopping the Script
As of the current version, the only way to stop the script is open Task Manager and end the PowerShell process (powershell.exe) in the given time window or restart the targeted machine
