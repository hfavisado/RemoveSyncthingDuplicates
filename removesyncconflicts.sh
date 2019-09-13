#!/bin/bash

gethash() {
  echo $(sha256sum "$1" | cut -d " " -f 1)
}

find . -iname "*.sync-conflict-*" -print0 | while IFS= read -r -d '' scfile; do
  echo Found $scfile
  ORIGINALFILENAME=$(echo $scfile | sed -E "s/.sync-conflict-[0-9]+-[0-9]+-[0-9A-Z]+//g")

  if [ ! -f "$ORIGINALFILENAME" ]; then
    echo Error: Duplicate file $scfile exists but original file $ORIGINALFILENAME was not found.
    continue
  fi

  ORIGINALHASH=$(gethash "$ORIGINALFILENAME")
  CONFLICTHASH=$(gethash "$scfile")

  if [ $ORIGINALHASH = $CONFLICTHASH ]; then
    echo Deleting $scfile with hash identical to $ORIGINALFILENAME
    rm "$scfile"
  else
    echo Error: Files $ORIGINALFILENAME and $scfile found but hashes are different:
    echo original: $ORIGINALHASH
    echo duplicate: $CONFLICTHASH
  fi
done
