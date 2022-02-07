create view copra.config_pseudo
as
select 
  id, 
  name, 
  description, 
  co6_config_variabletypes_id,
  parent,
  case 
    when name ~*'name|mail|efon|versic|stras|rede|chrift|fax|atzi|geber|nym' and name !~* 'medik|atmu|mikro|puter' then 'l' 
  	when name ~* 'datum|geburt' then 'v'
  	else null
  end "action"
from copra.co6_config_variables 
where co6_config_variabletypes_id in (3, 17, 5) -- 3 = String, 17 = FixedDateTime, 5 = DateTime
and parent in (1, 20) -- 1 = Patient, 20 = Fall
order by parent, name
;
