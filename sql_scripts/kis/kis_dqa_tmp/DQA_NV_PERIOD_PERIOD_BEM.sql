-- DQA_NV_PERIOD_PERIOD_BEM
CREATE OR REPLACE VIEW kis."DQA_NV_PERIOD_PERIOD_BEM"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."PERIOD_BEM" ~ '\w' THEN n."PERIOD_BEM"
        ELSE NULL
    END AS "PERIOD_BEM",
    m.long_name
  FROM kis."NV_PERIOD" n
  LEFT JOIN metadata_repository.TABLE m ON n."PERIOD_BEM" = m.sourceid
  GROUP BY n."PERIOD_BEM", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

