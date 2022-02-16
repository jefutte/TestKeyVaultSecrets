#!/bin/bash

AZPATH=$(/bin/which az)
TFPATH=$(/bin/which terraform)
MYIP=$(/bin/wget -qO - icanhazip.com)

display_usage() { 
    echo -e "\nThis script is used for allowing or denying your public IP access to Storage Account."
    echo -e "\nThis script needs two (2) parameters."
    echo -e "\n     1. Allow (allow) or Deny (deny) your public IP."
    echo -e "\n     2. Sandbox or Prod."
    echo -e "\nUsage: $0 allow sandbox \n" 
}

if [ $# -lt 2 ] || [ $# -ge 3 ]
	then 
	  display_usage
	exit 1
fi


case $2 in

	sandbox | Sandbox)
		"$AZPATH" account set -s "CIMT-Test-Sandbox"
		RG=AKUT-D-Hjertestopregister-rg ;
		STG=akutdwehjertestopregstg ;
		;;

	prod | Prod)
		"$AZPATH" account set -s "Akut-Prod-Hjertestopregister"
		RG=AKUT-P-Hjertestopregister-rg ;
		STG=akutpwehjertestopregstg ;
		;;
	
	*)
		echo "Usage 'sandbox|Sandbox' or 'prod|Prod'"
		exit 1
esac

case $1 in

	allow | Allow)
		az storage account network-rule add --resource-group "$RG" --account-name $STG --ip-address "$MYIP" > /dev/null
		echo -e "Your Public IP ""$MYIP"", has been allowed access to ""$STG""\n"
		;;

	deny | Deny)
		az storage account network-rule remove --resource-group "$RG" --account-name $STG --ip-address "$MYIP" > /dev/null
		echo "Your Public IP ""$MYIP"", has been denied access to ""$STG""\n"
		;;
	
	*)
		echo "Usage 'deny|Deny' or 'allow|Allow'"
		exit 1
esac
