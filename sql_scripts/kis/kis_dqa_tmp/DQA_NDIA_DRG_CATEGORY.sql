-- DQA_NDIA_DRG_CATEGORY

--drop view kis."DQA_NDIA_DRG_CATEGORY";

CREATE OR REPLACE VIEW kis."DQA_NDIA_DRG_CATEGORY"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."DRG_CATEGORY" ~ '\w' THEN n."DRG_CATEGORY"
        ELSE NULL
    END AS "DRG_CATEGORY",
    m.diagnosis_type drg_category
  FROM kis."NDIA" n
  LEFT JOIN metadata_repository.diagnosis_type m ON n."DRG_CATEGORY" = m.sourceid
  GROUP BY n."DRG_CATEGORY", m.diagnosis_type
  ORDER BY "QUANTITY" DESC;

