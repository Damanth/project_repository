# Data Analytics ETL Pipeline

Production-ready ETL pipeline built from Zomato dataset using Python.

## Features
- CLI-based ETL pipeline
- Modular src structure
- Data cleaning & feature engineering
- Parquet output partitioned by date
- YAML configuration
- Logging support
- Pytest unit tests
- Daily cron scheduling

## Setup
pip install -r requirements.txt

## Run Pipeline
python -m etl.cli

## Run Tests
pytest
