-- DQA_NPAT_GEBIE
CREATE OR REPLACE VIEW kis."DQA_NPAT_GEBIE"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."GEBIE" ~ '\w' THEN n."GEBIE"
        ELSE NULL
    END AS "GEBIE",
    m.long_name
  FROM kis."NPAT" n
  LEFT JOIN metadata_repository.TABLE m ON n."GEBIE" = m.sourceid
  GROUP BY n."GEBIE", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

