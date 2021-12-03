#!/bin/bash

INPUT=input.txt

# Part I:

N=$(cat $INPUT | wc -l)

echo $N


cat $INPUT \
  | awk '{gsub("", " ", $1); print $1;}' \
  | awk -v n=$N '{
    for (i=1;i<=NF;i++) {sum[i]+=$i};
    for (i in sum) {bin[i]= (sum[i]/n) >= 0.5};};
    END{for (i in bin) {printf "%s", bin[i];}; print "";}' \
  > binary.txt

binary=$(cat binary.txt)
binary_inverted=$(echo $binary | tr 01 10)
gamma=$(("2#${binary}"))
epsilon=$(("2#${binary_inverted}"))

echo gamma=$binary=$gamma
echo epsilon=$binary_inverted=$epsilon

echo final: $(expr $gamma \* $epsilon)

# Part II:


