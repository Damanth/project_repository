import pandas as pd
from etl.load import write_parquet
import os

def test_write_parquet(tmp_path):
    df = pd.DataFrame({"a":[1,2], "processed_date":["2024-01-01","2024-01-01"]})
    write_parquet(df, tmp_path)
    assert os.listdir(tmp_path)
