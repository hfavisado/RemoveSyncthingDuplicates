#!/bin/bash
find . -iname "*.sync-conflict-*" -print0 | while IFS= read -r -d '' scfile; do
  echo Found $scfile
  ORIGINALFILENAME=$(echo $scfile | sed -E "s/.sync-conflict-[0-9]+-[0-9]+-[0-9A-Z]+//g")

  if [ ! -f "$ORIGINALFILENAME" ]; then
    echo Error: Conflict file $scfile exists but original file $ORIGINALFILENAME not found.
    continue
  fi

  ORIGINALHASH=$(sha256sum "$ORIGINALFILENAME" | cut -d " " -f 1)
  CONFLICTHASH=$(sha256sum "$scfile" | cut -d " " -f 1)

  if [ $ORIGINALHASH = $CONFLICTHASH ]; then
    echo Deleting $scfile with hash identical to $ORIGINALFILENAME
    rm "$scfile"
  else
    echo Files $ORIGINALFILENAME and $scfile found but hashes are different:
    echo $ORIGINALHASH
    echo $CONFLICTHASH
  fi
done
