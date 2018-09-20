#!/usr/bin/env bash
#
# Program name: prepareD.sh
# Description: Prepare D compilers: dmd, ldc, gdc
# Last modified Time-stamp: <2018-09-19 15:58:24 CEST (vql)>
# Author: Vang Le
# Created: 2018-09-19T15:38:40+0200

# Copyright (C) 2018  Vang Quy Le

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.



currentDir=$PWD;

# SCRIPTDIR=$(dirname $(readlink -f $0))
mkdir -p $HOME/dlang && \
    wget https://raw.githubusercontent.com/bioslaD/meetups/master/installD.sh -O $HOME/dlang/installD.sh
cd $HOME/dlang/
chmod +x ./installD.sh
for ddist in dmd ldc gdc; do
    ./installD.sh $ddist
    ddir=$(find . -maxdepth 1 -type d -name "${ddist}*" -printf "%T+\t%p\n" |sort -r|cut -f2|head -n1)
    if [[ ! -z $ddir ]]; then
        ln -snf $ddir $ddist
    fi

done

dlang () {
    local droot="$HOME/dlang"
    local version=${1:-dmd}
    if [ ! -d $droot/$version ]
    then
        echo Available versions:
        cd $droot && ls -lad ./*
        exit
    fi
    source $droot/$version/activate
}

cd $currentDir
