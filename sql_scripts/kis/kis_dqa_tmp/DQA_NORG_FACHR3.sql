-- DQA_NORG_FACHR3
CREATE OR REPLACE VIEW kis."DQA_NORG_FACHR3"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."FACHR3" ~ '\w' THEN n."FACHR3"
        ELSE NULL
    END AS "FACHR3",
    m.long_name
  FROM kis."NORG" n
  LEFT JOIN metadata_repository.TABLE m ON n."FACHR3" = m.sourceid
  GROUP BY n."FACHR3", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

