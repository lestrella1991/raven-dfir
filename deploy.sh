#!/usr/bin/env bash

# Colors
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
PURPLE='\e[35m'
CYAN='\e[36m'
RESET='\e[0m'

#Project variables
wd="<PATH/TO/PROJECT/ROOT>"

#Functions

sc_print (){
    # Function for reusing print on screen
    echo -e "\n${YELLOW}[+]${RESET}${2} $1${RESET}" >&2
}

# Get environment variables values

#echo -e "${YELLOW}[+]${RESET}${GREEN}Setting environment variables...${RESET}" >&2
sc_print "Setting environment variable..." "$PURPLE"


# Script execution for getting values
eval "$(bash ./getEnv.sh)" || exit 1

# Deploy Terraform on proxmox

sc_print "Deploying infrastructure for Kubernetes RKE2 cluster..." "$PURPLE"

#Changing to terraform WD

cd $wd/terraform

sc_print "Initializing..." "$PURPLE"

# initiating terraform

terraform init

# Deploying terraform

sc_print "Deploying infrastructure..." "$PURPLE"

terraform plan

terraform apply -auto-approve 

sc_print "Infrastructure deployed..." "$GREEN"

# Changing to ansible dir
cd $wd/ansible

sc_print "Initializing autoconfig..." "$BLUE"

ansible-playbook -v -i ./inventory.ini ./playbook.yml >&2


