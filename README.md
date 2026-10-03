# Windows System Automation & Process Management

A suite of custom Windows batch scripts and PowerShell wrappers engineered to automate local network routing, manage nested background processes, and handle dynamic file operations. 

These tools were built to solve specific operational bottlenecks, optimize system resources, and eliminate redundant manual configurations.

## ⚙️ Configuration & Deployment Note
This repository reflects a live local environment. Several scripts (such as `Update mudfish.bat` and `Static Steam In Tray.bat`) contain hardcoded directory paths (e.g., `C:\C_Softwares\...`) designed for a specific custom storage architecture. 

**To deploy these scripts on a new local machine, you must open them in a text editor and update the directory variables to match your own system's target paths.**

## 🛠️ Core Scripts & Capabilities

### 1. Automated Software Deployment (`Update mudfish.bat`)
*   **Function:** Automates the silent installation and updating of network routing software.
*   **Logic:** Scans the `Downloads` directory for specific installer patterns, uses `taskkill` to forcefully terminate conflicting background processes, executes a silent background installation to a custom directory, and deletes the leftover installer.

### 2. Task Scheduler & Privilege Escalation (`Suspend Mudfish For Replays.bat`)
*   **Function:** Dynamically toggles specific Windows Task Scheduler rules to suspend network routing during safe periods.
*   **Logic:** Checks for administrative privileges and requests elevation if missing. Uses `schtasks` to disable and re-enable specific network tasks based on interactive user keystrokes.

### 3. Static Configuration Injection (`Static Steam In Tray.bat`)
*   **Function:** Automates application launch parameters and forces offline modes.
*   **Logic:** Utilizes PowerShell wrappers to inject string replacements directly into local `.vdf` configuration files to manipulate software variables before execution, then launches the application silently.

### 4. File Operation & String Sanitization (`Auto-Rename and Execute Gemini Script.bat`)
*   **Function:** A dynamic file management workflow that extracts internal metadata to rename files automatically.
*   **Logic:** Scans directories by date, parses internal text files line-by-line to extract specific title strings, sanitizes the output to remove invalid Windows characters, prevents overwrite errors with random number generation, and provides an interactive UI.

### 5. Hardware API Manipulation (`DIM.bat` & `OFF.bat`)
*   **Function:** Controls physical display states directly from the command line.
*   **Logic:** Uses PowerShell wrappers to hook into the Windows API (`user32.dll`) and WMI (Windows Management Instrumentation) objects to instantly power off monitors or manipulate brightness levels globally.

### 6. File Attribute Management (`LoL config toggle.bat`)
*   **Function:** Locks and unlocks application configuration files to prevent unwanted overwrites.
*   **Logic:** Evaluates current file states and dynamically toggles the Read-Only (`+r`/`-r`) attributes on target JSON and CFG files, outputting execution logs to a localized `.log` file.

### 7. Process Termination (`Close RIiot and LoL.bat`)
*   **Function:** forcefully cleans up nested background processes.
*   **Logic:** Uses `taskkill` to terminate multiple hidden application layers and crash handlers simultaneously to free up system resources.
