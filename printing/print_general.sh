#! /bin/bash

# Make sure this directory exists
DOC="/home/mw/Downloads/printing/"

inotifywait -m -e create $DOC |
while read -r  events filename; do
    # ensure docs are pdf's
    if [[ "$filename" == *pdf ]]
    then
        FILE=`ls $DOC`
        SIZE=`pdfinfo $DOC/$FILE | grep pts | awk '{print $3}'`
        if [[ $SIZE < 400 ]]
        then
            lp $DOC/*.pdf -d Zebra && find $DOC -name "*.pdf" -delete
            echo "printing label"
        else
            lp $DOC/*.pdf -d MC342 && find $DOC -name "*.pdf" -delete
            echo "printing doc"
        fi
    else
      echo "something went wrong with printing"
   fi
done