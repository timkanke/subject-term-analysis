# Explore
**to do:**
- explain how to set up folder structure
- rewrite shell scripts as PySpark

## Create table of "Number Of Items That Contain nth Number Of Terms" for a hub
```
# libraries
from pyspark.sql.functions import *
from pyspark.sql.types import StringType

# load data and select columns
df = spark.read.parquet('/home/tim/Projects/dpla_hub_data/hub_parquet/HUB_NAME')

# Find total number of items
df.count()


# GET COUNT OF ITEMS WITH NO SUBJECT
dfsubjectisnull = df.select('id', 'name', 'subject', isnull("subject").alias('subjectisnull'))
dfsubjectisnull = dfsubjectisnull.filter(dfsubjectisnull["subjectisnull"] == True).select('id', 'name', 'subject', 'subjectisnull')
result0 = dfsubjectisnull.count()


# CREATE TABLE WITH ITEMS THAT HAVE SUBJECTS
# drop null value subject
dfSubjectNotNull = df.na.drop(subset=['subject'])

# total number of items with subjects
# dfSubjectNotNull.count()

# find the number of items that have nth number of terms
result1 = dfSubjectNotNull.filter(size('subject') == 1).count()
result2 = dfSubjectNotNull.filter(size('subject') == 2).count()
result3 = dfSubjectNotNull.filter(size('subject') == 3).count()
result4 = dfSubjectNotNull.filter(size('subject') == 4).count()
result5 = dfSubjectNotNull.filter(size('subject') == 5).count()
result6 = dfSubjectNotNull.filter(size('subject') == 6).count()
result7 = dfSubjectNotNull.filter(size('subject') == 7).count()
result8 = dfSubjectNotNull.filter(size('subject') == 8).count()
result9 = dfSubjectNotNull.filter(size('subject') == 9).count()
result10 = dfSubjectNotNull.filter(size('subject') >= 10).count()


# create table of results and save to a csv file
from pyspark.sql.session import SparkSession
spark = SparkSession.builder.getOrCreate()
columns = ['Number of Terms', 'Number of Items']
vals = [    
	 ('0', result0),
	 ('1', result1),
	 ('2', result2),
	 ('3', result3),
	 ('4', result4),
	 ('5', result5),
	 ('6', result6),
	 ('7', result7),
	 ('8', result8),
	 ('9', result9),
	 ('10+', result10)
]
myresults = spark.createDataFrame(vals, columns)
myresults.show()
myresults.coalesce(1).write.csv("/home/tim/Projects/dpla_hub_data/hub_parquet/myresults.csv", header='true')
```

## Create exploded and flattened subjects data frame 
```
# explode subject, and select other columns
dfIndivSub = dfSubjectNotNull.select(dfSubjectNotNull.id, dfSubjectNotNull.name.alias('provider'), dfSubjectNotNull.intermediateProvider, dfSubjectNotNull.dataProvider, dfSubjectNotNull.subject, explode(dfSubjectNotNull.subject).alias('subjectHeading')).drop(dfSubjectNotNull.subject)

# flatten schema
dfIndivSub = dfIndivSub.select(dfIndivSub.subjectHeading.cast(StringType()).alias('subject'), 'id', 'provider', 'intermediateProvider', 'dataProvider')

# write as csv
dfIndivSub.write.csv('/path/to/hub_name.csv')
```

## Directly compare controlled vocab exact matches
use directCompare.sh script or pyspark script below to find the number of direct matches to each vocab

