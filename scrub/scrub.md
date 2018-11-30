# Scrub
**to do:**
- clean-up each process in order to have fewer steps
- add more details on the use of shell scripts

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
- select id and label from nt file and convert to csv using arq
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
- This file is very large
1st - split into 12 parts
2nd - use tdbloader and tdbquerry (part of Apache Jena ARQ) to select id and label from nt file
```bash
split -nl/12 authoritiesnames.both.nt

# out of memory error, try using TDB to store and index the file then query it
tdbloader --loc xaa_tdb_store xaa.nt
tdbquery --loc xaa_tdb_store --results CSV --query lcnafQuery.rq > part1.csv

tdbloader --loc xab_tdb_store xab.nt
tdbquery --loc xab_tdb_store --results CSV --query lcnafQuery.rq > part2.csv

tdbloader --loc xac_tdb_store xac.nt
tdbquery --loc xac_tdb_store --results CSV --query lcnafQuery.rq > part3.csv

tdbloader --loc xad_tdb_store xad.nt
tdbquery --loc xad_tdb_store --results CSV --query lcnafQuery.rq > part4.csv

tdbloader --loc xae_tdb_store xae.nt
tdbquery --loc xae_tdb_store --results CSV --query lcnafQuery.rq > part5.csv

tdbloader --loc xaf_tdb_store xaf.nt
tdbquery --loc xaf_tdb_store --results CSV --query lcnafQuery.rq > part6.csv

tdbloader --loc xag_tdb_store xag.nt
tdbquery --loc xag_tdb_store --results CSV --query lcnafQuery.rq > part7.csv

tdbloader --loc xah_tdb_store xah.nt
tdbquery --loc xah_tdb_store --results CSV --query lcnafQuery.rq > part8.csv

tdbloader --loc xai_tdb_store xai.nt
tdbquery --loc xai_tdb_store --results CSV --query lcnafQuery.rq > part9.csv

tdbloader --loc xaj_tdb_store xaj.nt
tdbquery --loc xaj_tdb_store --results CSV --query lcnafQuery.rq > part10.csv

tdbloader --loc xak_tdb_store xak.nt
tdbquery --loc xak_tdb_store --results CSV --query lcnafQuery.rq > part11.csv

tdbloader --loc xal_tdb_store xal.nt
tdbquery --loc xal_tdb_store --results CSV --query lcnafQuery.rq > part12.csv
```
- run python script to make lists
- post processing clean-up tasks
```bash
cat lcsh_*.csv >> new.csv
sed 's/^/"/' new.csv | sed 's/$/"/' > lcnaf.csv
sed -i '1 i\term' lcnaf.csv
```

### The Getty Research Institute
AAT, TGN, and ULAN
- select id and label from each nt file and convert to csv using arq
```bash
$ arq --data AATOut_2Terms.nt --query aatQuery.rq --results csv > aatLabels.csv
$ arq --data TGNOut_2Terms.nt --query queryTerms.rq --results csv > tgnLabels.csv
```
- if file is too large use tdbloader and tdbquerry (part of Apache Jena ARQ) to select id and label from nt file
```bash
$ tdbloader --loc my_tdb_store TGNOut_2Terms.nt
$ tdbquery --loc my_tdb_store --results CSV --query queryTerms.rq > tgnLabels.csv
```
- create list of terms for each file
```
python termsOnly.py
```
- post processing clean-up tasks
```bash
$ sed 's/^/[/' FASTChronologicalTerms.csv > temp
$ sed 's/$/]/' temp > FASTChronologicalTerms.csv
$ rm temp
```
then:
delete first line (header)
remove quotes around terms that contain commas
```bash
sed -i '1 i\term' VOCAB_NAME.csv
```

### OCLC
- select id and label from each nt file and convert to csv using arq
```bash
$ arq --data FASTChronological.nt --query fastQuery.rq --results csv > FASTChronologicalLabels.csv
$ arq --data FASTCorporate.nt --query fastQuery.rq --results csv > FASTCorporate.csv
$ arq --data FASTEvent.nt --query fastQuery.rq --results csv > FASTEvent.csv
$ arq --data FASTFormGenre.nt --query fastQuery.rq --results csv > FASTFormGenre.csv
$ arq --data FASTGeographic.nt --query fastQuery.rq --results csv > FASTGeographic.csv
$ arq --data FASTTitle.nt --query fastQuery.rq --results csv > FASTTitle.csv
$ arq --data FASTTopical.nt --query fastQuery.rq --results csv > FASTTopical.csv
```
- if file is too large use tdbloader and tdbquerry (part of Apache Jena ARQ) to select id and label from nt file
```bash
# load into tdb and retrieve id,label
# $ tdbloader --loc my_tdb_store FASTPersonal.nt
# $ tdbquery --loc my_tdb_store --results CSV --query fastQuery.rq > FASTPersonal.csv
```
- create list of terms with python scripts
```bash
python FASTChronologicalTermsOnly.py
python FASTPersonalTermsOnly.py
python tFASTCorporateTermsOnly.py
python FASTEventTermsOnly.py
python FASTTitleTermsOnly.py
python FASTFormGenreTermsOnly.py
python FASTTopicalTermsOnly.py
python FASTGeographicTermsOnly.py
```
- post processing clean-up tasks for each FAST vocab
```bash
$ sed 's/^/[/' FASTChronologicalTerms.csv > temp
$ sed 's/$/]/' temp > FASTChronologicalTerms.csv
$ rm temp
```
then:
delete first line (header)
remove quotes around terms that contain commas
