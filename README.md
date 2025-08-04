# Introduction:
This goal of this project was to identify the job availability for data analyst jobs locally in NWA while also understanding what skills I should leverage as an aspiring data analyst by associating the top paying positions with a specefic skill for a data analyst anywhere in the world. The data was pulled from multiple online job boards to see what skllls were mentioned frequently on the applications for any data analyst roles.

# Background:
### 🔍The main questions being answered are:

  1. What is the job availability for data analysts in NWA?
  2. What skills are most in demand for data analysts in NWA?
  3. What skills are required for these top-paying analyst jobs?
  4. What are the most optimal skills to learn?
  5. What are the top-paying data analyst jobs?

# Tools Used:
### 🔧The following tools allowed me to extensively research data analyst positions:

- SQL: This tool allowed me to query large sets of data and discover what the raw metrics actually meant for insights. 
- PostgreSQL: This database management system was essential for carrying my data that I was disecting.
- VS Code: I was able to get down to the details with this management system to ask and query the right questions so I can discover the data correctly.
- Github: For this online sharing system, I was able to let other people know the power of data analysis tools.
- ChatGPT + Gemini PRO: Assisted in deriving data-driven insights and fluid data visualization.

# Analysis:
  ### 📚 1. Data analysis job availability in NWA
  To find the job availability in NWA, I needed to filter out all the data analyst jobs by location which was honed in on Bentonville, Centerton, Rogers, Fayetteville, and Springdale Arkansas. These cities encapsulate the Northwest Arkansas region which is a small metropolitan area that has seen significant growth in   the past 15 years thanks to major global retailer Walmart. 
#### This was the query I ran in VS code to obtain my results:
  ```
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
  ```
  #### Visual representation of the job availibility in NWA:
  
  <img width="3200" height="2400" alt="job_postings_dashboard_cleaned" src="https://github.com/user-attachments/assets/eff542ce-e307-42ff-8897-e7541632d8dd" />
  <img width="1000" height="800" alt="Code_Generated_Image" src="https://github.com/user-attachments/assets/fe839ecc-f521-47c5-9127-d8cf76450312" />


  #### Takeaways:
  
- Job Distribution by Location: The majority of the job postings are concentrated in Bentonville, AR, which is a major hub for corporate offices such as Walmart in the region. Fayetteville, AR, and Rogers, AR, also have a notable number of job openings, while Springdale, AR has the fewest in this dataset.

- Top Hiring Companies: Walmart is, by a significant margin, the largest employer in this dataset, with the highest number of job postings. 

Most Common Job Titles: The job titles indicate a strong demand for data professionals. Data Analyst and related roles like Senior, Data Analyst, and SAS Data Analyst, Junior are very common. There are also postings for more specialized roles like Operations Research Scientist, Data Architect, and Data Steward, as well as leadership positions like Director, Data Analytics which are at Walmart.

  ### 📊 2. Top demanded skills for data analysis jobs in NWA
  I also wanted to see which skills were in top need for the NWA area specefically. This was a good pointer to see where I should prioritize my learning to make myself as available as possible to employers. To do that I used a similar query as the previous one, but I incorperated the skills table to cross analyze the    specefic skills, job title, and locations. I also added a quick visualization of how this area compares to the rest of the United States.
 #### This is my query:
  ```
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
  ```
#### Visualization of skills in NWA and USA:

<img width="1200" height="1200" alt="unnamed" src="https://github.com/user-attachments/assets/b157d2c9-b696-49dc-993b-9090932b9dcb" />

#### Takeaways:
- Similar Skills: Both NWA and the US see high demand for SQL, Python, and Tableau. This indicates that the core skills for data analysts are consistent across both local and national levels.

- Higher Relative Demand in NWA for some skills: For certain skills like Spark, Scala, and Power BI, the demand in NWA appears to be  higher when compared to the national average. For instance, Spark, Scala, and R have a demand count of 10 in NWA, which is very close to the top skills, while in the US data, Spark and Scala have a lower relative demand.

 ### 📈 3. Top skills for highest paying data analysis jobs anywhere
  My goal was to continue the trend with discovering the patterns in NWA, but unfortunately there was no salary data provided so I decided to just see what skills were most associated with high paying data analyst jobs anywhere in the world. This was successful in finding out which skills to pursue when looking for a   data analyst to maximize profitablitiy. 
  
