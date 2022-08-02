# Partitioning and Clustering in BigQuery

Objective: Demonstrate cost and speed gains realized by applying Partitioning and Clustering in BigQuery.

Original SQL in this excersize can be found here: https://cloud.google.com/blog/topics/developers-practitioners/bigquery-explained-storage-overview

I highly recoomend reading this article for a more detailed explanation. 

This exercise highlights query performance on three tables. The tables contain identical data (definitions found in clustering.sql); however, they vary in clustering and partitioning strategy. The tables are described below:

1. stackoverflow.questions_2018
   > no clustering or partitioning applied
2. stackoverflow.questions_2018_partitioned
   > partitioning applied
3. stackoverflow.questions_2018_clustered
   > partitioning and clustering applied
   
# Example Query

The following query illistrates the impact of clustering and partitioning. Notice the table is filtered on the partition and cluster columns. Query speed and cost improve when partitioning is applied. Further gains are realized when partitioning _and_ clustering are applied.

```sql
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
 `stackoverflow.questions_2018` --update table to experiment with different partitioning/clustering strategies
WHERE
 creation_date BETWEEN '2018-01-01' AND '2018-02-01'
 AND tags = 'android';
```

# Add Clustering to Existing Table

Clustering can be added to an existing table using the bq command-line tool.

More information can be found here: https://cloud.google.com/bigquery/docs/reference/bq-cli-reference#bq_update

In the example below, clustering is added to the _example_table_ on the _tags_ column

```bash
bq update --clustering_fields=tags stackoverflow.example_table
```
