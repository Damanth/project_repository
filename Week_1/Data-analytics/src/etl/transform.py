import pandas as pd

COLUMNS_TO_DROP = [
    'url','address','votes','phone','location',
    'rest_type','cuisines','reviews_list',
    'menu_item','listed_in(type)','listed_in(city)'
]

def clean_data(df: pd.DataFrame) -> pd.DataFrame:
    df = df.drop(columns=COLUMNS_TO_DROP, errors="ignore")
    df = df.drop_duplicates()
    df = df.dropna()
    df = df.reset_index(drop=True)

    if "Rate" in df.columns:
        df["Rate"] = (
            df["Rate"]
            .astype(str)
            .str.replace(" ", "", regex=False)
            .str.replace("/5", "", regex=False)
        )
        df["Rate"] = pd.to_numeric(df["Rate"], errors="coerce")

    if "Online_order" in df.columns:
        df["Online_order"] = df["Online_order"].apply(
            lambda x: 1 if x == "Yes" else 0
        )

    df["processed_date"] = pd.Timestamp.now().date()
    return df
