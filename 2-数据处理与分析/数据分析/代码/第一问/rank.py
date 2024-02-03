import pandas as pd
import numpy as np

# 读取Excel文件
df = pd.read_excel('data.xlsx')

# 假设正向指标列名为 positive_indicator1 和 positive_indicator2
positive_indicators = ['positive_indicator1', 'positive_indicator2']
negative_indicators = ['negative_indicator1', 'negative_indicator2']
weights_positive = [0.5, 0.3]  # 正向指标的权重
weights_negative = [0.2, 0.1]  # 负向指标的权重

# 设定条件，例如：选择正向指标1大于某个阈值的样本
threshold = 10
condition = df[positive_indicators[0]] > threshold

# 根据条件选择样本
selected_data = df[condition]

# 计算秩次
all_indicators = positive_indicators + negative_indicators
ranks = selected_data[all_indicators].rank(ascending=False)

# 计算秩和
rank_sum = ranks.sum(axis=1)

# 计算秩和比
weighted_ranks = ranks.multiply(weights_positive + weights_negative, axis=0)
rank_ratios = weighted_ranks.divide(rank_sum, axis=0)

# 计算综合评价
composite_evaluation = rank_ratios.sum(axis=1)

# 将综合评价添加到原始数据框中
selected_data['综合评价'] = composite_evaluation

# 根据综合评价分数对数据进行排序
sorted_data = selected_data.sort_values(by='综合评价', ascending=False)

# 将排序后的结果写回Excel文件
sorted_data.to_excel('sorted_data.xlsx', index=False)
