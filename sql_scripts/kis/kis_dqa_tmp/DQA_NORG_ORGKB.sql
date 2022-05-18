-- DQA_NORG_ORGKB
CREATE OR REPLACE VIEW kis."DQA_NORG_ORGKB"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."ORGKB" ~ '\w' THEN n."ORGKB"
        ELSE NULL
    END AS "ORGKB",
    m.long_name
  FROM kis."NORG" n
  LEFT JOIN metadata_repository.TABLE m ON n."ORGKB" = m.sourceid
  GROUP BY n."ORGKB", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

