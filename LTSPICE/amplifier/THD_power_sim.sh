#!/bin/bash


DIR_SIM="."



## Power
########

cat "${DIR_SIM}/amplifier_THD_vs_power.txt" | dos2unix | grep "Total Harmonic Distortion:" | cut -d: -f 2 | cut -d' ' -f 2 | cut -d% -f 1 > ./THDS_powers.txt

cat "${DIR_SIM}/amplifier_THD_vs_power.txt" | dos2unix | grep "Measurement: pout" --after-context=1000 | tail -n +3 | sed '/Measurement: vout_max/q' | head -n -2 | cut -d'	' -f 2 > ./powers.txt


paste ./powers.txt ./THDS_powers.txt | unix2dos > ./THD_vs_power_sim.txt

rm ./powers.txt ./THDS_powers.txt
