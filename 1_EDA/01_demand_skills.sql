/*
Question :What are the most in-demand skills for data engineers?
 Identify the top 10 in-demand skills for data engineers 
 focussed on remote job postings 
 why: Retrieves the top 10 skills with the 
highest demand in the remote job market providing 
insights into most valuable skills for data engineers seeking
 remote work   
*/


SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id 
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = true 
GROUP BY 
    sd.skills 
ORDER BY 
    demand_count DESC
LIMIT 10;


/*
  Data Engineering Insights: Top Demanded Skills
  - SQL and Python lead the pack with nearly 29,000 job postings each, cementing them as absolute must-haves.
  - Cloud platforms like AWS (~18,000) and Azure (~14,000) form the backbone of modern data infrastructure.
  - Apache Spark (~13,000) rounds out the top tier, highlighting the demand for big data processing capabilities.

┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
  10 rows         2 columns
*/