#### I ran the following query that included the job type, location, and salary amount:
  ```
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```
#### Visualization of top paying skills:
<img width="2301" height="1510" alt="Untitled" src="https://github.com/user-attachments/assets/e8075a0e-78a8-405e-87e4-71177f978985" />

#### Takeaways:

- The salaries in this dataset are quite high, with the median salary being over $200,000. The salaries range from approximately $184,000 to over $255,000, indicating that these are likely senior, specialized, or high-demand roles.

- Average Salary by Job Title
As expected, director-level positions command the highest salaries. The "Associate Director- Data Insights" role has the highest average salary in this dataset. Principal Data Analyst roles also rank highly, followed by marketing and hybrid/remote data analyst positions.

- Average Salary Associated with Specific Skills:
This analysis shows which skills are part of the highest-paying job postings. Skills like pyspark, jupyter, databricks, pandas, and cloud technologies like Azure and AWS are associated with the highest salaries. This suggests that roles requiring big data processing, advanced analytics, and cloud platform expertise are compensated very well.

- Most Common Skills in High-Paying Jobs:
Finally, let's look at which skills are most frequently required for the top-paying jobs in this dataset (those paying over $205,000).

- For these high-paying roles, SQL and Python are fundamental and appear in almost every listing. Tableau is also a key skill, highlighting the importance of data visualization. Following these, data engineering and processing skills like Snowflake and pandas are highly valued. This shows that top-tier data analyst roles require a strong foundation in data manipulation and programming, combined with the ability to build and manage data infrastructure and create compelling visualizations.

### 💡 4. Work from home data analysit job salary 
  This analysis was similair to the previous one except this query was specefic with only the skills and salary while only considering work from home positions. This is a good analysis because it shows the market for work from home positions is still strong even 3 years after Covid-19.

#### The following query is as follows: 
```
SELECT
    skills,
   ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25
```
#### Visualization for Remote Data Analysts:
<img width="1400" height="1200" alt="unnamed" src="https://github.com/user-attachments/assets/4679a8bf-83f7-4e8a-8057-e0049a4fee4e" />

#### Takeaways:

- Big Data Pays: The skill commanding the highest salary is Pyspark, with an average salary of over $208,000. This, along with other data processing and analysis libraries like Pandas, Numpy, and Databricks, highlights the immense value placed on analysts who can work with massive datasets.

- DevOps & MLOps Skills are Crucial: A significant number of high-paying skills are related to the software development lifecycle and operations. Tools like Bitbucket, Gitlab, Jenkins, and Kubernetes show that modern data analyst roles often overlap with data engineering and MLOps, requiring skills to version control, build, and deploy data pipelines and models.

- Specialized Platforms Drive Value: Skills in enterprise-level AI and data platforms such as Watson and Databricks are associated with high salaries, indicating that expertise in these sophisticated tools is in high demand.

- Diverse Database Knowledge: The presence of both a traditional relational database (PostgreSQL) and NoSQL databases (Couchbase, Elasticsearch) suggests that versatile data storage and retrieval skills are well-compensated.

- Cloud Expertise: Cloud computing skills, represented here by GCP (Google Cloud Platform), are essential and command high salaries as companies increasingly rely on cloud infrastructure for their data needs.

### 🧩 5. Data analyist optimal skills

```
WITH skills_demand AS(
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL 
        AND job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
),  average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg),0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY
    demand_count DESC,
    avg_salary DESC
```
# What I learned:

# Conclusions:
 It was intereting to find the Walmart has attracted a wide range of jobs and when speceifically talking about data analyst jobs it shows an increase of demand.  Walmart has attracted multiple companies to work with them and land arknasas as their home which should increase job demand for data analysis related roles. I was unforturnaly unable to find out the salary for the jobs in the surrounding NWA area because they were not listed on the applications.
