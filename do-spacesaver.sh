#/bin/bash

echo "The purpose of this script is to make an 8GB file of zeros so if the HDD ever fils up you can just delete it while you sort the box out"
echo ""
echo " * Creating spacesaver.bin"
dd if=/dev/zero of=/spacesaver.bin bs=1024 count=8000000

exit 0


