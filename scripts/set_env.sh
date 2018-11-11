#!/usr/bin/env bash

deactivate_cgra() {
    PS1=${_OLD_CGRA_PS1}
    unset _OLD_CGRA_PS1
    unset CGRA_INFO
    unset CGRA_GEN
    unset SCRIPT_GEN
    unset ROOT_DIR
    unset PNR_DIR
    unset PNR
    unset COREIR_FIX
    unset deactivate_cgra
}


BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
WD=$(realpath ${BASEDIR}/../)

# setting values up
export SCRIPT_DIR=${WD}/scripts
export CGRA_GEN=${WD}/CGRAGenerator
export CGRA_INFO="${CGRA_GEN}/hardware/generator_z/top/cgra_info.txt"
export ROOT_DIR=${WD}
export PNR_DIR=${WD}/cgra_pnr
export PNR=${PNR_DIR}/scripts/pnr_flow.sh
export COREIR_FIX=${PNR_DIR}/coreir_fix/fix_all.sh
export MUX_FIX=${PNR_DIR}/coreir_fix/fix_mux.py
export -f deactivate_cgra

# set up the prompt
export _OLD_CGRA_PS1="${PS1}"
PS1="(cgra) ${PS1}"
