# 🔎 Recon Automation Script

Turn a domain into an attack surface map in seconds.

A lightweight Bash-based reconnaissance tool designed for bug bounty hunters and penetration testers. This script automates subdomain enumeration, live host detection, URL gathering, wayback data extraction, and port scanning into a single streamlined workflow.

---

## 🚀 Features

- 🔍 Subdomain Enumeration (subfinder, assetfinder)
- 🌐 Live Domain Detection (httpx)
- 🔗 URL Collection (gau)
- 🕰️ Wayback Data Extraction (waybackurls)
- 🚪 Port Scanning (naabu)
- ⚡ Full Automated Recon Mode (`-a` flag)

---

## 📦 Requirements

Make sure the following tools are installed:

- subfinder
- assetfinder
- httpx
- gau
- waybackurls
- naabu

---

## ⚙️ Installation

```bash
git clone https://github.com/vivek-kr-pandit/recon.sh
cd recon.sh
chmod +x recon.sh
```

## Usage
```
./recon.sh -d target.com --all
```
