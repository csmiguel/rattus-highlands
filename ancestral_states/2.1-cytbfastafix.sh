#Miguel Camacho-Sanchez
#feb 2020
#Rattus_highlands
#fix fasta cytb
#############
#for all cytb
cat ancestral_states/asian_rattus_cytb.fasta | \
sed -e '/>/{n;N;d}' | \
sed 's/\([A-Z]*[0-9]*\)...\([A-Za-z]* [a-z]*\).*/\2_\1/g;s/ /_/g' > temp1

#extract cytb from mitogenome
cat ancestral_states/KP876560.fasta | seqkit subseq -r 14131:15273 | \
sed 's/\([A-Z]*[0-9]*\)...\([A-Za-z]* [a-z]*\).*/\2_\1/g;s/ /_/g' > temp2

#get cytb sequences from Thomson et al. 2018
cat ancestral_states/Rare_Rattus_2018.fasta | \
sed 's/^N\+//g;s/N\+$//g;s/hoffmani/hoffmanni/' | \
seqkit grep -n -r -f ancestral_states/grep_Thomson2018 > temp3
#concatenate
cat temp1 temp2 temp3 > ancestral_states/asian_rattus_cytb_fixed.fasta
rm temp1 temp2 temp3
