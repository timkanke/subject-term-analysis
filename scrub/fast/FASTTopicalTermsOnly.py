#! python

import pandas as pd
f=pd.read_csv("FASTTopical.csv")
keep_col = ['label']
new_f = f[keep_col]
new_f.to_csv("FASTTopical.csv", index=False)

# post processing
# $ sed 's/^/[/' FASTTopicalTerms.csv > temp
# $ sed 's/$/]/' temp > FASTTopicalTerms.csv
# delete first line
# remove quotes around terms that contain commas
# delete temp
