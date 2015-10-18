#!/bin/bash
pushd `dirname "${BASH_SOURCE[0]}"`/..
xgettext -C --qt --keyword=tr -d fallingblocks -o po/fallingBlocks.pot  */*.qml *.qml
echo "updating translation files"
for i in po/*.po; do echo "updating $i"; msgmerge -U $i po/fallingBlocks.pot; done
popd
