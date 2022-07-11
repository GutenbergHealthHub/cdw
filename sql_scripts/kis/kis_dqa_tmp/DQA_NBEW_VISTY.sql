-- DQA_NBEW_VISTY

drop view kis."DQA_NBEW_VISTY";

CREATE OR REPLACE VIEW kis."DQA_NBEW_VISTY"
 AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    "VISTY",
    m.besuchtyp
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.besuchtyp m ON n."VISTY" = m.sourceid
  GROUP BY n."VISTY", m.besuchtyp
  ORDER BY "QUANTITY" DESC;

