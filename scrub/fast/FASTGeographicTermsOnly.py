#! python

import pandas as pd
f=pd.read_csv("FASTGeographic.csv")
keep_col = ['label']
new_f = f[keep_col]
new_f.to_csv("FASTGeographicTerms.csv", index=False)

# post processing
# $ sed 's/^/[/' FASTGeographicTerms.csv > temp
# $ sed 's/$/]/' temp > FASTGeographicTerms.csv
# delete first line
# remove quotes around terms that contain commas
# delete temp
