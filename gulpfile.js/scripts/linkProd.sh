#!/bin/bash
PW_DIR=$(pwd)
SRC_DIR=${PW_DIR}/prod
DEST_DIR=${PW_DIR}/public

for f in css fonts js index.html
do
  # First, remove the dirs/files
  cp -fr "${SRC_DIR}/${f}" "${DEST_DIR}"
done
