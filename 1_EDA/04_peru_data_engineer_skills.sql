
/*
    Question: What are the top-paying skills for remote Data Engineer job postings located in Peru with a demand count greater than 100?
    
    Notes:
    - Filtered by job title: 'Data Engineer'
    - Filtered by work from home: true
    - Filtered by country: 'Peru'
    - Grouped by skill, filtered for skills appearing in more than 100 postings
    - Sorted by median yearly salary in descending order (top 25)
*/
SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg),0) AS mdedian_salary,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id 
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = true 
    AND jpf.job_country = 'Peru'
GROUP BY 
    sd.skills 
HAVING
    COUNT(jpf.*) > 100
ORDER BY  
    mdedian_salary DESC
LIMIT 25;



/*
┌──────────────┬────────────────┬──────────────┐
│    skills    │ mdedian_salary │ demand_count │
│   varchar    │     double     │    int64     │
├──────────────┼────────────────┼──────────────┤
│ sql          │        27000.0 │          509 │
│ python       │        27000.0 │          561 │
│ flow         │        27000.0 │          122 │
│ databricks   │           NULL │          153 │
│ excel        │           NULL │          114 │
│ power bi     │           NULL │          136 │
│ pytorch      │           NULL │          122 │
│ spark        │           NULL │          148 │
│ redshift     │           NULL │          136 │
│ scikit-learn │           NULL │          124 │
│ pyspark      │           NULL │          160 │
│ pandas       │           NULL │          217 │
│ docker       │           NULL │          134 │
│ airflow      │           NULL │          405 │
│ gcp          │           NULL │          153 │
│ kubernetes   │           NULL │          126 │
│ aws          │           NULL │          379 │
│ snowflake    │           NULL │          123 │
└──────────────┴────────────────┴──────────────┘
  18 rows                            3 columns

    Insights & Breakdown of Results:
    
    - Top-Paying Active Skills: SQL, Python, and Flow lead the list with identical median salaries of $27,000 and strong demand counts (ranging from 122 to 561 job postings).
    - Missing Salary Disclosures (NULLs): Popular tools like AWS, Airflow, Pandas, and Snowflake show NULL for median salary despite high demand (e.g., Airflow has 405 postings, AWS has 379). This indicates that the job postings located in Peru for these specific tools did not list salary numbers in the database.
    - Demand vs. Data Limitations: While many advanced technologies appear in the dataset, the limited number of salary-disclosed remote listings in Peru creates salary ties and data gaps for several major tools.
*/