-- DQA_NBEW_PLANR

--drop view kis."DQA_NBEW_PLANR";
CREATE OR REPLACE VIEW kis."DQA_NBEW_PLANR"
 AS
  SELECT 
    count(n."RetrievalDate") AS "QUANTITY",
	"PLANR",
    m.plankennzeichen_raum_zuweisung
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.plankennzeichen_raum_zuweisung m ON n."PLANR" = m.sourceid
  GROUP BY n."PLANR", m.plankennzeichen_raum_zuweisung
  ORDER BY "QUANTITY" DESC;

