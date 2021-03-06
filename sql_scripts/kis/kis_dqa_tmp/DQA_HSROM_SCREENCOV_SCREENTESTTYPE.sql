-- DQA_/HSROM/SCREENCOV_SCREENTESTTYPE
CREATE OR REPLACE VIEW kis."DQA_/HSROM/SCREENCOV_SCREENTESTTYPE"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."SCREENTESTTYPE" ~ '\w' THEN n."SCREENTESTTYPE"
        ELSE NULL
    END AS "SCREENTESTTYPE",
    m.hsrom_screentesttype
  FROM kis."/HSROM/SCREENCOV" n
  LEFT JOIN metadata_repository.hsrom_screentesttype m ON n."SCREENTESTTYPE" = m.sourceid
  GROUP BY n."SCREENTESTTYPE", m.hsrom_screentesttype
  ORDER BY "QUANTITY" DESC;

