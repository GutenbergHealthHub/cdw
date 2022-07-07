-- DQA_/HSROM/SCREENCOV_SCREENVACCSTAT
CREATE OR REPLACE VIEW kis."DQA_/HSROM/SCREENCOV_SCREENVACCSTAT"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."SCREENVACCSTAT" ~ '\w' THEN n."SCREENVACCSTAT"
        ELSE NULL
    END AS "SCREENVACCSTAT",
    m.hsrom_screenvaccstat
  FROM kis."/HSROM/SCREENCOV" n
  LEFT JOIN metadata_repository.hsrom_screenvaccstat m ON n."SCREENVACCSTAT" = m.sourceid
  GROUP BY n."SCREENVACCSTAT", m.hsrom_screenvaccstat
  ORDER BY "QUANTITY" DESC;

