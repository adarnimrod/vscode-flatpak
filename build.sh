#!/bin/bash

set -e

wget https://go.microsoft.com/fwlink/?LinkID=760868 -O vscode.deb
ar x vscode.deb

if [[ ! -d repo ]]
then
    ostree  init --mode=archive-z2 --repo=repo
fi

flatpak-builder \
    --force-clean \
    --ccache \
    --require-changes \
    --repo=repo \
    --arch=$(flatpak --default-arch) \
    --subject="build of com.visualstudio.code.oss, $(date)" \
    build \
    com.visualstudio.code.oss.json
