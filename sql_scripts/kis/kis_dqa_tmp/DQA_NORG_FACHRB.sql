-- DQA_NORG_FACHRB
CREATE OR REPLACE VIEW kis."DQA_NORG_FACHRB"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."FACHRB" ~ '\w' THEN n."FACHRB"
        ELSE NULL
    END AS "FACHRB",
    m.long_name
  FROM kis."NORG" n
  LEFT JOIN metadata_repository.TABLE m ON n."FACHRB" = m.sourceid
  GROUP BY n."FACHRB", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

