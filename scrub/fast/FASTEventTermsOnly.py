#! python

import pandas as pd
f=pd.read_csv("FASTEvent.csv")
keep_col = ['label']
new_f = f[keep_col]
new_f.to_csv("FASTEventTerms.csv", index=False)

# post processing
# $ sed 's/^/[/' FASTEventTerms.csv > temp
# $ sed 's/$/]/' temp > FASTEventTerms.csv
# delete first line
# remove quotes around terms that contain commas
# delete temp
