# Obtain metadata and controlled vocabularies

## Obtain specific DPLA metadata
Working with a local copy of DPLA metadata in PySpark
- create parquet files for each hub with 'id', 'name', 'intermediateProvider', 'dataProvider', and 'subject' fields.
```python
# libraries
from pyspark.sql.functions import *
from pyspark.sql.types import StringType

# load data and select columns
df = spark.read.parquet('/path/to/data')
df_subjects = df.select(df['_source.id'], df['_source.provider.name'], df['_source.intermediateProvider'], df['_source.dataProvider'], df['_source.sourceResource.subject'])

# create list of providers to find hub names
dfHubList = df.select('name').distinct()
dfHubList.show(100, False)

# create individual parquet files for chosen hub template
#df_hub_name = df_subjects.filter(df_subjects.name.contains('hub_name')).select('id', 'name', 'intermediateProvider', 'dataProvider', 'subject')
#df.write.parquet('/path/to/hub_name.parquet')
```

## Obtain controlled vocabularies
The primary vocabularies that are used to sort the subject terms are from Library of Congress, The Getty Research Institute, and OCLC.
Steps:
- Download controlled vocabularies from each institution
- Move each vocabulary into a separate within a folder titled 'vocab'

### Library of Congress
Three of the vocabularies are provided by the Library of Congress: LC Subject Headings (LCSH), LC Name Authority File (LCNAF), and Thesaurus of Graphic Materials (TGM). These vocabularies are available as bulk download (http://id.loc.gov/download/) in RDF/XML and N-Triples serializations. Download the N-Triples files.

### The Getty Research Institute
The Getty Research Institute provide their vocabularies via a SPARQL endpoint and bulk download (http://vocab.getty.edu/). The downloads are available as explicit statements contained in their own file or combined into one file. We are using only one of the three vocabularies that they have created: Getty Art and Architecture Thesaurus (AAT). Download the explicit N-Triples files.

### OCLC
OCLC provide the Faceted Application of Subject Terminology (FAST) vocabulary as linked data (http://id.worldcat.org/fast/) and for download as MARC XML, RDF N-Triples, and ISO MARC formats (http://www.oclc.org/research/activities/fast/download.htm). Download the N-Triples file.

