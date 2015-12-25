#!/bin/bash
PW_DIR=$(pwd)
DEST_DIR=${PW_DIR}/public

for f in css fonts js index.html
do
  if [ -L "${DEST_DIR}/${f}" ]
  then
    echo "Link to ${f} exists; deleting..."
    rm -f "${DEST_DIR}/${f}"
  elif [ -d "${DEST_DIR}/${f}" ]
  then
    echo "Directory ${f} exists; deleting..."
    rm -fr "${DEST_DIR}/${f}"
  elif [ -f "${DEST_DIR}/${f}" ]
  then
    rm "${DEST_DIR}/${f}"
  fi
done
