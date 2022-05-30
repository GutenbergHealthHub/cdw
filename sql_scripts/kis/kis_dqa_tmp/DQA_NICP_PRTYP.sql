-- DQA_NICP_PRTYP
CREATE OR REPLACE VIEW kis."DQA_NICP_PRTYP"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."PRTYP" ~ '\w' THEN n."PRTYP"
        ELSE NULL
    END AS "PRTYP"/*,
    m.long_name*/
  FROM kis."NICP" n
  --LEFT JOIN metadata_repository.TABLE m ON n."PRTYP" = m.sourceid
  GROUP BY n."PRTYP"--, m.long_name
  ORDER BY "QUANTITY" DESC;

