#!/bin/bash

strindex() { 
  x="${1%%$2*}"
  [[ "$x" = "$1" ]] && echo -1 || echo "${#x}"
}

find . -iname "*.sync-conflict-*" -print0 | while IFS= read -r -d '' scfile; do

    echo Found $scfile

    # FILESIZE=$(stat -c%s "$scfile")
    CONFLICTHASH=$(sha256sum "$scfile" | cut -d " " -f 1 )

    echo $scfile hash is $CONFLICTHASH

    ORIGINALFILENAME=$(sed /s/sync-conflict.\./)

    FILENAMEHEAD=${scfile#*.sync-conflict}
    FILENAMETAIL=${scfile%}
    # ORIGINALNAME=${scfile::-38}
    extension="${scfile##*.}"
    echo Original name is $ORIGINALNAME

    BASENAME=$ORIGINALNAME"."$extension
    # ORIGINALHASH=$(sha256sum "$BASENAME")

    # # BASENAMESIZE=$(stat -c%s "$BASENAME")
    # # echo "SYNC CONF SIZE +$FILESIZE "
    # # echo "BASNAME FILE S +$BASENAMESIZE"
    # # if [ "$FILESIZE" ]; then

    #     # if [ $FILESIZE -gt $BASENAMESIZE ]; then
    #     if [ "$CONFLICTHASH" = "$ORIGINALHASH" ]; then
    #         echo "deleting original"
    #         echo "$BASENAME"
    #         echo mv "$BASENAME" /media/large_disk/Docs_notbackup/tobedeleted
    #         #move syncconflict over original
    #         echo mv "$scfile" "$BASENAME"
    #     else
    #         echo "deleting syncconfig file"
    #         echo mv "$scfile" /media/large_disk/Docs_notbackupt/tobedeleted
    #     fi
    # # fi
done
