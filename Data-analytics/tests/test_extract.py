from etl.extract import read_csv
import pandas as pd
import tempfile

def test_read_csv():
    df = pd.DataFrame({"a":[1,2]})
    with tempfile.NamedTemporaryFile(suffix=".csv", delete=False) as f:
        df.to_csv(f.name, index=False)
        result = read_csv(f.name)
        assert len(result) == 2
