-- DQA_NICP_ORGFA
CREATE OR REPLACE VIEW kis."DQA_NICP_ORGFA"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."ORGFA" ~ '\w' THEN n."ORGFA"
        ELSE NULL
    END AS "ORGFA",
    m.long_name
  FROM kis."NICP" n
  LEFT JOIN metadata_repository.TABLE m ON n."ORGFA" = m.sourceid
  GROUP BY n."ORGFA", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

