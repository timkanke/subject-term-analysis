#!bin/bash

file=`ls *_Terms.csv`
#vocab=../vocab
folder=chainCompare

# replace double dash delimiter with pipe and remove brackets
awk '$0=gensub("--","|","g")' $folder/complexTermsFound.txt | sed 's:^.\(.*\).$:\1:' > $folder/complexTermsFound.csv



#############################################
# poke around to find max number of fields

#awk -F'[|]' 'NF>=8' compoundTermsFoundPipeDelimited.txt > compound8Fields.txt
#grep -Fvxf compound8Fields.txt compoundTermsFoundPipeDelimited.txt > compoundFieldsReduced1.txt

#awk -F'[|]' 'NF>=7' compoundFieldsReduced1.txt > compound7Fields.txt
#grep -Fvxf compound7Fields.txt compoundFieldsReduced1.txt > compoundFieldsReduced2.txt

#awk -F'[|]' 'NF>=6' compoundFieldsReduced2.txt > compound6Fields.txt
#grep -Fvxf compound6Fields.txt compoundFieldsReduced2.txt > compoundFieldsReduced3.txt

#awk -F'[|]' 'NF>=5' compoundFieldsReduced3.txt > compound5Fields.txt
#grep -Fvxf compound5Fields.txt compoundFieldsReduced3.txt > compoundFieldsReduced4.txt

#awk -F'[|]' 'NF>=4' compoundFieldsReduced4.txt > compound4Fields.txt
#grep -Fvxf compound4Fields.txt compoundFieldsReduced4.txt > compoundFieldsReduced5.txt

#awk -F'[|]' 'NF>=3' compoundFieldsReduced5.txt > compound3Fields.txt
#grep -Fvxf compound3Fields.txt compoundFieldsReduced5.txt > compoundFieldsReduced6.txt

#awk -F'[|]' 'NF>=2' compoundFieldsReduced6.txt > compound2Fields.txt
#grep -Fvxf compound2Fields.txt compoundFieldsReduced6.txt > compoundFieldsReduced7.txt

#awk -F'[|]' 'NF>=1' compoundFieldsReduced7.txt > compound1Fields.txt

#wc -l compound8Fields.txt
#wc -l compound7Fields.txt
#wc -l compound6Fields.txt
#wc -l compound5Fields.txt
#wc -l compound4Fields.txt
#wc -l compound3Fields.txt
#wc -l compound2Fields.txt
#wc -l compound1Fields.txt

# find number of distinct terms
#cat compound8Fields.txt | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | sort -nr | wc -l
#cat compound7Fields.txt | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | sort -nr | wc -l
#cat compound6Fields.txt | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | sort -nr | wc -l
#cat compound5Fields.txt | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | sort -nr | wc -l
#cat compound4Fields.txt | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | sort -nr | wc -l
#cat compound3Fields.txt | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | sort -nr | wc -l
#cat compound2Fields.txt | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | sort -nr | wc -l


# OTHER THINGS TO DO WITH LEFTOVERS
#grep -vf GPOstateAbbrTerms.csv reduceCompound.txt > stateGPOabbrRemoved.txt
#grep -Ff GPOstateAbbrTerms.csv reduceCompound.txt > stateGPOabbrFound.txt
#wc -l stateGPOabbrRemoved.txt 
#wc -l stateGPOabbrFound.txt 

#grep '\,' stateGPOabbrRemoved.txt  > CommaSep.txt
#wc -l CommaSep.txt 


