#!bin/bash

result=${PWD##*/}

# combine csv files
cat *.csv >> dfHub.csv
# get hub name
hubName=`csvgrep -n dfHub.csv | grep "^  3" | cut -c 6- | sed -e 's/ /_/g'`
mv dfHub.csv $hubName.csv

# create terms only
cat $hubName.csv | cut -d ']' -f1 > hubTermsTemp.csv
sed 's/$/]/' hubTermsTemp.csv > hubTermsTemp1.csv
	# if we wish to keep quotes around terms with commas
	#sed '/"/s/$/"/' hubTermsTemp1.csv > ${hubName}_Terms.csv
# if we wish to remove quotes
sed 's/"//g' hubTermsTemp1.csv > ${hubName}_Terms.csv
# delete temp files
rm -rf hubTermsTemp.csv hubTermsTemp1.csv


# get some stats
# number of instances
wc -l ${hubName}_Terms.csv
# number of distinct terms
cat ${hubName}_Terms.csv | awk ' { tot[$0]++ } END { for (i in tot) print tot[i],"\t",i } ' | sort -nr | wc -l
