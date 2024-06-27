#!/bin/bash
mkdir /build
cd /build
chmod -R a+rw .

echo $PACKAGES

for package in $PACKAGES; do
    echo $package
    mkdir $package
    pushd $package
    sudo --set-home -u builder yay -S --noconfirm --builddir=./ "$package"
    python3 /encode-names.py
    ls
    popd
done
