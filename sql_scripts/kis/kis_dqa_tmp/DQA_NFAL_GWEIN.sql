-- DQA_NFAL_GWEIN
CREATE OR REPLACE VIEW kis."DQA_NFAL_GWEIN"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."GWEIN" ~ '\w' THEN n."GWEIN"
        ELSE NULL
    END AS "GWEIN",
    m.long_name
  FROM kis."NFAL" n
  LEFT JOIN metadata_repository.TABLE m ON n."GWEIN" = m.sourceid
  GROUP BY n."GWEIN", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

