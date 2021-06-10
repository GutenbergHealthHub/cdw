import pandas as pd
norg = pd.read_csv('/media/db/cdw_files/kis/NORG.txt', sep='\t', dtype=str)
norg = norg[['EINRI','ORGID','ORGTY','ORGNA','ORGKB','OKURZ', 'FACHR', 'FACHR2', 'AUFKZ', 'INTEN', 'FACHR9', 'PAEDKZ', 'FACHR1']]
print(norg.head(20))
norg.to_csv('/media/db/cdw_files/kis/norg.csv', index = False, sep = ';')
