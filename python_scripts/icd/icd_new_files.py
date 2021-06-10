import pandas as pd
for i in range(2013,2022):
  icdToRead = 'icd' + str(i)
  df = pd.read_csv(icdToRead, sep = ';', header = None) #print('df = pd.read_csv(' + icdToRead + ', sep = \';\', header = None)') 
  df.iloc[:,[5,6,7,8,12,13]].to_csv('toPostgres/' + icdToRead + '.csv', sep = ';', index = False, header = None) # print('df.iloc[:,[6,7,8,9,10]].to_csv(' + 'toPostgres/' + icdToRead + '.csv' + ', sep = \';\', index = False, header = None)') 
