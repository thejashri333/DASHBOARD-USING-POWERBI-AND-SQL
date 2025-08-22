/*gender*/
SELECT gender, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY gender;

/*race*/
Select race, COUNT(*) AS count
from hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY race
order by count(*)DESC;

/*age group*/
SELECT 
min(age) AS young,
max(age)AS elder
FROM hr
WHERE age >= 18 AND termdate IS NULL;
SELECT 
	case  
		when age >=18 AND age <=24 then '18-24'
		when age >=25 AND age <=34 then '25-34'
		when age >=35 AND age <=44 then '35-44'
		when age >=45 AND age <=54 then '45-54'
		when age >=55 AND age <=64 then '55-64'
		else'65+'
	end as age_group,
	count(*) as count
from hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY age_group
order by age_group;

/* age group by gender*/
SELECT 
	case  
		when age >=18 AND age <=24 then '18-24'
		when age >=25 AND age <=34 then '25-34'
		when age >=35 AND age <=44 then '35-44'
		when age >=45 AND age <=54 then '45-54'
		when age >=55 AND age <=64 then '55-64'
		else'65+'
	end as age_group, gender,
	count(*) as count
from hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY age_group, gender
order by age_group, gender;

/*location*/
select location ,  count(*) as count
from hr
WHERE age >= 18 AND termdate IS NULL
group by location;

/*avg lengthof employee terminated */
SELECT round(AVG(
    DATEDIFF(
        IFNULL(termdate, CURDATE()), 
        hire_date
    )
)/365,0) AS avg_length
FROM hr
WHERE age >= 18;

/*gender department*/
select department ,gender, count(*) as count
from hr 
WHERE age >= 18 AND termdate IS NULL
group by  department, gender
order by department;

/*jobtitle*/
select jobtitle , count(*) as count
from hr
WHERE age >= 18 AND termdate IS NULL
group by jobtitle
order by jobtitle desc;

/*turnover rate*/
SELECT department, 
       total_count, 
       terminated_count,
       terminated_count / total_count AS termination_rate
FROM (
    SELECT department, 
           COUNT(*) AS total_count, 
           SUM(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() 
                    THEN 1 ELSE 0 END) AS terminated_count
    FROM hr
    WHERE age >= 18
    GROUP BY department
) AS subquery
ORDER BY termination_rate DESC;


/*states*/
select location_state, count(*) as count
from hr 
WHERE age >= 18 AND termdate IS NULL
group by  location_state
order by count desc;


/*states*/
select location_state, count(*) as count
from hr 
WHERE age >= 18 AND termdate IS NULL
group by  location_state
order by count desc;

/*net change percent*/
SELECT year,
       hires,
       terminations,
       hires - terminations AS net_changes,
       ROUND((hires - terminations) / hires * 100, 2) AS net_change_percent
FROM (
    SELECT YEAR(hire_date) AS year,
           COUNT(*) AS hires,
           SUM(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE()
                    THEN 1 ELSE 0 END) AS terminations
    FROM hr
    WHERE age >= 18
    GROUP BY YEAR(hire_date)
) AS subquery
ORDER BY year ASC;


/*avg_tenure*/
SELECT department,
       ROUND(AVG(DATEDIFF(CURDATE(), hire_date) / 365), 0) AS avg_tenure
FROM hr
WHERE termdate IS NULL
      AND age >= 18
GROUP BY department;


