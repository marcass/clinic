#! /bin/bash
DOC="/home/mw/Downloads/lexmark/"     

inotifywait -m -e create $DOC |
while read -r  events filename; do
   if [[ "$filename" == *pdf ]]
   then
      lp $DOC/*.pdf -d Lexmark_E360dn && find $DOC -name "*.pdf" -delete
      echo true
   else
      echo false
   fi
   #echo $filename
   #echo $filename
done
