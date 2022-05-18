-- DQA_NORG_FACHR5
CREATE OR REPLACE VIEW kis."DQA_NORG_FACHR5"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."FACHR5" ~ '\w' THEN n."FACHR5"
        ELSE NULL
    END AS "FACHR5",
    m.long_name
  FROM kis."NORG" n
  LEFT JOIN metadata_repository.TABLE m ON n."FACHR5" = m.sourceid
  GROUP BY n."FACHR5", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

