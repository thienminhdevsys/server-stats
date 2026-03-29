#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

print_header() {
    echo -e "\n${CYAN}${BOLD}════════════════════════════════════${RESET}"
    echo -e "${CYAN}${BOLD}  $1${RESET}"
    echo -e "${CYAN}${BOLD}════════════════════════════════════${RESET}"
}

# ── OS Info ──────────────────────────────
print_header "SYSTEM INFORMATION"
echo -e "  OS       : $(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)"
echo -e "  Hostname : $(hostname)"
echo -e "  Uptime   : $(uptime -p)"
echo -e "  Load avg : $(uptime | awk -F'load average:' '{print $2}')"

# ── CPU ──────────────────────────────────
print_header "CPU USAGE"
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | tr -d '%us,')
CPU_USED=$(echo "100 - $CPU_IDLE" | bc)
echo -e "  Used     : ${YELLOW}${CPU_USED}%${RESET}"
echo -e "  Idle     : ${GREEN}${CPU_IDLE}%${RESET}"

# ── Memory ───────────────────────────────
print_header "MEMORY USAGE"
MEM_TOTAL=$(free -m | awk 'NR==2{print $2}')
MEM_USED=$(free -m  | awk 'NR==2{print $3}')
MEM_FREE=$(free -m  | awk 'NR==2{print $4}')
MEM_PCT=$(echo "scale=1; $MEM_USED * 100 / $MEM_TOTAL" | bc)
echo -e "  Total    : ${MEM_TOTAL} MB"
echo -e "  Used     : ${YELLOW}${MEM_USED} MB (${MEM_PCT}%)${RESET}"
echo -e "  Free     : ${GREEN}${MEM_FREE} MB${RESET}"

# ── Disk ─────────────────────────────────
print_header "DISK USAGE"
df -h | awk 'NR>1 {printf "  %-20s Used:%-6s Free:%-6s (%s)\n",$6,$3,$4,$5}'

# ── Top 5 CPU ────────────────────────────
print_header "TOP 5 PROCESSES BY CPU"
printf "  ${BOLD}%-10s %-8s %-8s %s${RESET}\n" "USER" "PID" "CPU%" "COMMAND"
ps aux --sort=-%cpu | awk 'NR>1 && NR<=6 {printf "  %-10s %-8s %-8s %s\n",$1,$2,$3,$11}'

# ── Top 5 Memory ─────────────────────────
print_header "TOP 5 PROCESSES BY MEMORY"
printf "  ${BOLD}%-10s %-8s %-8s %s${RESET}\n" "USER" "PID" "MEM%" "COMMAND"
ps aux --sort=-%mem | awk 'NR>1 && NR<=6 {printf "  %-10s %-8s %-8s %s\n",$1,$2,$4,$11}'

# ── Bonus ────────────────────────────────
print_header "ADDITIONAL INFO"
echo -e "  Logged in users  : $(who | wc -l)"
echo -e "  Failed logins    : $(grep -c 'Failed password' /var/log/auth.log 2>/dev/null || echo 0)"
echo -e "\n${GREEN}  ✓ Generated at: $(date '+%Y-%m-%d %H:%M:%S')${RESET}\n"
