-- DQA_NBEW_RFSRC
CREATE OR REPLACE VIEW kis."DQA_NBEW_RFSRC"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."RFSRC" ~ '\w' THEN n."RFSRC"
        ELSE NULL
    END AS "RFSRC",
    m.einweisungs_ueberweisungs_nachbehandlungsart
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.einweisungs_ueberweisungs_nachbehandlungsart m ON n."RFSRC" = m.sourceid
  GROUP BY n."RFSRC", m.einweisungs_ueberweisungs_nachbehandlungsart
  ORDER BY "QUANTITY" DESC;