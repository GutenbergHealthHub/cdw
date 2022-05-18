-- DQA_NORG_FACHRD
CREATE OR REPLACE VIEW kis."DQA_NORG_FACHRD"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."FACHRD" ~ '\w' THEN n."FACHRD"
        ELSE NULL
    END AS "FACHRD",
    m.long_name
  FROM kis."NORG" n
  LEFT JOIN metadata_repository.TABLE m ON n."FACHRD" = m.sourceid
  GROUP BY n."FACHRD", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

