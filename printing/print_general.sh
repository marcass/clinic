#! /bin/bash

# Printer variabls. To check names (if CUPS running) go to http://localhost:631
LABEL="Zebra"
A4="Brother_MFC_L2770DW_series"

# Create a service unit in /etc/systemd/user/
# 
# 
# [Unit]
# Description=Printing service for ezyvet docs

# [Service]
# Type=simple
# ExecStart=/bin/bash -c "/home/mw/git//clinic/printing/print_general.sh"

# [Install]
# WantedBy=default.target

# 
# 

# start service by systemctl --user start ezyvet_doc_printing.service

# Make sure this directory exists and create if it doesn't
DOC="$HOME/Downloads/printing/"
mkdir -p $DOC

if [ -d "$DOC" ]; then
   echo "'$DOC' found and now copying files, please wait ..."
else
   echo "Warning: '$DOC' NOT found, creating $DOC."
   mkdir $DOC
fi

inotifywait -m -e create $DOC |
while read -r  events filename; do
    # ensure docs are pdf's
    if [[ "$filename" == *pdf ]]
    then
        FILE=`ls $DOC`
        SIZE=`pdfinfo $DOC/$FILE | grep pts | awk '{print $3}'`
        if [[ $SIZE < 400 ]]
        then
            lp $DOC/*.pdf -d $LABEL && find $DOC -name "*.pdf" -delete
            echo "printing label"
        else
            lp $DOC/*.pdf -d $A4 && find $DOC -name "*.pdf" -delete
            echo "printing doc"
        fi
    else
      echo "something went wrong with printing"
   fi
done
