ALTER TABLE source DELETE WHERE value = '{"category":"education","type":"payment","index":3,"id":"recipe1","money":10000,"date":"2021-01-01","purpose":"подкуп преподавателя"}';

INSERT INTO source (value) VALUES ('{"category":"education","type":"payment","index":3,"id":"recipe1","money":50000,"date":"2021-01-01","purpose":"подкуп преподавателя"}');
