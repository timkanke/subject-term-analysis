#!/bin/bash

file=`ls *_Terms.csv`
vocab=../vocab
folder=directCompare
output=directCompareExactMatchOutput.csv

if [ ! -d $folder ]; then
  mkdir -p $folder
fi

filewc=`wc -l < $file`
echo $filewc "term occurences"
filewcdistinct=`cat $file | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | sort -nr | wc -l`
echo $filewcdistinct "distinct terms"

# filter out LCSH
grep -Fvxf $vocab/lcshTerms.csv $file > $folder/LCSHremoved.txt
LCSHfound=`grep -Ff $vocab/lcshTerms.csv $file | wc -l`
echo $LCSHfound "lcsh terms found"
LCSHfounddistinct=`grep -Ff $vocab/lcshTerms.csv $file | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $LCSHfounddistinct "lcsh distinct terms"

# filter out TGM
grep -Fvxf $vocab/tgmTerms.csv $file > $folder/TGMremoved.txt
TGMfound=`grep -Ff $vocab/tgmTerms.csv $file | wc -l`
echo $TGMfound "tgm terms found"
TGMfounddistinct=`grep -Ff $vocab/tgmTerms.csv $file | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $TGMfounddistinct "tgm distinct terms"

# filter out aat
grep -Fvxf $vocab/aatTerms.csv $file > $folder/AATremoved.txt
AATfound=`grep -Ff $vocab/aatTerms.csv $file | wc -l`
echo $AATfound "aat terms found"
AATfounddistinct=`grep -Ff $vocab/aatTerms.csv $file | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $AATfounddistinct "aat distinct terms"

# filter out FASTChronologicalTerms.csv
grep -Fvxf ../vocab/FASTChronologicalTerms.csv $file > $folder/FASTChronologicalremoved.txt
FASTChronologicalfound=`grep -Ff ../vocab/FASTChronologicalTerms.csv $file | wc -l`
echo $FASTChronologicalfound "FASTChronological terms found"
FASTChronologicalfounddistinct=`grep -Ff ../vocab/FASTChronologicalTerms.csv $file | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $FASTChronologicalfounddistinct "FASTChronological distinct terms"

# filter out FASTCorporateTerms.csv
grep -Fvxf $vocab/FASTCorporateTerms.csv $file > $folder/FASTCorporateremoved.txt
FASTCorporatefound=`grep -Ff $vocab/FASTCorporateTerms.csv $file | wc -l`
echo $FASTCorporatefound "FASTCorporateTerms terms found"
FASTCorporatefounddistinct=`grep -Ff $vocab/FASTCorporateTerms.csv $file | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $FASTCorporatefounddistinct "FASTCorporate distinct terms"

# filter out FASTEventTerms.csv
grep -Fvxf $vocab/FASTEventTerms.csv $file > $folder/FASTEventremoved.txt
FASTEventfound=`grep -Ff $vocab/FASTEventTerms.csv $file | wc -l`
echo $FASTEventfound "FASTEvent terms found"
FASTEventfounddistinct=`grep -Ff $vocab/FASTEventTerms.csv $file | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $FASTEventfounddistinct "FASTEvent distinct terms"

# filter out FASTFormGenreTerms.csv
grep -Fvxf $vocab/FASTFormGenreTerms.csv $file > $folder/FASTFormGenreremoved.txt
FASTFormGenrefound=`grep -Ff $vocab/FASTFormGenreTerms.csv $file | wc -l`
echo $FASTFormGenrefound "FASTFormGenreTerms terms found"
FASTFormGenrefounddistinct=`grep -Ff $vocab/FASTFormGenreTerms.csv $file | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $FASTFormGenrefounddistinct "FASTFormGenre distinct terms"

# filter out FASTGeographicTerms.csv
grep -Fvxf $vocab/FASTGeographicTerms.csv $file > $folder/FASTGeographicremoved.txt
FASTGeographicfound=`grep -Ff $vocab/FASTGeographicTerms.csv $file | wc -l`
echo $FASTGeographicfound "FASTGeographic terms found"
FASTGeographicfounddistinct=`grep -Ff $vocab/FASTGeographicTerms.csv $file | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $FASTGeographicfounddistinct "FASTGeographic distinct terms"

# filter out FASTPersonalTerms.csv
grep -Fvxf $vocab/FASTPersonalTerms.csv $file > $folder/FASTPersonalremoved.txt
FASTPersonalfound=`grep -Ff $vocab/FASTPersonalTerms.csv $file | wc -l`
echo $FASTPersonalfound "FASTPersonal terms found"
FASTPersonalfounddistinct=`grep -Ff $vocab/FASTPersonalTerms.csv $file | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $FASTPersonalfounddistinct "FASTPersonal distinct terms"

# filter out FASTTitleTerms.csv
grep -Fvxf $vocab/FASTTitleTerms.csv $file > $folder/FASTTitleremoved.txt
FASTTitlefound=`grep -Ff $vocab/FASTTitleTerms.csv $file | wc -l`
echo $FASTTitlefound "FASTTitle terms found"
FASTTitlefounddistinct=`grep -Ff $vocab/FASTTitleTerms.csv $file | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $FASTTitlefounddistinct "FASTTitle distinct terms"

# filter out FASTTopicalTerms
grep -Fvxf $vocab/FASTTopicalTerms.csv $file > $folder/FASTTopicalremoved.txt
FASTTopicalfound=`grep -Ff $vocab/FASTTopicalTerms.csv $file | wc -l`
echo $FASTTopicalfound "FASTTopical terms found"
FASTTopicalfounddistinct=`grep -Ff $vocab/FASTTopicalTerms.csv $file | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $FASTTopicalfounddistinct "FASTTopical distinct terms"

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
LCNAFremoved=`wc -l < $folder/LCNAFremoved.txt`
echo $((filewc-LCNAFremoved)) "lcnaf terms found"

grep -Fvxf $folder/LCNAFremoved.txt $file > $folder/LCNAFfound.txt
LCNAFfoundwc=`wc -l < $folder/LCNAFfound.txt`
LCNAFfounddistinct=`cat $folder/LCNAFfound.txt | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | wc -l`
echo $LCNAFfounddistinct "LCNAF distinct terms"

# create a nice csv file
echo "Vocab,# of term instances,# of distinct terms" > $output
echo $file","$filewc","$filewcdistinct >> $output
echo "LCNAF,"$LCNAFfoundwc","$LCNAFfounddistinct >> $output
echo "LCSH,"$LCSHfound","$LCSHfounddistinct >> $output
echo "TGM,"$TGMfound","$TGMfounddistinct >> $output
echo "AAT,"$AATfound","$AATfounddistinct >> $output
echo "FAST Chronological,"$FASTChronologicalfound","$FASTChronologicalfounddistinct >> $output
echo "FAST Corporate,"$FASTCorporatefound","$FASTCorporatefounddistinct >> $output
echo "FAST Event,"$FASTEventfound","$FASTEventfounddistinct >> $output
echo "FAST Form Genre,"$FASTFormGenrefound","$FASTFormGenrefounddistinct >> $output
echo "FAST Geographic,"$FASTGeographicfound","$FASTGeographicfounddistinct >> $output
echo "FAST Personal,"$FASTPersonalfound","$FASTPersonalfounddistinct >> $output
echo "FAST Title,"$FASTTitlefound","$FASTTitlefounddistinct >> $output
echo "FAST Topical,"$FASTTopicalfound","$FASTTopicalfounddistinct  >> $output
