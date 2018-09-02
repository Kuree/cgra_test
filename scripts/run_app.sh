#!/usr/bin/env bash
set -xe

# strict translation from the script I use to test on kiwi
cgra_generator=${CGRA_GEN}
cgra="-cgra ${CGRA_INFO}"
bsb=${cgra_generator}/bitstream/bsbuilder

gen=${cgra_generator}
v=${gen}/verilator/generator_z_tb
top=${gen}/hardware/generator_z/top

# get application name
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <app_name>"
    exit 1
fi

app_name=$1
WD=$(pwd)
# run configure the bsa
${bsb}/bsbuilder.py ${cgra} < ${ROOT_DIR}/dataset/${app_name}.bsb > ${app_name}.bsa

cd ${v}

./run.csh top_tb.cpp \
    -gen \
    -config ${WD}/${app_name}.bsa \
    -input  ${ROOT_DIR}/dateset/${app_name}_input.raw \
    -output ${app_name}_CGRA_out.raw \
    -out1 s1t0 ${app_name}_CGRA_out1.raw \
    -delay  0,0 \
    -nclocks 1M \

cmp ${app_name}_CGRA_out.raw ${ROOT_DIR}/dataset/${app_name}_halide_out.raw \
&& echo SUCCESS || echo FAIL

