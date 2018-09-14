#! python

import pandas as pd
f=pd.read_csv("tgmLabels.csv")
keep_col = ['[label]']
new_f = f[keep_col]
new_f.to_csv("tgmTerms.csv", index=False)
