# Scrub
**to do:**
- explain how to set up folder structure
- add details on the use of shell scripts

## Scrubbing DPLA metadata
use shell script hubScrub.sh

## Scrubbing controlled vocabularies
requirements:
* Apache Jena ARQ https://jena.apache.org/documentation/query/index.html
* dos2unix https://sourceforge.net/projects/dos2unix/
* python 3
* pandas

### Library of Congress
#### LCSH
- select id and label from nt file and convert to csv
```bash
$ arq --data authoritiessubjects.skos.nt --query lcshQuery.rq --results csv > lcshLabels.csv

```
- add brackets around label in csv example
```bash
# change first comma to ,[
awk '{sub(",",",[")}1' lcshLabels.csv > temp
# remove ^M
dos2unix temp
# add ] to end of each line
sed 's/$/]/' temp > lcshLabels.csv
# delete temp
rm temp
```
- create list of terms
```
python termsOnly.py
```

#### LCNAF

### The Getty Research Institute

### OCLC
