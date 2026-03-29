# server-stats
# Server Performance Stats

A bash script to analyse basic server performance stats.

## Project URL
https://roadmap.sh/projects/server-stats

## Features
- Total CPU usage
- Total memory usage (Free vs Used with percentage)
- Total disk usage (Free vs Used with percentage)
- Top 5 processes by CPU usage
- Top 5 processes by memory usage
- Bonus: OS info, uptime, logged-in users, failed logins

## How to run
```bash
chmod +x server-stats.sh
./server-stats.sh
```

## Requirements
- Linux (Ubuntu/Debian)
- bash, bc, ps, df, free, top
