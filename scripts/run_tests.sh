#!/usr/bin/env bash
set -xe

declare -a apps_16=("eq" "abs" "ucomp" "arith" "uminmax"
                    "bool" "scomp" "shift" "ternary")

declare -a io_16=("shift" "ternary")

for file in "${apps_16[@]}"
do
    # fix mapped core ir json
    app="dataset/${file}.json"
    python ${MUX_FIX} dataset/design_mapped_${file}.json ${app}_temp
    ${COREIR_FIX} ${app}_temp ${app}
    # run pnr
    ${PNR} ${CGRA_INFO} ${app}
    # make sure the bsb file exists
    ls -l "dataset/${file}.bsb"
    if [[ " ${io_16[@]} " =~ " ${file} " ]]; then
        ${SCRIPT_DIR}/run_app.sh $file 16
    else
        ${SCRIPT_DIR}/run_app.sh $file 8
    fi
done
