#!/bin/bash
FROMDIR="$(pwd)"
BUILDDIR="${FROMDIR}_click"
NAME="fallingBlocks"
rm -rf $BUILDDIR
cp -r $FROMDIR $BUILDDIR
echo "Entering ${BUILDDIR}"
pushd $BUILDDIR
rm -rf .git* .bzr* debian desktop ${NAME}.qmlp* \
${NAME}128.png ${NAME}16.png ${NAME}32.png \
${NAME}64.png make_click.sh README.md LICENSE
pushd po
echo "Generating mo files"
./generate_mo.sh
popd
rm -r po
pushd ../
echo "Build click package in `pwd`"
click build $BUILDDIR
popd
popd
