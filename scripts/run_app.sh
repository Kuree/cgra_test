#!/usr/bin/env bash
set -xe

# strict translation from the script I use to test on kiwi
cgra_generator=${CGRA_GEN}
cgra="-cgra ${CGRA_INFO}"
bsb=${cgra_generator}/bitstream/bsbuilder

gen=${cgra_generator}
v=${gen}/verilator/generator_z_tb
top=${gen}/hardware/generator_z/top

# get application name and size
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <app_name> <io_size>"
    exit 1
fi

app_name=$1
io_size=$2
WD=$(pwd)
# run configure the bsa
${bsb}/bsbuilder.py ${cgra} < ${ROOT_DIR}/dataset/${app_name}.bsb > ${app_name}.bsa

cd ${v}

./run_tbg.csh \
    -nogen \
    -config ${WD}/${app_name}.bsa \
    -input  ${ROOT_DIR}/dataset/input_${app_name}.raw \
    -output ${app_name}_CGRA_out.raw \
    -out1 ${app_name}_CGRA_out1.raw \
    -delay  0,0 \
    -nclocks 1M \
    -input-size ${io_size} \
    -output-size ${io_size}

cmp ${app_name}_CGRA_out.raw ${ROOT_DIR}/dataset/out_${app_name}.raw

rm -f ${app_name}_CGRA_out.raw
rm -f ${app_name}_CGRA_out1.raw
rm ${WD}/${app_name}.bsa

