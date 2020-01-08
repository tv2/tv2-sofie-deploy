#!/bin/bash

PS3='Please enter your choice: '
options=("Deploy All" "Deploy Core" "Deploy iNewsGateway" "Deploy Playout Gateway" "Deploy Sisyfos" "Deploy Blueprints" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Deploy All")
			echo "Starting $REPLY"
            echo "Deploying Core :"
            sudo -E bash deploy-core.sh
            echo "Deploying Playout Gateway :"
			sudo -E bash deploy-playout-gateway.sh
            echo "Deploying iNews Gateway :"
			sudo -E bash deploy-inews-gateway.sh
            echo "Deploying Blueprints :"
			sudo -E bash deploy-blueprints.sh
            echo "Deploying Sisyfos :"
			sudo -E bash deploy-sisyfos.sh
            echo "Sofie Deployed - check status by open browser http://core.machine.ip:3000"
            break
            ;;
		"Deploy Core")
            echo "Starting $REPLY"
            echo "Deploying Core :"
            sudo -E bash deploy-core.sh
            break
            ;;
        "Deploy iNewsGateway")
            echo "Starting $REPLY"
            echo "Deploying iNews Gateway :"
            sudo -E bash deploy-inews-gateway.sh
            break
            ;;
        "Deploy Playout Gateway")
            echo "Deploying Playout Gateway :"
            echo "Starting $REPLY"
			sudo -E bash deploy-playout-gateway.sh
            break
            ;;
        "Deploy Blueprints")
            echo "Starting $REPLY"
            echo "Deploying Blueprints :"
            sudo -E bash deploy-blueprints.sh
            break
            ;;
		"Deploy Sisyfos")
            echo "Starting $REPLY"
            echo "Deploying Sisyfos :"
            sudo -E bash deploy-sisyfos.sh
            break
            ;;
        "Quit")
            echo "Quit menu.sh"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

echo "Finished operation"