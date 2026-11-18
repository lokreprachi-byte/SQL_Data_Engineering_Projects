/*
  Question: What are the highest-paying skills for data engineers?
  - Calculate the median salary for each skill required in data engineer positions
  - Focus on remote positions with specified salaries
  - Include skill frequency to identify both salary and demand
  - Why?
    - Helps identify which skills command the highest compensation while also showing how common those skills are, providing a more complete picture for skill development priorities.
    - The median is used instead of the average to reduce the impact of outlier salaries.
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
GROUP BY 
    sd.skills 
ORDER BY 
    mdedian_salary DESC
LIMIT 25;


/*
Top-Paying Data Engineering Skills:
- Rust leads at $210K median salary (lower demand).
- Terraform & Golang tie at $184K.
- Core cloud/orchestration tools like Kubernetes 
($150.5K) and Airflow ($150K) balance high pay with massive job volume.
┌───────────┬────────────────┬──────────────┐
│  skills   │ mdedian_salary │ demand_count │
│  varchar  │     double     │    int64     │
├───────────┼────────────────┼──────────────┤
│ rust      │       210000.0 │          232 │
│ sheets    │       196698.0 │           98 │
│ solidity  │       192500.0 │           45 │
│ golang    │       184000.0 │          912 │
│ terraform │       184000.0 │         3248 │
│ next.js   │       180000.0 │           19 │
│ ggplot2   │       176250.0 │           15 │
│ spring    │       175500.0 │          364 │
│ erlang    │       172500.0 │            9 │
│ haskell   │       172500.0 │           17 │
│ ocaml     │       172500.0 │            1 │
│ neo4j     │       170000.0 │          277 │
│ gdpr      │       169616.0 │          582 │
│ zoom      │       168438.0 │          127 │
│ graphql   │       167500.0 │          445 │
│ plotly    │       162500.0 │           61 │
│ mongo     │       162250.0 │          265 │
│ centos    │       159350.0 │           31 │
│ fastapi   │       157500.0 │          204 │
│ mxnet     │       157500.0 │            5 │
│ vue       │       156000.0 │           71 │
│ drupal    │       156000.0 │            9 │
│ trello    │       155000.0 │           36 │
│ bitbucket │       155000.0 │          478 │
│ elixir    │       155000.0 │           37 │
└───────────┴────────────────┴──────────────┘
  25 rows                         3 columns
*/


