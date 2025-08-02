#!/bin/bash

OUTPUT_DIR="LiveLinux_Forensic_Artifacts_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTPUT_DIR"

function save_cmd_output {
    echo "[*] Collecting: $1"
    eval "$2" > "$OUTPUT_DIR/$1.txt" 2>/dev/null
}

echo "[*] Starting forensic collection from live system..."

# 1. System Info
save_cmd_output "system_info" "hostnamectl; uname -a; uptime"
save_cmd_output "disk_usage" "df -h"
save_cmd_output "mounted_filesystems" "mount"

# 2. User Accounts
save_cmd_output "passwd_file" "cat /etc/passwd"
save_cmd_output "group_file" "cat /etc/group"
save_cmd_output "shadow_file" "sudo cat /etc/shadow"
save_cmd_output "login_history" "lastlog; last -a"

# 3. Processes and Services
save_cmd_output "running_processes" "ps aux"
save_cmd_output "open_files" "lsof"
save_cmd_output "services" "systemctl list-units --type=service"

# 4. Scheduled Tasks
save_cmd_output "crontab_all_users" "for user in \$(cut -f1 -d: /etc/passwd); do echo \"# \$user\"; crontab -u \$user -l 2>/dev/null; done"

# 5. Network Info
save_cmd_output "network_interfaces" "ip a"
save_cmd_output "routing_table" "ip route"
save_cmd_output "open_ports" "ss -tuln"
save_cmd_output "connections" "netstat -antup"

# 6. Installed Software
if command -v dpkg &>/dev/null; then
    save_cmd_output "installed_packages" "dpkg -l"
elif command -v rpm &>/dev/null; then
    save_cmd_output "installed_packages" "rpm -qa"
fi

# 7. Bash History and SSH Keys
mkdir -p "$OUTPUT_DIR/bash_history" "$OUTPUT_DIR/ssh_keys"
for user_dir in /home/* /root; do
    if [ -d "$user_dir" ]; then
        user=$(basename "$user_dir")

        if [ -f "$user_dir/.bash_history" ]; then
            cp "$user_dir/.bash_history" "$OUTPUT_DIR/bash_history/${user}_bash_history.txt"
        fi

        if [ -d "$user_dir/.ssh" ]; then
            mkdir -p "$OUTPUT_DIR/ssh_keys/$user"
            cp -r "$user_dir/.ssh"/* "$OUTPUT_DIR/ssh_keys/$user/" 2>/dev/null
        fi
    fi
done

# 8. System Logs
mkdir -p "$OUTPUT_DIR/system_logs"
cp -r /var/log/* "$OUTPUT_DIR/system_logs/" 2>/dev/null

# 9. SUID & SGID Files
save_cmd_output "suid_files" "find / -perm -4000 -type f 2>/dev/null"
save_cmd_output "sgid_files" "find / -perm -2000 -type f 2>/dev/null"

# 10. Recent Modifications (last 5 days)
save_cmd_output "recently_modified_files" "find / -type f -mtime -5 2>/dev/null"

echo "[+] All artifacts saved to: $OUTPUT_DIR"
