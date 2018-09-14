#! python

import pandas as pd
f=pd.read_csv("FASTFormGenre.csv")
keep_col = ['label']
new_f = f[keep_col]
new_f.to_csv("FASTFormGenreTerms.csv", index=False)

# post processing
# $ sed 's/^/[/' FASTFormGenreTerms.csv > temp
# $ sed 's/$/]/' temp > FASTFormGenreTerms.csv
# delete first line
# remove quotes around terms that contain commas
# delete temp
