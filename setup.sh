#!/bin/bash -x

TARGET='.screenrc'
CWD=`pwd`

for i in ${TARGET}; do
  ln -sf ${CWD}/${i} ~/${i}
done
