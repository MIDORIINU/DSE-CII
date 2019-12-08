#!/bin/bash

## Frequency.
#############

echo -n "" > ./freqs.txt

for i in `seq 20 10 90`; do
                echo -n -e "${i}\n" >> ./freqs.txt
done 

for i in `seq 100 100 900`; do
                echo -n -e "${i}\n" >> ./freqs.txt
done 

for i in `seq 1000 1000 25000`; do
                echo -n -e "${i}\n" >> ./freqs.txt
done 


cat ../amplifier_THD_vs_freq_20_to_1K.txt | dos2unix | grep "Total Harmonic Distortion:" | cut -d: -f 2 | cut -d' ' -f 2 | cut -d% -f 1 | tail -n +2 > ./THDS_freqs.txt

cat ../amplifier_THD_vs_freq_1k_to_25k.txt | dos2unix | grep "Total Harmonic Distortion:" | cut -d: -f 2 | cut -d' ' -f 2 | cut -d% -f 1 >> ./THDS_freqs.txt


paste ./freqs.txt ./THDS_freqs.txt | unix2dos > ./THD_vs_freq.txt

rm ./freqs.txt ./THDS_freqs.txt



## Power
########

cat ../amplifier_THD_vs_power.txt | dos2unix | grep "Total Harmonic Distortion:" | cut -d: -f 2 | cut -d' ' -f 2 | cut -d% -f 1 > ./THDS_powers.txt

cat ../amplifier_THD_vs_power.txt | dos2unix | grep "Measurement: pout" --after-context=1000 | tail -n +3 | sed '/Measurement: vout_max/q' | head -n -2 | cut -d'	' -f 2 > ./powers.txt


paste ./powers.txt ./THDS_powers.txt | unix2dos > ./THD_vs_power.txt

rm ./powers.txt ./THDS_powers.txt
