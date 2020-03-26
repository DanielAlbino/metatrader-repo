import pandas as pd

df = pd.read_csv('EURUSD_1D.csv')

df.columns = [['date', 'Open', 'High', 'Low', 'Close', 'Volume']]

df.date = pd.to_datetime(df.date, format='%d.%m.%Y %H:%M:%S.%f')

df = df.set_index(df.date)
df = df[['Open', 'High', 'Low', 'Close', 'Volume']]
df = df.drop_duplicates(keep=False)

print(df.head())
