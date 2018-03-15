#! /bin/bash
LABEL="/home/mw/Downloads/zebra/"     

inotifywait -m -e create $LABEL |
while read -r  events filename; do
   if [[ "$filename" == *pdf ]]
   then
      lp $LABEL*.pdf -d Zebra_Printer && find $LABEL -name "*.pdf" -delete
      echo true
   else
      echo false
   fi
   #echo $filename
   #echo $filename
done
