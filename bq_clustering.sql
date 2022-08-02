-- Raw Table 
-- no partitioning or clustering
CREATE OR REPLACE TABLE `stackoverflow.questions_2018` AS
SELECT *
FROM `bigquery-public-data.stackoverflow.posts_questions`
WHERE creation_date BETWEEN '2018-01-01' AND '2018-07-01'

-- Partitioning
-- partitioning without clustering
CREATE OR REPLACE TABLE `stackoverflow.questions_2018_partitioned`
PARTITION BY
 DATE(creation_date) AS
SELECT
 *
FROM
 `bigquery-public-data.stackoverflow.posts_questions`
WHERE
 creation_date BETWEEN '2018-01-01' AND '2018-07-01';

-- Clustering
-- clustering and partitioning
 CREATE OR REPLACE TABLE `stackoverflow.questions_2018_clustered`
PARTITION BY
 DATE(creation_date)
CLUSTER BY
 tags AS
SELECT
 *
FROM
 `bigquery-public-data.stackoverflow.posts_questions`
WHERE
 creation_date BETWEEN '2018-01-01' AND '2018-07-01';

-- Query Raw Table
-- 1.64 GB 
-- 1.64 GB
SELECT
 id,
 title,
 body,
 accepted_answer_id,
 creation_date,
 answer_count,
 comment_count,
 favorite_count,
 view_count
FROM
 `stackoverflow.questions_2018`
WHERE
 creation_date BETWEEN '2018-01-01' AND '2018-02-01'
 AND tags = 'android';

-- Query Partitioned Table
-- 284.87 MB 
-- 284.87 MB
 SELECT
 id,
 title,
 body,
 accepted_answer_id,
 creation_date,
 answer_count,
 comment_count,
 favorite_count,
 view_count
FROM
 `stackoverflow.questions_2018_partitioned`
WHERE
 creation_date BETWEEN '2018-01-01' AND '2018-02-01'
 AND tags = 'android';

-- Query Clustered Data
-- 284.87 MB
-- 274 MB
 SELECT
 id,
 title,
 body,
 accepted_answer_id,
 creation_date,
 answer_count,
 comment_count,
 favorite_count,
 view_count
FROM
 `stackoverflow.questions_2018_clustered`
WHERE
 creation_date BETWEEN '2018-01-01'
 AND '2018-02-01'
 AND tags = 'android';

 -- Create example_table and add cluster using bq and cloudshell
CREATE OR REPLACE TABLE `stackoverflow.questions_2018_partitioned`
PARTITION BY
 DATE(creation_date) AS
SELECT
 *
FROM
 `bigquery-public-data.stackoverflow.posts_questions`
WHERE
 creation_date BETWEEN '2018-01-01' AND '2018-07-01';
