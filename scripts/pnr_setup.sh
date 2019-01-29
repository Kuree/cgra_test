#!/usr/bin/env bash
set -xe

# clone the generator
dest_dir=${PNR_DIR}
WD=${ROOT_DIR}

if [ ! -d ${dest_dir} ]; then
    git clone --single-branch -b master --depth 1 \
        https://github.com/Kuree/cgra_pnr ${dest_dir}
fi

cd ${dest_dir}
# clone pybind11
git submodule update --init --recursive
pip install thunder/
pip install cyclone/
pip install -r requirements.txt
