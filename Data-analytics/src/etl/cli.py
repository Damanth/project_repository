import click
from etl.extract import read_csv
from etl.transform import clean_data
from etl.load import write_parquet
from etl.config import load_config
from etl.logger import get_logger

logger = get_logger(__name__)

@click.command()
@click.option("--config", default="config/config.yaml")
def run_pipeline(config):

    cfg = load_config(config)

    logger.info("Reading dataset...")
    df = read_csv(cfg["data"]["input_path"])

    logger.info("Cleaning data...")
    df = clean_data(df)

    logger.info("Writing parquet output...")
    write_parquet(df, cfg["data"]["output_path"])

    logger.info("Pipeline completed successfully.")

if __name__ == "__main__":
    run_pipeline()
