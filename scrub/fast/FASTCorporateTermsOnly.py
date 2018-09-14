#! python

import pandas as pd
f=pd.read_csv("FASTCorporate.csv")
keep_col = ['label']
new_f = f[keep_col]
new_f.to_csv("FASTCorporateTerms.csv", index=False)

# post processing
# $ sed 's/^/[/' FASTCorporateTerms.csv > temp
# $ sed 's/$/]/' temp > FASTCorporateTerms.csv
# delete first line
# remove quotes around terms that contain commas
# delete temp
