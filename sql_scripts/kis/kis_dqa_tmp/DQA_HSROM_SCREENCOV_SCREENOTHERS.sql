-- DQA_/HSROM/SCREENCOV_SCREENOTHERS
CREATE OR REPLACE VIEW kis."DQA_/HSROM/SCREENCOV_SCREENOTHERS"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."SCREENOTHERS" ~ '\w' THEN n."SCREENOTHERS"
        ELSE NULL
    END AS "SCREENOTHERS",
    m.hsrom_screenothers
  FROM kis."/HSROM/SCREENCOV" n
  LEFT JOIN metadata_repository.hsrom_screenothers m ON n."SCREENOTHERS" = m.sourceid
  GROUP BY n."SCREENOTHERS", m.hsrom_screenothers
  ORDER BY "QUANTITY" DESC;

