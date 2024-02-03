# 导入必要的库
import numpy as np
import pandas as pd
from scipy.stats import chisquare, ks_2samp
import matplotlib.pyplot as plt
import statsmodels.api as sm

# 读取CSV文件中的数据
df = pd.read_csv('momentum.csv')

# 获取观测数据列
observed_data = df['momentum']

# 卡方检验
# 生成与观测数据大小相同的随机正态分布数据
expected_data = np.random.normal(size=len(observed_data))
# 进行卡方检验
chi2_stat, p_value = chisquare(observed_data, expected_data)
# 打印卡方统计量和p值
print(f"Chi-squared Statistic: {chi2_stat}, p-value: {p_value}")

# Kolmogorov-Smirnov检验
# 生成与观测数据大小相同的随机正态分布数据
expected_data_ks = np.random.normal(size=len(observed_data))
# 进行Kolmogorov-Smirnov检验
ks_stat, ks_p_value = ks_2samp(observed_data, expected_data_ks)
# 打印KS统计量和p值
print(f"KS Statistic: {ks_stat}, p-value: {ks_p_value}")

# 绘制自相关图
sm.graphics.tsa.plot_acf(observed_data, lags=20)
# 设置图标题
plt.title('Autocorrelation Plot')
# 展示图形
plt.show()
