#!/usr/bin/env bash
set -xe

# clone the generator
dest_dir=${CGRA_GEN}
WD=${ROOT_DIR}

if [ ! -d ${dest_dir} ]; then
    git clone --single-branch -b dev --depth 1 \
        https://github.com/StanfordAHA/CGRAGenerator ${dest_dir}
fi

if [ ! -d TestBenchGenerator ]; then
    git clone --depth 1 https://github.com/StanfordAHA/TestBenchGenerator
    pip install -r TestBenchGenerator/requirements.txt
fi

# switch to dev branch
cd CGRAGenerator

# build the generator
cd hardware/generator_z/top

./build_cgra.sh

# sanity check
ls -l ${CGRA_INFO} > /dev/null

cd ${WD}
