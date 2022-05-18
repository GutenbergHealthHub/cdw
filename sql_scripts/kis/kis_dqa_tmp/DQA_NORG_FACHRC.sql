-- DQA_NORG_FACHRC
CREATE OR REPLACE VIEW kis."DQA_NORG_FACHRC"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."FACHRC" ~ '\w' THEN n."FACHRC"
        ELSE NULL
    END AS "FACHRC",
    m.long_name
  FROM kis."NORG" n
  LEFT JOIN metadata_repository.TABLE m ON n."FACHRC" = m.sourceid
  GROUP BY n."FACHRC", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

