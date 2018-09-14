#!bin/bash

file=`ls *_Terms.csv`
vocab=../vocab
folder=chainCompare
output=chainCompareExactMatchOutput.csv

if [ ! -d $folder ]; then
  mkdir -p $folder
fi

filewc=`wc -l < $file`
echo $filewc "term occurences"
filewcdistinct=`cat $file | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | sort -nr | wc -l`
echo $filewcdistinct "distinct terms"


# filter out LCNAF
grep -Fvxf $vocab/lcnafTerms/lcnaf_1.csv $file > $folder/LCNAF_1_removed.txt
grep -Fvxf $vocab/lcnafTerms/lcnaf_2.csv $folder/LCNAF_1_removed.txt > $folder/LCNAF_2_removed.txt
grep -Fvxf $vocab/lcnafTerms/lcnaf_3.csv $folder/LCNAF_2_removed.txt > $folder/LCNAF_3_removed.txt
grep -Fvxf $vocab/lcnafTerms/lcnaf_4.csv $folder/LCNAF_3_removed.txt > $folder/LCNAF_4_removed.txt
grep -Fvxf $vocab/lcnafTerms/lcnaf_5.csv $folder/LCNAF_4_removed.txt > $folder/LCNAF_5_removed.txt
grep -Fvxf $vocab/lcnafTerms/lcnaf_6.csv $folder/LCNAF_5_removed.txt > $folder/LCNAF_6_removed.txt
grep -Fvxf $vocab/lcnafTerms/lcnaf_7.csv $folder/LCNAF_6_removed.txt > $folder/LCNAF_7_removed.txt
grep -Fvxf $vocab/lcnafTerms/lcnaf_8.csv $folder/LCNAF_7_removed.txt > $folder/LCNAF_8_removed.txt
grep -Fvxf $vocab/lcnafTerms/lcnaf_9.csv $folder/LCNAF_8_removed.txt > $folder/LCNAFremoved.txt

# filter out LCSH
grep -Fvxf $vocab/lcshTerms.csv $folder/LCNAFremoved.txt > $folder/reduce1.txt

# filter out TGM
grep -Fvxf $vocab/tgmTerms.csv $folder/reduce1.txt > $folder/reduce2.txt

# filter out aat
grep -Fvxf $vocab/aatTerms.csv $folder/reduce2.txt > $folder/reduce3.txt

# filter out FASTChronologicalTerms.csv
grep -Fvxf $vocab/FASTChronologicalTerms.csv $folder/reduce3.txt > $folder/reduce4.txt

# filter out FASTCorporateTerms.csv
grep -Fvxf $vocab/FASTCorporateTerms.csv $folder/reduce4.txt> $folder/reduce5.txt

# filter out FASTEventTerms.csv
grep -Fvxf $vocab/FASTEventTerms.csv $folder/reduce5.txt > $folder/reduce6.txt

# FASTFormGenreTerms.csv
grep -Fvxf $vocab/FASTFormGenreTerms.csv $folder/reduce6.txt > $folder/reduce7.txt

# FASTGeographicTerms.csv
grep -Fvxf $vocab/FASTGeographicTerms.csv $folder/reduce7.txt > $folder/reduce8.txt

# FASTPersonalTerms.csv
grep -Fvxf $vocab/FASTPersonalTerms.csv $folder/reduce8.txt > $folder/reduce9.txt

# FASTTitleTerms.csv
grep -Fvxf $vocab/FASTTitleTerms.csv $folder/reduce9.txt > $folder/reduce10.txt

# FASTTopicalTerms.csv
grep -Fvxf $vocab/FASTTopicalTerms.csv $folder/reduce10.txt > $folder/exactMatchesRemoved.txt

# create file with found terms
grep -Fvxf $folder/exactMatchesRemoved.txt $file > $folder/exactMatchesFound.txt

# remove temp files
rm -f $folder/LCNAF*removed.txt $folder/reduce*.txt

#wc -l $folder/exactMatchesFound.txt
#wc -l $folder/exactMatchesRemoved.txt

exactMatchesFoundTotal=`wc -l < $folder/exactMatchesFound.txt`
exactMatchesFoundDistinct=`cat $folder/exactMatchesFound.txt | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $exactMatchesFoundTotal "exact match terms found"
echo $exactMatchesFoundDistinct "exact match distinct terms found"


# find complexTerms
grep '\-\-' $folder/exactMatchesRemoved.txt  > $folder/complexTermsFound.txt
grep -Fvxf $folder/complexTermsFound.txt $folder/exactMatchesRemoved.txt > $folder/complexTermsRemoved.txt

complexTermsFoundTotal=`wc -l < $folder/complexTermsFound.txt`
complexTermsFoundDistinct=`cat $folder/complexTermsFound.txt | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $complexTermsFoundTotal "complex terms found"
echo $complexTermsFoundDistinct "complex distinct terms found"

mysteryLeftovers=`wc -l < $folder/complexTermsRemoved.txt`
mysteryLeftoversDistinct=`cat $folder/complexTermsRemoved.txt | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $mysteryLeftovers "mystery leftovers"
echo $mysteryLeftoversDistinct "mystery leftovers distinct terms"


# create a nice csv file
echo "stage,# of term instances,# of distinct terms" > $output
echo $file","$filewc","$filewcdistinct >> $output
echo "Exact Matches,"$exactMatchesFoundTotal","$exactMatchesFoundDistinct >> $output
echo "Complex Terms,"$complexTermsFoundTotal","$complexTermsFoundDistinct >> $output
echo "Mystery Leftovers,"$mysteryLeftovers","$mysteryLeftoversDistinct >> $output