```
# load vocabs
vocab_lcnaf = spark.read.csv("/home/tim/Projects/subject-term-analysis/vocab/lcnaf.csv", multiLine=True, header=True)
vocab_lcsh = spark.read.csv("/home/tim/Projects/subject-term-analysis/vocab/lcshTerms.csv", multiLine=True, header=True)
vocab_tgm = spark.read.csv("/home/tim/Projects/subject-term-analysis/vocab/tgmTerms.csv", multiLine=True, header=True)
vocab_aat = spark.read.csv("/home/tim/Projects/subject-term-analysis/vocab/aatTerms.csv", multiLine=True, header=True)
vocab_FASTChronological = spark.read.csv("/home/tim/Projects/subject-term-analysis/vocab/FASTChronologicalTerms.csv", multiLine=True, header=True)
vocab_FASTCorporate = spark.read.csv("/home/tim/Projects/subject-term-analysis/vocab/FASTCorporateTerms.csv", multiLine=True, header=True)
vocab_FASTEvent = spark.read.csv("/home/tim/Projects/subject-term-analysis/vocab/FASTEventTerms.csv", multiLine=True, header=True)
vocab_FASTFormGenre = spark.read.csv("/home/tim/Projects/subject-term-analysis/vocab/FASTFormGenreTerms.csv", multiLine=True, header=True)
vocab_FASTGeographic = spark.read.csv("/home/tim/Projects/subject-term-analysis/vocab/FASTGeographicTerms.csv", multiLine=True, header=True)
vocab_tgm = spark.read.csv("/home/tim/Projects/subject-term-analysis/vocab/tgmTerms.csv", multiLine=True, header=True)
vocab_FASTPersonal = spark.read.csv("/home/tim/Projects/subject-term-analysis/vocab/FASTPersonalTerms.csv", multiLine=True, header=True)
vocab_FASTTitle = spark.read.csv("/home/tim/Projects/subject-term-analysis/vocab/FASTTitleTerms.csv", multiLine=True, header=True)
vocab_FASTTopical = spark.read.csv("/home/tim/Projects/subject-term-analysis/vocab/FASTTopicalTerms.csv", multiLine=True, header=True)


# Inner join LCNAF
inner_join_lcnaf = dfIndivSub.join(vocab_lcnaf, dfIndivSub.subject == vocab_lcnaf.term)
lcnaf_count = inner_join_lcnaf.count()
distinct_terms_lcnaf = inner_join_lcnaf.select('term').dropDuplicates() 
lcnaf_count_distinct = distinct_terms_lcnaf.count()

# Inner join LCSH
inner_join_lcsh = dfIndivSub.join(vocab_lcsh, dfIndivSub.subject == vocab_lcsh.term)
lcsh_count = inner_join_lcsh.count()
distinct_terms_lcsh = inner_join_lcsh.select('term').dropDuplicates() 
lcsh_count_distinct = distinct_terms_lcsh.count()

# Inner join TGM
inner_join_tgm = dfIndivSub.join(vocab_tgm, dfIndivSub.subject == vocab_tgm.term)
tgm_count = inner_join_tgm.count()
distinct_terms_tgm = inner_join_tgm.select('term').dropDuplicates() 
tgm_count_distinct = distinct_terms_tgm.count()

# Inner join AAT
inner_join_aat = dfIndivSub.join(vocab_aat, dfIndivSub.subject == vocab_aat.term)
aat_count = inner_join_aat.count()
distinct_terms_aat = inner_join_aat.select('term').dropDuplicates() 
aat_count_distinct = distinct_terms_aat.count()

# Inner join FAST Chronological
inner_join_FASTChronological = dfIndivSub.join(vocab_FASTChronological, dfIndivSub.subject == vocab_FASTChronological.term)
FASTChronological_count = inner_join_FASTChronological.count()
distinct_terms_FASTChronological = inner_join_FASTChronological.select('term').dropDuplicates() 
FASTChronological_count_distinct = distinct_terms_FASTChronological.count()

# Inner join FAST Corporate
inner_join_FASTCorporate = dfIndivSub.join(vocab_FASTCorporate, dfIndivSub.subject == vocab_FASTCorporate.term)
FASTCorporate_count = inner_join_FASTCorporate.count()
distinct_terms_FASTCorporate = inner_join_FASTCorporate.select('term').dropDuplicates() 
FASTCorporate_count_distinct = distinct_terms_FASTCorporate.count()

# Inner join FAST Event
inner_join_FASTEvent = dfIndivSub.join(vocab_FASTEvent, dfIndivSub.subject == vocab_FASTEvent.term)
FASTEvent_count = inner_join_FASTEvent.count()
distinct_terms_FASTEvent = inner_join_FASTEvent.select('term').dropDuplicates() 
FASTEvent_count_distinct = distinct_terms_FASTEvent.count()

# Inner join FAST Form Genre
inner_join_FASTFormGenre = dfIndivSub.join(vocab_FASTFormGenre, dfIndivSub.subject == vocab_FASTFormGenre.term)
FASTFormGenre_count = inner_join_FASTFormGenre.count()
distinct_terms_FASTFormGenre = inner_join_FASTFormGenre.select('term').dropDuplicates() 
FASTFormGenre_count_distinct = distinct_terms_FASTFormGenre.count()

# Inner join FAST Geographic
inner_join_FASTGeographic = dfIndivSub.join(vocab_FASTGeographic, dfIndivSub.subject == vocab_FASTGeographic.term)
FASTGeographic_count = inner_join_FASTGeographic.count()
distinct_terms_FASTGeographic = inner_join_FASTGeographic.select('term').dropDuplicates() 
FASTGeographic_count_distinct = distinct_terms_FASTGeographic.count()

# Inner join FAST Personal
inner_join_FASTPersonal = dfIndivSub.join(vocab_FASTPersonal, dfIndivSub.subject == vocab_FASTPersonal.term)
FASTPersonal_count = inner_join_FASTPersonal.count()
distinct_terms_FASTPersonal = inner_join_FASTPersonal.select('term').dropDuplicates() 
FASTPersonal_count_distinct = distinct_terms_FASTPersonal.count()

# Inner join FAST Title
inner_join_FASTTitle = dfIndivSub.join(vocab_FASTTitle, dfIndivSub.subject == vocab_FASTTitle.term)
FASTTitle_count = inner_join_FASTTitle.count()
distinct_terms_FASTTitle = inner_join_FASTTitle.select('term').dropDuplicates() 
FASTTitle_count_distinct = distinct_terms_FASTTitle.count()

# Inner join FAST Topical
inner_join_FASTTopical = dfIndivSub.join(vocab_FASTTopical, dfIndivSub.subject == vocab_FASTTopical.term)
FASTTopical_count = inner_join_FASTTopical.count()
distinct_terms_FASTTopical = inner_join_FASTTopical.select('term').dropDuplicates() 
FASTTopical_count_distinct = distinct_terms_FASTTopical.count()

# find original term_instances and distinct_terms count
dfIndivSub_count = dfIndivSub.count()
dfIndivSub_count_distinct = dfIndivSub.select('subject').dropDuplicates().count()

# make a table with results
## TODO: check if this creates a nice table
from pyspark.sql.session import SparkSession
spark = SparkSession.builder.getOrCreate()
columns = ['vocab', 'term_instances', 'distinct_terms']
vals = [    
	 ('Original', dfIndivSub_count, dfIndivSub_count_distinct),
	 ('LCNAF', lcnaf_count, lcnaf_count_distinct),
	 ('LCSH', lcsh_count, lcsh_count_distinct),
	 ('TGM', tgm_count, tgm_count_distinct),
	 ('AAT', aat_count, aat_count_distinct),
	 ('FAST Chronological', FASTChronological_count, FASTChronological_count_distinct),
	 ('FAST Corporate', FASTCorporate_count, FASTCorporate_count_distinct),
	 ('FAST Event', FASTEvent_count, FASTEvent_count_distinct),
	 ('FAST Form Genre', FASTFormGenre_count, FASTFormGenre_count_distinct),
	 ('FAST Geographic', FASTGeographic_count, FASTGeographic_count_distinct),
	 ('FAST Personal', FASTPersonal_count, FASTPersonal_count_distinct),
	 ('FAST Title', FASTTitle_count, FASTTitle_count_distinct),
	 ('FAST Topical', FASTTopical_count, FASTTopical_count_distinct)
]
results_direct_compare = spark.createDataFrame(vals, columns)
results_direct_compare.show()
```

