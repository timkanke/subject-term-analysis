#! python

import pandas as pd
f=pd.read_csv("tgnLabels.csv")
keep_col = ['prefLabel']
new_f = f[keep_col]
new_f.to_csv("tgnTerms.csv", index=False)

# post processing
# $ sed 's/^/[/' aatTerms.csv > temp
# $ sed 's/$/]/' temp > aatTerms.csv
# delete first line
# delete temp
