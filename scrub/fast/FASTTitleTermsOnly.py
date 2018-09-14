#! python

import pandas as pd
f=pd.read_csv("FASTTitle.csv")
keep_col = ['label']
new_f = f[keep_col]
new_f.to_csv("FASTTitleTerms.csv", index=False)

# post processing
# $ sed 's/^/[/' FASTTitleTerms.csv > temp
# $ sed 's/$/]/' temp > FASTTitleTerms.csv
# delete first line
# remove quotes around terms that contain commas
# delete temp
