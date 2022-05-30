-- DQA_NFAL_ENDTYP
CREATE OR REPLACE VIEW kis."DQA_NFAL_ENDTYP"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."ENDTYP" ~ '\w' THEN n."ENDTYP"
        ELSE NULL
    END AS "ENDTYP"/*,
    m.long_name*/
  FROM kis."NFAL" n
  --LEFT JOIN metadata_repository.TABLE m ON n."ENDTYP" = m.sourceid
  GROUP BY n."ENDTYP"--, m.long_name
  ORDER BY "QUANTITY" DESC;

