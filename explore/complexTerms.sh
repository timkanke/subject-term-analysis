#!bin/bash

file=`ls *_Terms.csv`
vocab=../../vocab
folder=chainCompare
output=complexTermsBrokenIntoSingles.csv

complexTermsFoundTotal=`wc -l < $folder/complexTermsFound.txt`
complexTermsFoundDistinct=`cat $folder/complexTermsFound.txt | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $complexTermsFoundTotal "complex terms found"
echo $complexTermsFoundDistinct "complex distinct terms found"

# replace double dash delimiter with pipe and remove brackets
awk '$0=gensub("--","|","g")' $folder/complexTermsFound.txt | sed 's:^.\(.*\).$:\1:' > $folder/complexTermsFound.csv

# split terms to thier own line
cat $folder/complexTermsFound.csv | tr '|' $'\n' > $folder/complexTermsSingle.txt

# perform match to lcsh and lcnaf
filewc=`wc -l < $folder/complexTermsSingle.txt`
echo $filewc "single term  occurrences"
filewcdistinct=`cat $folder/complexTermsSingle.txt | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | sort -nr | wc -l`
echo $filewcdistinct "single distinct terms"

# add brackets to have same format as control vocab
sed 's/^/[/' $folder/complexTermsSingle.txt > temp
sed 's/$/]/' temp > $folder/complexTermsSingle.txt
rm -f temp

# filter out LCNAF
grep -Fvxf $vocab/lcnafTerms/lcnaf_1.csv $folder/complexTermsSingle.txt > $folder/LCNAF_1_removed.txt
grep -Fvxf $vocab/lcnafTerms/lcnaf_2.csv $folder/LCNAF_1_removed.txt > $folder/LCNAF_2_removed.txt
grep -Fvxf $vocab/lcnafTerms/lcnaf_3.csv $folder/LCNAF_2_removed.txt > $folder/LCNAF_3_removed.txt
grep -Fvxf $vocab/lcnafTerms/lcnaf_4.csv $folder/LCNAF_3_removed.txt > $folder/LCNAF_4_removed.txt
grep -Fvxf $vocab/lcnafTerms/lcnaf_5.csv $folder/LCNAF_4_removed.txt > $folder/LCNAF_5_removed.txt
grep -Fvxf $vocab/lcnafTerms/lcnaf_6.csv $folder/LCNAF_5_removed.txt > $folder/LCNAF_6_removed.txt
grep -Fvxf $vocab/lcnafTerms/lcnaf_7.csv $folder/LCNAF_6_removed.txt > $folder/LCNAF_7_removed.txt
grep -Fvxf $vocab/lcnafTerms/lcnaf_8.csv $folder/LCNAF_7_removed.txt > $folder/LCNAF_8_removed.txt
grep -Fvxf $vocab/lcnafTerms/lcnaf_9.csv $folder/LCNAF_8_removed.txt > $folder/LCNAFremoved.txt

# filter out LCSH
grep -Fvxf $vocab/lcshTerms.csv $folder/LCNAFremoved.txt > $folder/complexTermsSingleExactMatchesRemoved.txt

# remove temp files
rm -f $folder/LCNAF*removed.txt

# create file with found terms
grep -Fvxf $folder/complexTermsSingleExactMatchesRemoved.txt $folder/complexTermsSingle.txt > $folder/complexTermsSingleExactMatchesFound.txt

complexTermsSingleExactMatchesFoundTotal=`wc -l < $folder/complexTermsSingleExactMatchesFound.txt`
complexTermsSingleExactMatchesFoundDistinct=`cat $folder/complexTermsSingleExactMatchesFound.txt | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $complexTermsSingleExactMatchesFoundTotal "exact match single terms found"
echo $complexTermsSingleExactMatchesFoundDistinct "exact match single distinct terms found"

complexTermsSingleMysteryLeftovers=`wc -l < $folder/complexTermsSingleExactMatchesRemoved.txt`
complexTermsSingleMysteryLeftoversDistinct=`cat $folder/complexTermsSingleExactMatchesRemoved.txt | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $complexTermsSingleMysteryLeftovers "single mystery leftovers"
echo $complexTermsSingleMysteryLeftoversDistinct "single mystery leftovers distinct terms"



# create a nice csv file
echo "stage,# of term instances,# of distinct terms" > $output
echo "Complex Terms,"$complexTermsFoundTotal","$complexTermsFoundDistinct >> $output
echo "Split into Single Terms,"$filewc","$filewcdistinct >> $output
echo "Exact Matches Single Terms,"$complexTermsSingleExactMatchesFoundTotal","$complexTermsSingleExactMatchesFoundDistinct >> $output
echo "Mystery Leftovers Single Terms,"$complexTermsSingleMysteryLeftovers","$complexTermsSingleMysteryLeftoversDistinct >> $output
