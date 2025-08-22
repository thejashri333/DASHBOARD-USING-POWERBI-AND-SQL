CREATE DATABASE IF NOT EXISTS projects;
USE projects;

SELECT * FROM hr LIMIT 10;

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hr;

SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
    WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date = CASE
    WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

UPDATE hr
SET termdate = NULL
WHERE termdate = '' OR termdate = 'NULL';

UPDATE hr
SET termdate = STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC')
WHERE termdate LIKE '%UTC';

UPDATE hr
SET termdate = STR_TO_DATE(termdate, '%Y-%m-%dT%H:%i:%sZ')
WHERE termdate LIKE '%T%';

UPDATE hr
SET termdate = STR_TO_DATE(termdate, '%m/%d/%Y %H:%i')
WHERE termdate LIKE '%/%';

UPDATE hr
SET termdate = STR_TO_DATE(termdate, '%Y-%m-%d')
WHERE termdate IS NOT NULL 
  AND termdate NOT LIKE '%UTC%' 
  AND termdate NOT LIKE '%T%' 
  AND termdate LIKE '____-__-__';

UPDATE hr
SET termdate = NULL
WHERE termdate = '0000-00-00'
   OR termdate IN ('1900-01-01','1970-01-01')
   OR LOWER(termdate) = 'null'
   OR termdate > CURDATE();

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE())
WHERE birthdate IS NOT NULL;

DELETE FROM hr
WHERE age < 0;

SELECT MIN(age) AS youngest, MAX(age) AS oldest FROM hr;

SELECT COUNT(*) FROM hr WHERE age < 18;

SELECT COUNT(*) FROM hr WHERE termdate IS NOT NULL;

SELECT DISTINCT termdate 
FROM hr 
WHERE termdate IS NOT NULL 
ORDER BY termdate ASC 
LIMIT 20;

SELECT DISTINCT location FROM hr;
describe hr;
