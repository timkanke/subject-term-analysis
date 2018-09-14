#! python

import pandas as pd
f=pd.read_csv("FASTChronologicalLabels.csv")
keep_col = ['label']
new_f = f[keep_col]
new_f.to_csv("FASTChronologicalTerms.csv", index=False)

# post processing
# $ sed 's/^/[/' FASTChronologicalTerms.csv > temp
# $ sed 's/$/]/' temp > FASTChronologicalTerms.csv
# delete first line
# remove quotes around terms that contain commas
# delete temp
