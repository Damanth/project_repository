# AMAZON SALES SQL PROJECT – SUMMARY



PROJECT OVERVIEW



This project demonstrates end-to-end SQL database design, data

manipulation, analytical querying, and performance optimization using an

Amazon sales dataset.



1\. DATABASE \& TABLE DESIGN



\-   Created a database named ‘Amazon’.



\-   Designed the ‘amazon\_sales’ table with appropriate columns for: •

&nbsp;   Order details • Product information • Pricing and discount structure

&nbsp;   • Revenue metrics • Customer region and payment method • Ratings and

&nbsp;   review metrics



\-   Applied strong data integrity rules using: • PRIMARY KEY constraint

&nbsp;   • NOT NULL constraints • CHECK constraints for validation (price,

&nbsp;   rating, quantity, discounts)



2\. DATA POPULATION



\-   Inserted structured sales data spanning 2022–2024.

\-   Covered multiple categories (Books, Electronics, Fashion, Beauty,

&nbsp;   Sports, etc.).

\-   Included different regions and payment methods.



3\. DATA DEFINITION LANGUAGE (DDL)



Performed schema modifications and optimization:



\-   Added and removed columns (shipping\_cost).

\-   Modified column size.

\-   Added additional CHECK constraint.

\-   Renamed column and table.

\-   Created indexes: • Index on order\_date. • Composite index on

&nbsp;   (product\_category, customer\_region).



Purpose: Improve structure, maintain flexibility, and optimize

performance.



4\. DATA MANIPULATION LANGUAGE (DML)



Executed multiple operations:



\-   INSERT new records.

\-   UPDATE discounts, revenue, ratings, and payment methods.

\-   DELETE low-rated records.

\-   Used TRANSACTION control (START TRANSACTION, ROLLBACK).

\-   Demonstrated safe modification with rollback capability.



5\. AGGREGATION \& BUSINESS ANALYTICS



Implemented analytical queries including:



\-   Daily, weekly, and monthly revenue analysis.

\-   Revenue by category and region.

\-   Category performance metrics.

\-   Top-performing regions.

\-   High revenue order analysis using CTE.



6\. JOIN OPERATIONS



\-   Derived table join to compare order revenue with category average

&nbsp;   revenue.

\-   Self-join to compare orders within the same region.



7\. WINDOW FUNCTIONS



Applied advanced analytical functions:



\-   RANK() for revenue ranking per category.

\-   DENSE\_RANK() for review ranking.

\-   ROW\_NUMBER() for top order per region.

\-   Running total revenue calculation.

\-   Moving average revenue.

\-   Revenue contribution percentage (overall and category-wise).



8\. TOP-N ANALYSIS



\-   Highest revenue orders (Top 3).

\-   Top product per category.

\-   Top-rated products with review filtering.



9\. PERFORMANCE OPTIMIZATION



\-   Used EXPLAIN ANALYZE to evaluate execution plans.

\-   Verified index usage for filtering and grouping.

\-   Identified sorting and partitioning costs in window functions.

\-   Demonstrated understanding of query optimization strategies.



10\. OVERALL OUTCOME



This SQL project demonstrates:



• Strong database design principles • Data integrity enforcement •

Indexing strategy implementation • Transaction management • Complex

analytical SQL queries • Window functions and ranking • CTE usage •

Query performance analysis



The script represents a complete SQL analytical project covering design,

data manipulation, reporting, and optimization.



















# PYSPARK ETL JOB SUMMARY – ZOMATO DATASET



PROJECT OVERVIEW



This project implements a complete ETL (Extract, Transform, Load)

pipeline using PySpark to process and analyze the Zomato dataset. The

workflow demonstrates data engineering best practices including data

ingestion, transformation, aggregation, validation, and structured

output generation.



1\. SPARK SESSION INITIALIZATION



\-   Created a SparkSession for distributed data processing.

\-   Configured the application with an appropriate app name.

\-   Enabled DataFrame-based processing using PySpark APIs.



2\. DATA INGESTION (EXTRACT)



\-   Loaded raw Zomato dataset from CSV files.

\-   Enabled header parsing.

\-   Verified schema and data types.

\-   Displayed sample records for validation.



3\. DATA CLEANING \& TRANSFORMATION (TRANSFORM)



\-   Removed or handled null values where required.

\-   Casted columns to appropriate data types (rating, cost, votes).

\-   Renamed columns for clarity and consistency.

\-   Created derived columns where necessary.

\-   Joined dataset with a zone lookup (dimension mapping table) to

&nbsp;   enrich restaurant records with zone information.



4\. DIMENSION MAPPING



\-   Loaded zone\_lookup.csv as a dimension table.

\-   Performed join operation between fact data and dimension table.

\-   Ensured proper mapping between location and zone.

\-   Improved analytical capability through enriched dataset.



5\. DAILY AGGREGATION LOGIC



Computed daily aggregated metrics grouped by ingestion\_date and zone:



\-   Average rating

\-   Median rating (using percentile\_approx)

\-   Average cost for two

\-   Total votes

\-   Restaurant count



This step demonstrates advanced aggregation using: - groupBy() - avg() -

sum() - count() - percentile\_approx()



6\. DATA VALIDATION



\-   Displayed aggregated results using show().

\-   Verified correctness of calculations.

\-   Compared Spark results with equivalent SQL logic (where applicable).



7\. PERFORMANCE CONSIDERATIONS



\-   Used Spark transformations efficiently.

\-   Leveraged distributed groupBy aggregations.

\-   Ensured joins were structured properly to reduce shuffle issues.

\-   Used approximate median calculation for performance efficiency.



8\. OUTPUT GENERATION (LOAD)



\-   Generated curated/aggregated dataset.

\-   Prepared output for downstream analytics or reporting.

\-   Structured data suitable for data warehouse or BI consumption.



9\. OVERALL OUTCOME



The PySpark ETL job successfully:



• Demonstrates scalable data processing • Implements dimensional

modeling (fact + dimension join) • Performs business-driven aggregations

• Uses advanced Spark SQL functions • Validates aggregated results •

Prepares analytical dataset for reporting



This project reflects strong understanding of: - Distributed data

processing - ETL pipeline design - Spark DataFrame API - Analytical

aggregations - Data validation techniques



