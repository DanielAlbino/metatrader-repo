import datetime as dt
from matplotlib import style  # style charts and graphs
import matplotlib.pyplot as plt  # import chart and graphs...
import pandas as pd
import pandas_datareader.data as web


style.use('ggplot')

start = dt.datetime(2010, 1, 1)
end = dt.datetime(2020, 1, 1)

# df is definitio for data frame - we can see as a spreadsheet
df = web.DataReader('TSLA', 'yahoo', start, end)
print(df.head())
