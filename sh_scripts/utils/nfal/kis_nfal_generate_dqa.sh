echo "--create or replace view kis.dqa_nfal_null_values"
echo "--as"
while read line; do
  echo select 
  echo "  count(falnr) quantity,"
  echo "  '$line' \"columns\""
  echo "from kis.nfal n"
  echo "where $line isnull or $line !~'^\\w'"
  echo "  union"
done < nfal.txt
echo "order by quantity, \"columns\""
echo ";"

while read line; do
  echo ""
  echo "--$line"
  echo "--drop view if exists kis.dqa_nfal_$line cascade;"
  echo "--create or replace view kis.dqa_nfal_$line"
  echo "--as"
  echo select 
  echo "  count(falnr) quantity,"
  echo "  case"
  echo "    when n.$line ~'^\\w' then n.$line"
  echo "    else null"
  echo "  end $line"
  echo "from kis.nfal n"
  echo "group by n.$line"
  echo "order by quantity desc"
  echo ";"

  echo ""
  echo "--drop view if exists kis.dqa_nfal_${line}_jahr cascade;"
  echo "--create or replace view kis.dqa_nfal_${line}_jahr"
  echo "--as"
  echo select
  echo "  case"
  echo "    when erdat isnull then date_part('year', updat)"
  echo "    else date_part('year', erdat)"
  echo "  end jahr,"
  echo "  count(falnr) quantity,"
  echo "  case"
  echo "    when n.$line ~'^\\w' then n.$line"
  echo "    else null"
  echo "  end $line"
  echo "from kis.nfal n"
  echo "group by jahr, n.$line"
  echo "order by jahr, quantity desc"
  echo ";"
done < nfal.txt
