# 导入必要的库
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

# 读取两个CSV文件中的数据
df = pd.read_csv('data.csv')
df0 = pd.read_csv('momentum.csv')

# 计算比分差距
df['score_gap'] = df['p1_points_won'] - df['p2_points_won']

# 创建图形
plt.figure(figsize=(10, 5))

# 设置图标题和横坐标标签
plt.title('Momentum over time')
plt.xlabel('Time')

# 绘制比分差距和动量的前300个数据点
plt.plot(df['score_gap'][:300], label='score_gap')
plt.plot(df0['momentum'][:300], label='momentum')

# 添加图例
plt.legend()

# 显示网格
plt.grid(True)

# 显示图形
plt.show()
