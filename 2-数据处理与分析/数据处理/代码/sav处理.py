import pandas as pd
import pyreadstat

# 读取原始数据
df, meta = pyreadstat.read_sav('数据处理前.sav')

# 获取需要进行 Max-Min 编码的列
columns_to_normalize = ['last_time', 'elapsed_time', 'point_no', 'p1_score', 'p2_score', 'p1_points_won', 'p2_points_won', 'p1_distance_run', 'p2_distance_run', 'rally_count', 'speed_mph']

# 循环处理每列进行 Max-Min 编码
for column in columns_to_normalize:
    max_value = df[column].max()
    min_value = df[column].min()
    new_column_name = f'normalized_{column}'

    # 计算 Max-Min 编码
    df[column] = (df[column] - min_value) / (max_value - min_value)

# 将处理后的数据写入新的 SPSS 数据文件
pyreadstat.write_sav(df, '数据处理后.sav', file_label=meta.file_label, variable_value_labels=meta.variable_value_labels)
