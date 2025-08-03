/*
How many data anaylst jobs were available in Northwest Arkansas in 2023?
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM   
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location IN ('Rogers, AR', 'Bentonville, AR','Springdale, AR','Centerton, AR', 'Fayetteville, AR')
ORDER BY    
    salary_year_avg DESC
