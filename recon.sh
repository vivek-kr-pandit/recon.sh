#!/bin/bash

####################################
#######hashtag#Color output ###############
RESET="\e[0m"
GRAY="\e[1;30m"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
PURPLE="\e[1;35m"
CYAN="\e[1;36m"
WHITE="\e[1;37m"

#################################### functions ##############################

banner () {
 clear

echo -e "${PURPLE}======================================================${RESET}"
echo -e "${RED} ____                            _     ${RESET}"
echo -e "${RED}|  _ \ ___  ___ ___  _ __    ___| |__${RESET}"  
echo -e "${RED}| |_) / _ \/ __/ _ \| '_ \  / __| '_ \ ${RESET}"
echo -e "${RED}|  _ <  __/ (_| (_) | | | |_\__ \ | | |${RESET}"
echo -e "${RED}|_| \_\___|\___\___/|_| |_(_)___/_| |_|${RESET}"
divider
}



divider () {
 echo 
 echo -e "${PURPLE}======================================================${RESET}"
 echo
}

help () {
 clear
 banner
 echo 
 echo -e "USAGE:$0 [DOMAIN...] [OPTIONS...]"
 echo -e "\t-d , --domain Domain name"
 echo -e "\t-h , --help Help menu"
 echo -e "\t-hx , --httpx Get live domains"
 echo -e "\t-u , --urls Get all the urls"
 echo -e "\t-p , --parameter Get paameter"
 echo -e "\t-w , --wayback Get wayback data"
 echo -e "\t-ps , --portscan Get Port Scanning"
 echo -e "\t-a , --all For full enumeration"

}
############################### Variables ###################################

DOMAIN=$2

if [ $# -eq 0 ]  
then
 help
 exit 1
fi

if ! [ -d "$DOMAIN" ]
then
 mkdir $DOMAIN
 cd $DOMAIN
else
 echo -e "${RED}Diretory already exists.....Exiting.......${RESET}"
 exit 2
fi


##################### case #####################

while [ $# -gt 0 ] 
do
 case "$1" in
 "-h" | --help )
 help
 exit 4
 ;;


 "-d" | "--domain" )
 banner
 echo -e "${BLUE}[-] Gathering Sub-domains from Internet.....${RESET}"
 subfinder -silent -d $DOMAIN >> sub_domains.txt
 assetfinder $DOMAIN >> sub_domains.txt

 VALID_DOMAINS=`cat sub_domains.txt | sort -u`

 echo
 echo "$VALID_DOMAINS" | tee sub-domains.txt
 echo
 echo -e "${GREEN}[+] Subdomain Gathering Completed...${RESET}"
 rm sub_domains.txt
 divider
 shift
 shift
 ;;
  
  
 "-hx" | "--httpx" )
 echo -e "${BLUE}[-] Running httpx...${RESET}" 
 cat sub-domains.txt | httpx | tee live_domain.txt
 echo -e "${GREEN}[+] Live Sub-domains Gathered.........${RESET}"
 divider 
 shift
 shift
 ;;

 "-u" | "--url" )
 echo -e "${BLUE}[-] Gathering URL from gau.....${RESET}"
 gau $DOMAIN | tee urls.txt
 echo -e "${GREEN}[+] URLS Gathered......${RESET}"
 divider
 shift
 shift
 ;;


 "-w" | "--wayback" )
 echo -e "${BLUE}[-] Gathering Wayback Data ...${RESET}"
 waybackurls $DOMAIN | tee waybackurls.txt
 echo -e "${GREEN}[+] Waybackurl Gathered...${RESET}"
 divider
 shift
 shift
 ;;
 
 "-ps" | "--portscan" )
 echo -e "${BLUE}[-] Scanning for Open Ports ...${RESET}"
 naabu -silent -host $DOMAIN | tee openport.txt
 echo -e "${GREEN}[+] Scanning is Completed ...${RESET}"
 divider
 shift
 shift
 ;;
 
 "-a" | "--all" )
 banner

 echo -e "${BLUE}[-] Running Full Recon Workflow...${RESET}"

 # Subdomain Enumeration
 echo -e "${BLUE}[-] Gathering Sub-domains...${RESET}"
 subfinder -silent -d $DOMAIN >> sub_domains.txt
 assetfinder $DOMAIN >> sub_domains.txt
 cat sub_domains.txt | sort -u | tee sub-domains.txt
 rm sub_domains.txt
 echo -e "${GREEN}[+] Subdomains Done${RESET}"
 divider

 # Live Domains
 echo -e "${BLUE}[-] Running httpx...${RESET}"
 cat sub-domains.txt | httpx | tee live_domain.txt
 echo -e "${GREEN}[+] Live Domains Done${RESET}"
 divider

 # URLs
 echo -e "${BLUE}[-] Gathering URLs...${RESET}"
 gau $DOMAIN | tee urls.txt
 echo -e "${GREEN}[+] URLs Done${RESET}"
 divider

 # Wayback
 echo -e "${BLUE}[-] Gathering Wayback Data...${RESET}"
 waybackurls $DOMAIN | tee waybackurls.txt
 echo -e "${GREEN}[+] Wayback Done${RESET}"
 divider

 # Port Scan
 echo -e "${BLUE}[-] Scanning Ports...${RESET}"
 naabu -silent -host $DOMAIN | tee openport.txt
 echo -e "${GREEN}[+] Port Scan Done${RESET}"
 divider

 echo -e "${GREEN}[+] Full Recon Completed 🚀${RESET}"

 shift
 shift
 ;;
 esac
done 
#################################################################

echo -e "${BLUE} RECON COMPLETED ...${RESET}"

