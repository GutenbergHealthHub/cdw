-- DQA_NORG_FACHR6
CREATE OR REPLACE VIEW kis."DQA_NORG_FACHR6"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."FACHR6" ~ '\w' THEN n."FACHR6"
        ELSE NULL
    END AS "FACHR6",
    m.long_name
  FROM kis."NORG" n
  LEFT JOIN metadata_repository.TABLE m ON n."FACHR6" = m.sourceid
  GROUP BY n."FACHR6", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

