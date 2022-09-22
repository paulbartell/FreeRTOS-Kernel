#!/bin/bash
set -x
set -e

TOOLCHAIN_LIB_AVR_DIR="${1}"
TOOLCHAIN_DEVICE_SPECS_DIR="${2}"

[ -z "${TOOLCHAIN_LIB_AVR_DIR}" ] && TOOLCHAIN_AVR_DIR=/usr/lib/avr
[ -z "${TOOLCHAIN_DEVICE_SPECS_DIR}" ] && TOOLCHAIN_DEVICE_SPECS_DIR=/usr/lib/gcc/avr/*/device-specs

echo "TOOLCHAIN_LIB_AVR_DIR: ${TOOLCHAIN_LIB_AVR_DIR}"
echo "TOOLCHAIN_DEVICE_SPECS_DIR: ${TOOLCHAIN_DEVICE_SPECS_DIR}"

mkdir -p /tmp/packs
cd /tmp/packs
wget http://packs.download.atmel.com/Atmel.ATautomotive_DFP.2.0.214.atpack
wget http://packs.download.atmel.com/Atmel.ATmega_DFP.2.0.401.atpack
wget http://packs.download.atmel.com/Atmel.ATtiny_DFP.2.0.368.atpack
wget http://packs.download.atmel.com/Atmel.AVR-Dx_DFP.2.1.146.atpack
wget http://packs.download.atmel.com/Atmel.AVR-Ex_DFP.2.2.56.atpack
wget http://packs.download.atmel.com/Atmel.XMEGAA_DFP.1.3.146.atpack
wget http://packs.download.atmel.com/Atmel.XMEGAB_DFP.1.3.122.atpack
wget http://packs.download.atmel.com/Atmel.XMEGAC_DFP.1.3.117.atpack
wget http://packs.download.atmel.com/Atmel.XMEGAD_DFP.1.4.131.atpack
wget http://packs.download.atmel.com/Atmel.XMEGAE_DFP.1.4.119.atpack

unzip -o Atmel.ATautomotive_DFP.2.0.214.atpack
unzip -o Atmel.ATmega_DFP.2.0.401.atpack
unzip -o Atmel.ATtiny_DFP.2.0.368.atpack
unzip -o Atmel.AVR-Dx_DFP.2.1.146.atpack
unzip -o Atmel.AVR-Ex_DFP.2.2.56.atpack
unzip -o Atmel.XMEGAA_DFP.1.3.146.atpack
unzip -o Atmel.XMEGAB_DFP.1.3.122.atpack
unzip -o Atmel.XMEGAC_DFP.1.3.117.atpack
unzip -o Atmel.XMEGAD_DFP.1.4.131.atpack
unzip -o Atmel.XMEGAE_DFP.1.4.119.atpack

cp --verbose --no-clobber include/avr/*.h ${TOOLCHAIN_LIB_AVR_DIR}/include/avr/
mv --verbose --no-clobber gcc/dev/*/device-specs/specs-* ${TOOLCHAIN_DEVICE_SPECS_DIR}/
rm --recursive --force gcc/dev/*/device-specs
cp --verbose --recursive --no-clobber gcc/dev/*/* ${TOOLCHAIN_LIB_AVR_DIR}/lib/

cd ../
rm --recursive --force /tmp/packs
