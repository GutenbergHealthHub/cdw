-- DQA_NFAL_FGTYP
CREATE OR REPLACE VIEW kis."DQA_NFAL_FGTYP"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."FGTYP" ~ '\w' THEN n."FGTYP"
        ELSE NULL
    END AS "FGTYP"/*,
    m.long_name*/
  FROM kis."NFAL" n
  --LEFT JOIN metadata_repository.TABLE m ON n."FGTYP" = m.sourceid
  GROUP BY n."FGTYP"--, m.long_name
  ORDER BY "QUANTITY" DESC;

