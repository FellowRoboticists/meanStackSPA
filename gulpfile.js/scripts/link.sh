#!/bin/bash
PW_DIR=$(pwd)
SRC_DIR=${PW_DIR}/dist
DEST_DIR=${PW_DIR}/public

for f in css fonts js index.html
do
  if [ -L "${DEST_DIR}/${f}" ]
  then
    echo "Link to ${f} already exists"
  else
    echo "Linking dist/${f} -> ${DEST_DIR}/${f}"
    ln -s "${SRC_DIR}/${f}" "${DEST_DIR}/${f}"
  fi
done
