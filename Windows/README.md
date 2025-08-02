🔍 What This Script Does

This script extracts the following artifacts:

| Section               | Artifacts                                                            |
| --------------------- | -------------------------------------------------------------------- |
| 🔧 System Info        | Hostname, OS, timezone, boot time                                    |
| 👤 User Info          | All accounts, last logins, SID list                                  |
| 🧾 Registry Hives     | Copy SAM, SYSTEM, SOFTWARE for offline analysis                      |
| ⚙️ Autoruns           | Startup folders + registry autorun keys                              |
| 💾 Services & Drivers | List of services, drivers                                            |
| 📋 Processes          | Running processes + command line                                     |
| 🌐 Network            | Netstat, IP config, DNS cache                                        |
| 📚 Logs               | Export `.evtx` files                                                 |
| 📁 Browser Data       | History for Chrome and Firefox                                       |
| 📦 Installed Apps     | Via registry and `wmic`                                              |
| 🔍 Other              | Prefetch files, RecentDocs, USB history (offline via registry), etc. |

