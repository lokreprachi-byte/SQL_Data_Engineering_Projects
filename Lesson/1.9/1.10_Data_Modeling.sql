SELECT  
    job_id,
    job_title_short,
    salary_year_avg,
    company_id
FROM
    job_postings_fact
LIMIT 10;



PRAGMA show_tables_expanded;

DESCRIBE job_postings_fact;

SELECT *
FROM skills_job_dim
LIMIT 5;
