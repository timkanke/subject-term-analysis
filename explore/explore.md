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
directCompare.sh

## Stepping through controlled vocab
#### exact matches
compareChainingThrough.sh
#### select complex style terms and break into single terms match with LCSH and LCNAF complex terms
complexTerms.sh

