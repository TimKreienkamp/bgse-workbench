#!/bin/bash

# installion script

PATH=$PATH:/usr/local/mysql/bin

cmd=$1

user=`grep dbuser service.conf | cut -f2 -d' '`
pswd=`grep dbpswd service.conf | cut -f2 -d' '`

case $cmd in

install)
	echo "Installing"

	mysql -u $user -p$pswd < db/stackexchange.sql
	

	mkdir -p "$HOME/Sites/MyApp"
	cp -rf web/* "$HOME/Sites/MyApp"

	echo "done!"
	;;

uninstall)
	echo "Uninstalling"
	
	mysql -u $user -p$pswd -e "DROP DATABASE ecommerce;" 
	rm -rf "$HOME/Sites/MyApp"

	echo "done!"
	;;

*)
	echo "Unknown Command!"

esac
