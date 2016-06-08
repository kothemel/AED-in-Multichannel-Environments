#!/bin/bash
rm -f output.txt
FILES=/media/kothemel/Elements1/Ubuntu_Backup/htk/training_set/wav/S01/ISOLATED/mic1/*.wav
for f in $FILES
do
  sox $f -n stat 2>&1 | sed -n 's#^Length (seconds):[^0-9]*\([0-9.]*\)$#\1#p' >> output.txt
done