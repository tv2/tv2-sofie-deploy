#!/bin/bash
# Bash Menu Script Example

PS3='Please enter your choice: '
options=("Deploy All" "Deploy Core" "Deploy iNewsGateway" "Deploy Playout Gateway" "Deploy Sisyfos" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Deploy All")
			echo "Starting $REPLY"
            sudo bash deploy-core.sh
			sudo bash deploy-playout-gateway.sh
			sudo bash deploy-inews-gateway.sh
			sudo bash deploy-sisyfos.sh
            ;;
		"Deploy Core")
            echo "Starting $REPLY"
            sudo bash deploy-core.sh
            ;;
        "Deploy iNewsGateway")
            echo "Starting $REPLY"
            sudo bash deploy-inews-gateway.sh
            ;;
        "Deploy Playout Gateway")
            echo "Starting $REPLY"
			sudo bash deploy-playout-gateway.sh
            ;;
		"Deploy Sisyfos")
            echo "Starting $REPLY"
            sudo bash deploy-sisyfos.sh
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done