#! python

import pandas as pd
f=pd.read_csv("FASTPersonal.csv")
keep_col = ['label']
new_f = f[keep_col]
new_f.to_csv("FASTPersonalTerms.csv", index=False)

# post processing
# $ sed 's/^/[/' FASTPersonalTerms.csv > temp
# $ sed 's/$/]/' temp > FASTPersonalTerms.csv
# delete first line
# remove quotes around terms that contain commas
# delete temp
