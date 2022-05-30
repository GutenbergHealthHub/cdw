-- DQA_NORG_ORGID
CREATE OR REPLACE VIEW kis."DQA_NORG_ORGID"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."ORGID" ~ '\w' THEN n."ORGID"
        ELSE NULL
    END AS "ORGID"/*,
    m.long_name*/
  FROM kis."NORG" n
  --LEFT JOIN metadata_repository.TABLE m ON n."ORGID" = m.sourceid
  GROUP BY n."ORGID"--, m.long_name
  ORDER BY "QUANTITY" DESC;

