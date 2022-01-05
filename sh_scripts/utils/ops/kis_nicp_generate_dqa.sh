echo "--create or replace view kis.dqa_nicp_null_values"
echo "--as"
while read line; do
  echo select 
  echo "  count(falnr) quantities,"
  echo "  '$line' \"columns\""
  echo "from kis.nicp n"
  echo "where $line isnull or $line !~'^\\w'"
  echo "  union"
done < nicp.txt
echo "order by quantities, \"columns\""
echo ";"

while read line; do
  echo ""
  echo "--$line"
  echo "--drop view if exists kis.dqa_nicp_$line cascade;"
  echo "--create or replace view kis.dqa_nicp_$line"
  echo "--as"
  echo select 
  echo "  count(falnr) quantities,"
  echo "  case"
  echo "    when n.$line ~'^\\w' then n.$line"
  echo "    else null"
  echo "  end $line"
  echo "from kis.nicp n"
  echo "group by n.$line"
  echo "order by quantities desc"
  echo ";"

  echo ""
  echo "--drop view if exists kis.dqa_nicp_${line}_jahr cascade;"
  echo "--create or replace view kis.dqa_nicp_${line}_jahr"
  echo "--as"
  echo select
  echo "  date_part('year', updat) jahr,"
  echo "  count(falnr) quantities,"
  echo "  case"
  echo "    when n.$line ~'^\\w' then n.$line"
  echo "    else null"
  echo "  end $line"
  echo "from kis.nicp n"
  echo "group by jahr, n.$line"
  echo "order by jahr, quantities desc"
  echo ";"
done < nicp.txt