## Stepping through controlled vocab
#### exact matches
use compareChainingThrough.sh script to find the number of matches by stepping through vocab
```
# Left outer join and filter items with vocabs
left_join00 = dfIndivSub.join(vocab_lcnaf, dfIndivSub.subject == vocab_lcnaf.term, how='left_outer').filter(col('term').isNull()).drop('term')
left_join01 = left_join00.join(vocab_lcsh, dfIndivSub.subject == vocab_lcsh.term, how='left_outer').filter(col('term').isNull()).drop('term')
left_join02 = left_join01.join(vocab_tgm, dfIndivSub.subject == vocab_tgm.term, how='left_outer').filter(col('term').isNull()).drop('term')
left_join03 = left_join02.join(vocab_aat, dfIndivSub.subject == vocab_aat.term, how='left_outer').filter(col('term').isNull()).drop('term')
left_join04 = left_join03.join(vocab_FASTChronological, dfIndivSub.subject == vocab_FASTChronological.term, how='left_outer').filter(col('term').isNull()).drop('term')
left_join05 = left_join04.join(vocab_FASTCorporate, dfIndivSub.subject == vocab_FASTCorporate.term, how='left_outer').filter(col('term').isNull()).drop('term')
left_join06 = left_join05.join(vocab_FASTEvent, dfIndivSub.subject == vocab_FASTEvent.term, how='left_outer').filter(col('term').isNull()).drop('term')
left_join07 = left_join06.join(vocab_FASTFormGenre, dfIndivSub.subject == vocab_FASTFormGenre.term, how='left_outer').filter(col('term').isNull()).drop('term')
left_join08 = left_join07.join(vocab_FASTGeographic, dfIndivSub.subject == vocab_FASTGeographic.term, how='left_outer').filter(col('term').isNull()).drop('term')
left_join09 = left_join08.join(vocab_FASTPersonal, dfIndivSub.subject == vocab_FASTPersonal.term, how='left_outer').filter(col('term').isNull()).drop('term')
left_join10 = left_join09.join(vocab_FASTTitle, dfIndivSub.subject == vocab_FASTTitle.term, how='left_outer').filter(col('term').isNull()).drop('term')
left_join11 = left_join10.join(vocab_FASTTopical, dfIndivSub.subject == vocab_FASTTopical.term, how='left_outer').filter(col('term').isNull()).drop('term')
#left_join11.show()

# TODO: need to check if the above is working correctly

# count total Exact Matches to vocab
# TODO: need to check if the above is working correctly
exact_match_count = dfIndivSub_count - left_join11.count()
exact_match_count_distinct = left_join11.select('term').dropDuplicates().count()


# find Complex Terms
# TODO: write code


# count Complex Terms
# TODO: write code
# complex_term_count
# complex_term_count_distinct


# count mystery leftovers
# TODO: write code
# mystery_leftover_count
# mystery_leftover_count_distinct


# create a table
columns = ['stage', 'term_instances', 'distinct_terms']
vals = [    
	 ('Original', dfIndivSub_count, dfIndivSub_count_distinct),
	 ('Exact Matches', exact_match_count, exact_match_count_distinct),
	 ('Complex Terms', complex_term_count, complex_term_count_distinct),
	 ('Mystery Leftovers', mystery_leftover_count, mystery_leftover_count_distinct),
]
results_direct_compare = spark.createDataFrame(vals, columns)
results_direct_compare.show()
```

#### select complex style terms and break into single terms match with LCSH and LCNAF complex terms
use complexTerms.sh

