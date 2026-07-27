#!/bin/bash
set -e
tst="..."
M="$tst/models/METIS-1"
S="$M/metis-5.1.0"
I="$tst/models/metis_install"
[ -d $M ]||git clone https://github.com/xijunke/METIS-1.git $M
cd $M
[ -f metis-5.1.0.tar.gz ]&&tar -xzf metis-5.1.0.tar.gz
cd $S
make clean; make config; make -j$(nproc)
mkdir -p build/Linux-x86_64
rm -rf $I; mkdir -p $I/include $I/lib
find . -name "*.h" -exec cp {} $I/include/ \; 2>/dev/null
find . -name "*.so*" -o -name "*.a" -exec cp {} $I/lib/ \; 2>/dev/null
find build -name "*.so*" -o -name "*.a" -exec cp {} $I/lib/ \; 2>/dev/null
find programs -name "*.so*" -o -name "*.a" -exec cp {} $I/lib/ \; 2>/dev/null
[ -f $I/include/metis.h ]&&[ -n "$(find $I/lib -name '*metis*')" ]||exit 1