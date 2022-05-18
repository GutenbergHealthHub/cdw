-- DQA_NORG_FACHR4
CREATE OR REPLACE VIEW kis."DQA_NORG_FACHR4"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."FACHR4" ~ '\w' THEN n."FACHR4"
        ELSE NULL
    END AS "FACHR4",
    m.long_name
  FROM kis."NORG" n
  LEFT JOIN metadata_repository.TABLE m ON n."FACHR4" = m.sourceid
  GROUP BY n."FACHR4", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

