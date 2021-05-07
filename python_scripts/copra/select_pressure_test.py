print("copy (")
for year in range(2007, 2022):
  for month in range(1, 13):
      print("select * from \n   (select * from copra.co6_medic_pressure where date_part('year', entrytime) = ",year, " and date_part('month', entrytime) = ",month, " limit 100) as m"+str(year)+str(month)+" \n   union")
print(") to '/media/db/cdw_database/copra_pressure_test.csv'")
