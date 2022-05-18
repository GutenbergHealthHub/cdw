-- DQA_NORG_ORGNA
CREATE OR REPLACE VIEW kis."DQA_NORG_ORGNA"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."ORGNA" ~ '\w' THEN n."ORGNA"
        ELSE NULL
    END AS "ORGNA",
    m.long_name
  FROM kis."NORG" n
  LEFT JOIN metadata_repository.TABLE m ON n."ORGNA" = m.sourceid
  GROUP BY n."ORGNA", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

