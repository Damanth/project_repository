import pandas as pd
from etl.transform import clean_data

def test_rate_cleaning():
    df = pd.DataFrame({
        "Rate": ["4.2 /5", "3.5/5"],
        "Online_order": ["Yes", "No"]
    })

    result = clean_data(df)

    assert result["Rate"].iloc[0] == 4.2
    assert result["Online_order"].iloc[0] == 1
    assert result["Online_order"].iloc[1] == 0
