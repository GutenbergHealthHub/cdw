-- DQA_NICP_ICPML
CREATE OR REPLACE VIEW kis."DQA_NICP_ICPML"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."ICPML" ~ '\w' THEN n."ICPML"
        ELSE NULL
    END AS "ICPML",
    m.long_name
  FROM kis."NICP" n
  LEFT JOIN metadata_repository.TABLE m ON n."ICPML" = m.sourceid
  GROUP BY n."ICPML", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

