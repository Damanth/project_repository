from pathlib import Path

def write_parquet(df, output_path: str):
    Path(output_path).mkdir(parents=True, exist_ok=True)

    df.to_parquet(
        output_path,
        engine="pyarrow",
        partition_cols=["processed_date"],
        index=False
    )
