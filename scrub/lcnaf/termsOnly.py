#! python

import pandas as pd
f=pd.read_csv("new.csv")
keep_col = ['label']
new_f = f[keep_col]
new_f.to_csv("lcnafTerms.csv", index=False)

# post processing
# $ sed 's/^/[/' lcnafTerms.csv > temp
# $ sed 's/$/]/' temp > lcnafTerms.csv
# delete first line
# remove quotes around terms that contain commas
# delete temp
