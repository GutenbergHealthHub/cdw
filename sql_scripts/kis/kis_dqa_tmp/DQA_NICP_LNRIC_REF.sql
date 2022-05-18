-- DQA_NICP_LNRIC_REF
CREATE OR REPLACE VIEW kis."DQA_NICP_LNRIC_REF"
  AS
  SELECT count(n.FALNR) AS "QUANTITY",
    CASE
      WHEN n."LNRIC_REF" ~ '\w' THEN n."LNRIC_REF"
        ELSE NULL
    END AS "LNRIC_REF",
    m.long_name
  FROM kis."NICP" n
  LEFT JOIN metadata_repository.TABLE m ON n."LNRIC_REF" = m.sourceid
  GROUP BY n."LNRIC_REF", m.long_name
  ORDER BY (count(n."FALNR")) DESC;

