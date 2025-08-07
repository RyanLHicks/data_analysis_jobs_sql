# Introduction:
The goal of this project was to identify the job availability for data analyst jobs locally in NWA while also understanding what skills I should leverage as an aspiring data analyst by associating the top paying positions with a specific skill for a data analyst anywhere in the world. The data was pulled from multiple online job boards to see what skills were mentioned frequently on the applications for any data analyst roles. I also want to have a better understanding of how SQL works in a practical sense and apply it to real life questions that individuals or companies may have. I will continue learning the various applications to SQL and how it leads to important decisions that affect the bottom line.

# Background:
### 🔍The main questions being answered are:

1.	What is the job availability for data analysts in NWA?
2.	What skills are most in demand for data analysts in NWA?
3.	What skills are required for these top-paying analyst jobs?
4.	What are the most optimal skills to learn?
5.	What is the top-paying data analyst jobs?

# Tools Used:
### 🔧The following tools allowed me to extensively research data analyst positions:

-	SQL: This tool allowed me to query large sets of data and discover what the raw metrics meant for insights.
- PostgreSQL: This database management system was essential for carrying my data that I was dissecting.
-	VS Code: I was able to get down to the details with this management system to ask and query the right questions so I can discover the data correctly.
-	GitHub: For this online sharing system, I was able to let other people know the power of data analysis tools.
-	ChatGPT + Gemini PRO: Assisted in deriving data-driven insights and fluid data visualization.


# Analysis:
  ### 📚1. Data analysis job availability in NWA
  
To find the job availability in NWA, I needed to filter out all the data analyst jobs by location which was exclusive to Bentonville, Centerton, Rogers, Fayetteville, and Springdale Arkansas. These cities encapsulate the Northwest Arkansas region, which is a small metropolitan area that has seen significant growth in the past 15 years thanks to major global retailer, Walmart.

#### This was the query I ran in VS code to obtain my results:
  ```sql
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
  #### Visual Representation of Data Analyst Availibility in NWA:
  
  <img width="3200" height="2400" alt="job_postings_dashboard_cleaned" src="https://github.com/user-attachments/assets/eff542ce-e307-42ff-8897-e7541632d8dd" />
  <img width="1000" height="800" alt="Code_Generated_Image" src="https://github.com/user-attachments/assets/fe839ecc-f521-47c5-9127-d8cf76450312" />


  #### Takeaways:
  
- Job Distribution in NWA: Most of the job postings are concentrated in Bentonville, AR, which is a major hub for corporate offices such as Walmart. Fayetteville, AR, and Rogers, AR also have a notable number of job openings, while Springdale, AR has the fewest in this area.
- Top Hiring Companies: Walmart is, by a significant margin, the largest employer in this area. 
- Most Common Job Titles: The job titles indicate a strong demand for data professionals. Data Analyst and related roles like Senior, Data Analyst, and SAS Data Analyst, Junior are very common. There are also postings for more specialized roles like Operations Research Scientist, Data Architect, and Data Steward, as well as leadership positions like Director, Data Analytics which are at Walmart from my own personal experience looking for positions.

### 📊2. Top demanded skills for data analysis jobs in NWA
I also wanted to see which skills were in top need for the NWA area specifically. This was a good pointer to see where I should prioritize my learning to make myself as available as possible to employers. To do that I used a similar query as the previous one, but I incorporated the skills table to cross analyze the specific skills, job title, and locations. I also added a quick visualization of how this area compares to the rest of the United States.

 #### This is my query:
  ```sql
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
- Higher Relative Demand in NWA for some skills: For certain skills like Spark, Scala, and Power BI, the demand in NWA appears to be higher when compared to the national average. For instance, Spark, Scala, and R have a demand count of 10 in NWA, which is very close to the top skills, while in the US data, Spark and Scala have a lower relative demand. It is also important to note that programs like Spark and Scala are niche skills and their demand in this area.

### 📈3. Top skills for highest paying data analysis jobs anywhere
  My goal was to continue the trend with discovering the patterns in NWA, but unfortunately there was no salary data provided so I decided to just see what skills were most associated with high paying data analyst jobs anywhere in the world. This was successful in finding out which skills to pursue when looking for a   data analyst to maximize profitability. 
  
