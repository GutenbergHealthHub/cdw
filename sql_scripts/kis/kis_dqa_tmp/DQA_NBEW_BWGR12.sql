-- DQA_NBEW_BWGR1
CREATE OR REPLACE VIEW kis."DQA_NBEW_BWGR12"
  AS
  select 
  count("RetrievalDate") "QUANTITY",  
  "BWGR1" || '|' || "BWGR2" "BWGR12",
  "BEWTY",
  m.bewegungstyp "Bewegungstyp"
from kis."NBEW" n 
LEFT JOIN metadata_repository.bewegungstyp m 
  ON n."BEWTY" = m.sourceid
group by "BWGR12", "BEWTY", m.bewegungstyp
order by "QUANTITY" desc, "BEWTY";

