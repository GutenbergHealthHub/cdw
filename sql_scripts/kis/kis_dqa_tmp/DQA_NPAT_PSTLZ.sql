-- DQA_NPAT_PSTLZ
CREATE OR REPLACE VIEW kis."DQA_NPAT_PSTLZ"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."PSTLZ" ~ '\w' THEN n."PSTLZ"
        ELSE NULL
    END AS "PSTLZ",
    m.long_name
  FROM kis."NPAT" n
  LEFT JOIN metadata_repository.TABLE m ON n."PSTLZ" = m.sourceid
  GROUP BY n."PSTLZ", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