#### I ran the following query that included the job type, location, and salary amount:
  ```sql
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

<img width="1200" height="800" alt="unnamed" src="https://github.com/user-attachments/assets/c659370b-bdfa-4ba1-b639-babb4487be1a" />

#### Takeaways:

- The salaries in this dataset are quite high, with the median salary being over $200,000. The salaries range from approximately $184,000 to over $255,000, indicating that these are likely senior, specialized, or high-demand roles.

- Average Salary by Job Title: As expected, director-level positions command the highest salaries. The "Associate Director- Data Insights" role has the highest average salary in this dataset. Principal Data Analyst roles also rank highly, followed by marketing and hybrid/remote data analyst positions.
- Average Salary Associated with Specific Skills:
This analysis shows which skills are part of the highest-paying job postings. Skills like pyspark, jupyter, databricks, pandas, and cloud technologies like Azure and AWS are associated with the highest salaries. This suggests that roles requiring big data processing, advanced analytics, and cloud platform expertise are compensated very well.
- Most Common Skills in High-Paying Jobs:
Finally, let's look at which skills are most frequently required for the top-paying jobs in (those paying over $205,000).
- For these high-paying roles, SQL and Python are fundamental and appear in almost every listing. Tableau is also a key skill, highlighting the importance of data visualization. Following these, data engineering and processing skills like Snowflake and pandas are highly valued. This shows that top-tier data analyst roles require a strong foundation in data manipulation and programming, combined with the ability to build and manage data infrastructure and create compelling visualizations.

### 💡4. Work from home data analyst job salary 
  This analysis was like the previous one except this query was specific with only the skills and salary while only considering work from home positions. This is a good analysis because it shows the market for work from home positions is still strong, even 3 years after Covid-19.
  
#### The following query is as follows: 
```sql
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
- DevOps & MLOps Skills are Crucial: A significant number of high-paying skills are related to software development lifecycle and operations. Tools like Bitbucket, Gitlab, Jenkins, and Kubernetes show that modern data analyst roles often overlap with data engineering and MLOps, requiring skills to control, build, and deploy data pipelines and models.
- Specialized Platforms Drive Value: Skills in enterprise-level AI and data platforms such as Watson and Databricks are associated with high salaries, indicating that expertise in these sophisticated tools is in high demand. I can also note through my current job search in the NWA area a lot of suppliers for walmart require or highly suggest having retail link experience which is a program for suppliers by Walmart to monitor their own sales data to make informed decisions about their product line.
- Diverse Database Knowledge: The presence of both a traditional relational database (PostgreSQL) and NoSQL databases (Couchbase, Elasticsearch) suggests that versatile data storage and retrieval skills are well-compensated.
- Cloud Expertise: Cloud computing skills, represented here by the Google Cloud Platform, are essential and command high salaries as companies increasingly rely on cloud infrastructure for their data needs.

### 🧩5. Data analyist optimal skills
The goal for this section was to meet the skills demand to the average salary table and find any correlations between those two attributes. This was incredibly insightful to cross analyze and reach conclusions on what I should spend my time learning rather than shooting blind at a target.             

```sql
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
#### Visualization for Optimal Data Analyst Skills:

<img width="1200" height="800" alt="unnamed" src="https://github.com/user-attachments/assets/1d216e7f-ded6-484b-a348-4659987d27ea" />
<img width="1200" height="800" alt="unnamed" src="https://github.com/user-attachments/assets/8e313268-4cab-460b-aab6-86ff2e7ac1e2" />

#### Takeaways:
- SQL remains the most in demand skill followed by Excel and then Python for data analysts!
- Specialized skills like pyspark and bitbucket tap into that niche market in data analysis and pay the most but may not be in great demand like SQL or Excel. 

# What I learned:
- The job landscape for data analysts in my local NWA area.
- Basic SQL queries and their function in data processing and visualization.
- The combination use of PostgreSQL, VS Code and AI for the processing, querying, and visualization respectively
- How data analysts can find, retract, and synthesize data for key decisions made at higher levels within a company.
- The power of GitHub and sharing projects online.
- Data's application into diverse fields and sectors such as healthcare, energy, retail, and niche markets that are around us daily.
- Top skills and their pay range for a data analyst

  
# Conclusions:
This project was incredibly insightful to the data analyst job landscape while also enhancing my SQL skills essential for this application. It was interesting to find Walmart has attracted a wide range of jobs and when specifically talking about data analyst jobs as it shows an increase in demand for NWA. Walmart has attracted multiple companies to work with them and land Arkansas as their home which should increase job demand for data analysis related roles. I was unfortunately unable to find the salary for the jobs in the surrounding NWA area because they were not listed on the applications. Thinking big picture, data analyst jobs are in high demand everywhere because of the increase of data driven conclusions and learning specific skills like SQL, Excel, and Python make applicants extremely valuable for these jobs. I believe that these types of jobs will continue to grow with the implementation of AI and mass data extraction within big business and the time is now to learn these skills to be in the best position possible. I had a fun time learning this new skill and can see how this foundational skill will shape my life and career.
