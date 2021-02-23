#!/bin/bash

dir_at_startup=$(pwd)

reset () {
echo "Go back to $dir_at_startup"
cd $dir_at_startup

echo "Restore clean working directory"
mkdir -p work
rm -rf work
mkdir work
cd work

echo "Here we go again!"
}
