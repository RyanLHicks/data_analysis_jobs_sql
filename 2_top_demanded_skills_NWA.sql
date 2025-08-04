/* Top in demand skills for data analysts in NWA

*/


SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location IN ('Rogers, AR', 'Bentonville, AR','Springdale, AR','Centerton, AR', 'Fayetteville, AR')
GROUP BY
    skills
ORDER BY 
    demand_count DESC
LIMIT 5
