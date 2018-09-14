#! python

import pandas as pd
f=pd.read_csv("lcshLabels.csv")
keep_col = ['label']
new_f = f[keep_col]
new_f.to_csv("lcshTerms.csv", index=False)

# post processing
# $ sed 's/^/[/' lcshTerms.csv > temp
# $ sed 's/$/]/' temp > lcshTerms.csv
# delete first line
# remove quotes around terms that contain commas
# delete temp
