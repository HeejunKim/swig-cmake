#!/bin/sh

# default path
SCRIPT_DIR=$(cd $(dirname $0) && pwd)
WORKSPACE_DIR=$(cd ${SCRIPT_DIR}/.. && pwd)
BUILD_DIR=${WORKSPACE_DIR}/build
INSTALL_DIR=${WORKSPACE_DIR}/cmake_swig

# delete build and bin folder
if [ -e ${BUILD_DIR} ]; then
    echo "delete build folder...."
    rm -rf ${BUILD_DIR}
fi

if [ -e ${INSTALL_DIR} ]; then
    echo "delete bin folder...."
    rm -rf ${INSTALL_DIR}
fi

mkdir -p ${BUILD_DIR}

cd ${BUILD_DIR}

cmake -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} ..
make
make install
cd ${WORKSPACE_DIR}
