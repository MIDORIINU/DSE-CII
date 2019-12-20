#!/bin/bash


DIR_SIM="."



## Power
########

cat "${DIR_SIM}/amplifier_THD_vs_power.txt" | dos2unix | grep "Measurement: pout" --after-context=1000 | tail -n +3 | sed '/Measurement: vout_max/q' | head -n -2 | cut -d'	' -f 2 > ./powers.txt

cat "${DIR_SIM}/amplifier_eff_vs_power.txt" | dos2unix | grep "Measurement: eff" --after-context=43 | tail -n +3 | cut -d'	' -f 2 > ./Eff_powers.txt


paste ./powers.txt ./Eff_powers.txt | unix2dos > ./Eff_vs_power_sim.txt

rm ./powers.txt ./Eff_powers.txt
