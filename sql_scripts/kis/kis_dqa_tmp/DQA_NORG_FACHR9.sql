-- DQA_NORG_FACHR9
CREATE OR REPLACE VIEW kis."DQA_NORG_FACHR9"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."FACHR9" ~ '\w' THEN n."FACHR9"
        ELSE NULL
    END AS "FACHR9",
    m.long_name
  FROM kis."NORG" n
  LEFT JOIN metadata_repository.TABLE m ON n."FACHR9" = m.sourceid
  GROUP BY n."FACHR9", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

