#!/bin/sh

#
# Download and run dspam installer
#

wget ftp://ftp.whitehorsetc.com/pub/dspam/archive/dspam-install.el.tar.gz
if [ "$?" != "0" ]; then
   exit 1
fi
tar xzvf dspam-install.el.tar.gz
if [ "$?" != "0" ]; then
   exit 1
fi
cd dspam
pwd
./dspamdb.sh
cd ..

rm -rf dspam
rm -f dspam*.tar.gz

pwd
exit 0

