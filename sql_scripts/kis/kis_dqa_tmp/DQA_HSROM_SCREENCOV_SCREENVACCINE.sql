-- DQA_/HSROM/SCREENCOV_SCREENVACCINE
CREATE OR REPLACE VIEW kis."DQA_/HSROM/SCREENCOV_SCREENVACCINE"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."SCREENVACCINE" ~ '\w' THEN n."SCREENVACCINE"
        ELSE NULL
    END AS "SCREENVACCINE",
    m.vaccine,
    m.manufacturer
  FROM kis."/HSROM/SCREENCOV" n
  LEFT JOIN metadata_repository.covid19_vaccine m ON n."SCREENVACCINE" = m.sourceid
  GROUP BY n."SCREENVACCINE", m.vaccine, m.manufacturer, m.description
  ORDER BY "QUANTITY" DESC;

