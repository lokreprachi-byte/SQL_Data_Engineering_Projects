/*
    Question: What are the most optimal skills for data engineers-balancing both demand and salary?
    - Create a ranking column that combines demand count and median salary to identify the most valuable skills.
    - Focus only on remote Data Engineer positions with specified annual salaries.
    - Why?
        - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately.
*/



SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg)) * LN(COUNT(jpf.*)), 2) AS optimal_score
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY 
    optimal_score DESC
LIMIT 25;

/*
Top Skills by Optimal Score (Combining High Salaries & High Demand):

- Terraform leads the ranking with an $184K median salary and 193 postings.
- Python and SQL dominate volume (over 1,100 postings each) with strong median salaries around $130K-$135K.
- Cloud & Big Data platforms like AWS ($137K), Spark ($140K), and Airflow ($150K) show exceptional earning potential and solid job counts.
- Tools such as Kafka, Snowflake, Azure, and Databricks round out the top tier with strong mid-to-high compensation.

┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar   │    double     │    int64     │     double      │    double     │
├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ terraform  │      184000.0 │          193 │             5.3 │     968334.99 │
│ python     │      135000.0 │         1133 │             7.0 │     949404.28 │
│ aws        │      137320.0 │          783 │             6.7 │     914983.46 │
│ sql        │      130000.0 │         1128 │             7.0 │     913666.19 │
│ airflow    │      150000.0 │          386 │             6.0 │     893375.61 │
│ spark      │      140000.0 │          503 │             6.2 │     870882.62 │
│ snowflake  │      135500.0 │          438 │             6.1 │     824140.66 │
│ kafka      │      145000.0 │          292 │             5.7 │      823129.3 │
│ azure      │      128000.0 │          475 │             6.2 │     788904.29 │
│ java       │      135000.0 │          303 │             5.7 │     771353.93 │
│ scala      │      137290.0 │          247 │             5.5 │     756386.59 │
│ kubernetes │      150500.0 │          147 │             5.0 │      751060.1 │
│ git        │      140000.0 │          208 │             5.3 │     747255.33 │
│ databricks │      132750.0 │          266 │             5.6 │     741209.13 │
│ redshift   │      130000.0 │          274 │             5.6 │     729706.65 │
│ gcp        │      136000.0 │          196 │             5.3 │     717823.59 │
│ hadoop     │      135000.0 │          198 │             5.3 │     713916.05 │
│ nosql      │      134415.0 │          193 │             5.3 │      707384.5 │
│ pyspark    │      140000.0 │          152 │             5.0 │     703343.27 │
│ docker     │      135000.0 │          144 │             5.0 │      670924.8 │
│ mongodb    │      135750.0 │          136 │             4.9 │      666892.9 │
│ go         │      140000.0 │          113 │             4.7 │     661834.29 │
│ r          │      134775.0 │          133 │             4.9 │      659096.8 │
│ github     │      135000.0 │          127 │             4.8 │     653965.26 │
│ bigquery   │      135000.0 │          123 │             4.8 │     649644.89 │
└────────────┴───────────────┴──────────────┴─────────────────┴───────────────┘
  25 rows                                                           5 columns
*/




