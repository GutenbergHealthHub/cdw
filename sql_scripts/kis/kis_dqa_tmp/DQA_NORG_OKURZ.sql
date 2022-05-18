-- DQA_NORG_OKURZ
CREATE OR REPLACE VIEW kis."DQA_NORG_OKURZ"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."OKURZ" ~ '\w' THEN n."OKURZ"
        ELSE NULL
    END AS "OKURZ",
    m.long_name
  FROM kis."NORG" n
  LEFT JOIN metadata_repository.TABLE m ON n."OKURZ" = m.sourceid
  GROUP BY n."OKURZ", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

