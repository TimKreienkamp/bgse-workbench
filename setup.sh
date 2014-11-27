#!/bin/bash

# installion script

cmd=$1

user=`grep dbuser service.conf | cut -f2 -d' '`
pswd=`grep dbpswd service.conf | cut -f2 -d' '`

case $cmd in

install)
	echo "Installing"

	mysql -u $user -p$pswd < db/ecommerce.sql
	mysql -u $user -p$pswd < data/ecommerce-dump.sql

	mkdir -p "$HOME/Sites/MyApp"
	cp -rf web/* "$HOME/Sites/MyApp"

	echo "done!"
	;;

uninstall)
	echo "Uninstalling"
	
	mysql -u $user -p$pswd -e "DROP DATABASE ecommerce;" 
	rm -rf "$HOME/public_html/MyApp"

	echo "done!"
	;;

*)
	echo "Unknown Command!"

esac
