-- DQA_NBEW_ORGPF
CREATE OR REPLACE VIEW kis."DQA_NBEW_ORGPF"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."ORGPF" ~ '\w' THEN n."ORGPF"
        ELSE NULL
    END AS "ORGPF",
    m.long_name
  FROM kis."NBEW" n
  LEFT JOIN metadata_repository.TABLE m ON n."ORGPF" = m.sourceid
  GROUP BY n."ORGPF", m.long_name
  ORDER BY (count(n."FALNR")) DESC;
