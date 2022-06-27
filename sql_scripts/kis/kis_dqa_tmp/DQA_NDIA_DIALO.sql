-- DQA_NDIA_DIALO
CREATE OR REPLACE VIEW kis."DQA_NDIA_DIALO"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."DIALO" ~ '\w' THEN n."DIALO"
        ELSE NULL
    END AS "DIALO",
    m.localisation
  FROM kis."NDIA" n
  LEFT JOIN metadata_repository.body_localisation m ON n."DIALO" = m.sourceid
  GROUP BY n."DIALO", m.localisation
  ORDER BY "QUANTITY" DESC;

