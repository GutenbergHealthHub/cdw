-- DQA_NDIA_DIAGW
CREATE OR REPLACE VIEW kis."DQA_NDIA_DIAGW"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."DIAGW" ~ '\w' THEN n."DIAGW"
        ELSE NULL
    END AS "DIAGW",
    m.long_name
  FROM kis."NDIA" n
  LEFT JOIN metadata_repository.TABLE m ON n."DIAGW" = m.sourceid
  GROUP BY n."DIAGW", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

