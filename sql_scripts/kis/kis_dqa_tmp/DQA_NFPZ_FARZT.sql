-- DQA_NFPZ_FARZT
CREATE OR REPLACE VIEW kis."DQA_NFPZ_FARZT"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."FARZT" ~ '\w' THEN n."FARZT"
        ELSE NULL
    END AS "FARZT",
    m.long_name
  FROM kis."NFPZ" n
  LEFT JOIN metadata_repository.TABLE m ON n."FARZT" = m.sourceid
  GROUP BY n."FARZT", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

