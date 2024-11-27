# Event Log collector

A quick reference describing how to collect parent process info.
Often administrators wonder what launched a specific process (or whom) and that way it will be noted down on a host with a registered custom event filter.

Script contains both registration and deregistration routines.


## License

[GPL 3](LICENSE)


## Tech Stack

**Client:** PowerShell 5.1 or higher, (attached example contains both methods, please open it in powershell_ISE - luckily it is still part of PoSh 5 component on Windows OSes 10+)

**Server:** (Same conditions as for workstations)

## Scripts

[Register-WmiEvent](code/Register-WmiEvent.ps1)

[Unregister-Event](code/Unregister-Event.ps1)

Good luck implementing it in your own scripts/tools.\
[Andrzej Demski](https://github.com/AndrewDemski-ad-gmail-com)


_P.S.
In the meantime I will try to prepare some code analysis on GH which will be a tremendouns help in future development._

[![DevSkim](https://github.com/AndrewDemski-ad-gmail-com/eventcollector/actions/workflows/devskim.yml/badge.svg?branch=main)](https://github.com/AndrewDemski-ad-gmail-com/eventcollector/actions/workflows/devskim.yml)
