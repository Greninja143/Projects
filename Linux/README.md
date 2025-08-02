🔍 What This Script Does

This script extracts the following artifacts:

| Section                | Description                                        |
| ---------------------- | -------------------------------------------------- |
| **System Info**        | OS version, kernel, uptime, mounted file systems   |
| **Accounts**           | Users, groups, shadow file, login history          |
| **Processes/Services** | Running tasks and background services              |
| **Scheduled Tasks**    | User crontabs                                      |
| **Network**            | Interfaces, routing table, connections, open ports |
| **Installed Packages** | `dpkg -l` or `rpm -qa` depending on distro         |
| **Histories**          | `.bash_history` and `.ssh/` per user               |
| **Logs**               | Copies all log files from `/var/log`               |
| **SUID/SGID Files**    | Potential privilege escalation binaries            |
| **Recent Files**       | Changes in the last 5 days (you can adjust)        |

