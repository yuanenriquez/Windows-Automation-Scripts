# Windows System Automation & Process Management

A collection of personal Windows batch scripts and PowerShell helpers for automating software installation, scheduled-task management, process control, configuration-file changes, file handling, and monitor controls.

These scripts were built to reduce repetitive steps in a specific local Windows setup. They are personal automation utilities, not a general-purpose deployment or network-management platform.

## Configuration & Usage Note

Several scripts contain hardcoded paths (for example, directories under `C:\\C_Softwares\\...`) that match my own storage setup. Before using them on another machine, review the scripts and update any paths, application names, or scheduled-task names to match that environment.

Some scripts also require administrator privileges.

## Scripts & Capabilities

### 1. Mudfish Installer Automation — `Update mudfish.bat`

- Scans the Downloads folder for a matching Mudfish installer.
- Stops relevant running processes before installation.
- Runs the installer silently using a custom installation directory.
- Removes the downloaded installer after the installation process.

This automates the installer workflow; it does not independently configure network routes.

### 2. Scheduled-Task Control — `Suspend Mudfish For Replays.bat`

- Checks for administrator privileges and requests elevation when needed.
- Uses Windows Task Scheduler commands to disable or re-enable selected scheduled tasks associated with Mudfish.
- Uses interactive input to control when those tasks are toggled.

### 3. Steam Configuration Update — `Static Steam In Tray.bat`

- Uses PowerShell text replacement to update selected offline-mode settings in Steam's local `loginusers.vdf` file.
- Launches Steam after updating the configuration.

### 4. Downloaded File Renaming — `Auto-Rename and Execute Gemini Script.bat`

- Searches the Downloads folder for matching Gemini-generated text or batch files.
- Reads a title from the file content and sanitizes invalid Windows filename characters.
- Renames the file and provides options to open the Downloads folder or run a batch file.

### 5. Monitor Controls — `DIM.bat` and `OFF.bat`

- Uses Windows Management Instrumentation (WMI) to change monitor brightness where supported.
- Uses Windows API calls through PowerShell to send a monitor power-off message.
- Includes a keyboard-state check in the brightness script for its restore interaction.

### 6. Configuration File Attribute Toggle — `LoL config toggle.bat`

- Checks and toggles the Read-only attribute on selected game configuration files.
- Writes execution information to a local log file.

### 7. Process Termination — `Close RIiot and LoL.bat`

- Uses `taskkill` to terminate selected Riot and League of Legends processes, including related background processes and crash handlers.

## Scope

These scripts demonstrate practical Windows batch scripting, command-line operations, PowerShell usage, process management, scheduled-task control, file manipulation, and basic Windows management API interaction. They were created for my own environment and should be reviewed before use on another system.
