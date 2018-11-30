#!bin/bash

folder=../vocab

if [ ! -d $folder/lcComplexTerms.txt ]; then
  touch $folder/lcComplexTerms.txt
fi

# find complexTerms
grep '\-\-' $folder/lcnafTerms/lcnaf_1.csv  > $folder/lcComplexTerms.txt
grep '\-\-' $folder/lcnafTerms/lcnaf_2.csv  >> $folder/lcComplexTerms.txt
grep '\-\-' $folder/lcnafTerms/lcnaf_3.csv  >> $folder/lcComplexTerms.txt
grep '\-\-' $folder/lcnafTerms/lcnaf_4.csv  >> $folder/lcComplexTerms.txt
grep '\-\-' $folder/lcnafTerms/lcnaf_5.csv  >> $folder/lcComplexTerms.txt
grep '\-\-' $folder/lcnafTerms/lcnaf_6.csv  >> $folder/lcComplexTerms.txt
grep '\-\-' $folder/lcnafTerms/lcnaf_7.csv  >> $folder/lcComplexTerms.txt
grep '\-\-' $folder/lcnafTerms/lcnaf_8.csv  >> $folder/lcComplexTerms.txt
grep '\-\-' $folder/lcnafTerms/lcnaf_9.csv  >> $folder/lcComplexTerms.txt
grep '\-\-' $folder/lcshTerms.csv  >> $folder/lcComplexTerms.txt

# replace double dash delimiter with pipe and remove brackets
awk '$0=gensub("--","|","g")' $folder/lcComplexTerms.txt | sed 's:^.\(.*\).$:\1:' > $folder/lcComplexTermsPipe.csv
