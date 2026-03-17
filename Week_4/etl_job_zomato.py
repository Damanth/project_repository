import sys
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.dynamicframe import DynamicFrame

from pyspark.sql.functions import col, regexp_replace, split
from pyspark.sql.functions import current_timestamp, year, month
from pyspark.sql.types import FloatType, IntegerType

# -----------------------------------
# Job Initialization
# -----------------------------------

args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# -----------------------------------
# Read Raw Data from Glue Catalog
# -----------------------------------

raw_data = glueContext.create_dynamic_frame.from_catalog(
    database="zomato_db",
    table_name="zomato_rawzomato_data",
    transformation_ctx="raw_data"
)

df = raw_data.toDF()

# -----------------------------------
# Schema Normalization
# -----------------------------------

df = df.withColumnRenamed("approx_cost(for two people)", "approx_cost_for_two") \
       .withColumnRenamed("listed_in(type)", "listed_in_type") \
       .withColumnRenamed("listed_in(city)", "listed_in_city")

# -----------------------------------
# Data Cleaning
# -----------------------------------

df_clean = df.dropDuplicates() \
             .dropna(subset=["name", "location"])

# -----------------------------------
# Rating Cleaning
# Convert "4.1/5" → 4.1
# -----------------------------------

df_clean = df_clean.withColumn(
    "rating",
    split(col("rate"), "/").getItem(0).cast(FloatType())
)

# -----------------------------------
# Cost Conversion
# Remove commas and convert to integer
# -----------------------------------

df_clean = df_clean.withColumn(
    "approx_cost_for_two",
    regexp_replace(col("approx_cost_for_two"), ",", "")
)

df_clean = df_clean.withColumn(
    "approx_cost_for_two",
    col("approx_cost_for_two").cast(IntegerType())
)

# -----------------------------------
# Votes Conversion
# -----------------------------------

df_clean = df_clean.withColumn(
    "votes",
    col("votes").cast(IntegerType())
)

# -----------------------------------
# Add ETL Metadata Columns
# -----------------------------------

df_clean = df_clean.withColumn(
    "ingestion_timestamp",
    current_timestamp()
)

df_clean = df_clean.withColumn(
    "year",
    year("ingestion_timestamp")
)

df_clean = df_clean.withColumn(
    "month",
    month("ingestion_timestamp")
)

# -----------------------------------
# Select Final Columns
# -----------------------------------

df_final = df_clean.select(
    "name",
    "location",
    "cuisines",
    "rating",
    "votes",
    "approx_cost_for_two",
    "listed_in_type",
    "listed_in_city",
    "ingestion_timestamp",
    "year",
    "month"
)

# -----------------------------------
# Convert back to DynamicFrame
# -----------------------------------

final_dynamic = DynamicFrame.fromDF(df_final, glueContext, "final_dynamic")

# -----------------------------------
# Write Curated Parquet Data
# -----------------------------------

glueContext.write_dynamic_frame.from_options(
    frame=final_dynamic,
    connection_type="s3",
    connection_options={
        "path": "s3://etl-pyspark-job-bucket-damanthloki/curated/zomato/",
        "partitionKeys": ["year", "month"]
    },
    format="parquet",
    transformation_ctx="datasink"
)

job.commit()