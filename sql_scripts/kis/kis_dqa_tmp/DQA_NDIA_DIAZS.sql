-- DQA_NDIA_DIAZS

drop view kis."DQA_NDIA_DIAZS";
CREATE OR REPLACE VIEW kis."DQA_NDIA_DIAZS"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."DIAZS" ~ '\w' THEN n."DIAZS"
        ELSE NULL
    END AS "DIAZS",
    m.diagnosenzusatz
  FROM kis."NDIA" n
  LEFT JOIN metadata_repository.diagnosenzusatz m ON n."DIAZS" = m.sourceid
  GROUP BY n."DIAZS", m.diagnosenzusatz  
  ORDER BY "QUANTITY" DESC;

