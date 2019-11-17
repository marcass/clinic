#! /bin/bash
DOC="/home/mw/Downloads/oki/"

inotifywait -m -e create $DOC |
while read -r  events filename; do
   if [[ "$filename" == *pdf ]]
   then
      lp $DOC/*.pdf -d OKI && find $DOC -name "*.pdf" -delete
      echo true
   else
      echo false
   fi
   #echo $filename
   #echo $filename
done
