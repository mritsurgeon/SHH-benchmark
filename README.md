# SHH-benchmark
PowerShell Script that Tests SSH connection Performance

## PowerShell Script for Testing SSH Latency 

This PowerShell script tests the average SSH latency to a target machine by performing 5 SSH connections and running the command `ls /home` on each connection to check connectivity.

### Prerequisites

- Putty must be installed.
- Ensure the path to `plink.exe` is correct: `'C:\Program Files\PuTTY\plink.exe'`.

### Usage

1. Set the following variables in the script:
   ```powershell
   $username = "user"
   $hostname = "Server"
   $password = "Pass123"

Replace $username, $hostname, and $password with your specific SSH credentials and server details. 

### Run
   ```powershell
   .\SSH-Benchmark.ps1

This script provides insights into the average SSH connection latency, useful for performance testing and benchmarking purposes.

### Screenshot

![image](https://github.com/mritsurgeon/SHH-benchmark/assets/59644778/e8515e8a-bfb4-46d6-a5a6-8f83c8311340)
