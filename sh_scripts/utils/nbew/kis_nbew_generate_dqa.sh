echo "-- DQA Views für KIS.NBEW"

echo "--drop view if exists kis.dqa_nbew_null_values cascade;"
echo "--create or replace view kis.dqa_nbew_null_values"
echo "--as"
while read line; do
  echo select 
  echo "  count(n.falnr) quantity,"
  echo "  '$line' \"columns\""
  echo "from kis.nbew n"
  echo "where $line isnull or $line !~'^\\w'"
  echo "  union"
done < nbew.txt
echo "order by quantity, \"columns\""
echo ";"

while read line; do
  echo ""
  echo "--$line"
  echo "--drop view if exists kis.dqa_nbew_$line cascade;"
  echo "--create or replace view kis.dqa_nicp_$line"
  echo "--as"
  echo select 
  echo "  count(falnr) quantity,"
  echo "  case"
  echo "    when n.$line ~'^\\w' then n.$line"
  echo "    else null"
  echo "  end $line"
  echo "from kis.nbew n"
  echo "group by n.$line"
  echo "--left join metadata_repository.$line mr"
  echo "--  on mr.sourceid = n.$line"
  echo "order by quantity desc"
  echo ";"

  echo ""
  echo "-- $line Jahr"
  echo "--drop view if exists kis.dqa_nbew_${line}_jahr cascade;"
  echo "--create or replace view kis.dqa_nbew_${line}_jahr"
  echo "--as"
  echo select
  echo "  date_part('year', erdat) jahr,"
  echo "  count(falnr) quantity,"
  echo "  case"
  echo "    when n.$line ~'^\\w' then n.$line"
  echo "    else null"
  echo "  end $line"
  echo "from kis.nbew n"
  echo "-- left join metadata_repository.$line mr"
  echo "--    on mr.sourceid = n.$line"
  echo "group by jahr, n.$line"
  echo "order by jahr, quantity desc"
  echo ";"
done < nbew.txt
