import pandas as pd
from collections import Counter

# 统计每列出现的数据
def count(df,head):
    value_counts = df[head].value_counts()
    # print(f"\nColumn: {head}")
    # print(value_counts)
    # 将 value_counts 转化为字典
    value_counts_dict = value_counts.to_dict()
    # print(f"\nValue count: {value_counts_dict}")
    return value_counts_dict
    
#总人数统计
def count_name(*args):
    # 合并所有字典
    merged_dict = {}
    for d in args:
        merged_dict |= Counter(d)

    return merged_dict

#获取交换的列名
def change_column_name(df):
    change_column_name_list1 = []
    change_column_name_list2 = []
    head_list=df.columns.to_list() 
    for name in head_list:
        if 'p1' in name or 'player1' in name :
            change_column_name_list1.append(name) 
        elif 'p2' in name or 'player2' in name :
            change_column_name_list2.append(name)
        else :
            print(f'{name}  \t\t无需交换')
    return change_column_name_list1,change_column_name_list2

#遍历表格
def find_column(df,count_names,change_column_name_list1,change_column_name_list2,df2):
    for index, row in df.iterrows():
        # 判断某一列的单元格值是否满足等式条件
        if row['player2'] in count_names:
            # print(f"{row['player2']}")
            # print(index)
            # pass
            # 判断该行的列名是否满足一定条件
            for i in range(0,len(change_column_name_list1)):
                cell_value1 = df.at[index, change_column_name_list1[i]]
                cell_value2 = df.at[index, change_column_name_list2[i]]
                # 使用 at 属性写入单元格值
                df2.at[index, change_column_name_list1[i]] = cell_value2
                df2.at[index, change_column_name_list2[i]] = cell_value1

        else:
            print(f"error {row['player2']}")

#1,2z值切换
def change_1_2(df,df2):
    require_list = ['server','point_victor','game_victor','set_victor']
    for index, row in df.iterrows():
        for i in range(0,len(require_list)):
            
            cell_value = str(df.at[index,require_list[i]])
            # print(cell_value,require_list[i])
            if cell_value == '1':
                # 使用 at 属性写入单元格值
                df2.at[index, require_list[i]] = 2
            elif cell_value =='2':
                df2.at[index, require_list[i]] = 1
            elif cell_value == '0':
                df2.at[index, require_list[i]] = 0
            else:
                print(f"error {row[require_list[i]]}")


#main

if  __name__ == '__main__':
    #打开表格
    df = pd.read_excel('Wimbledon_featured_matches.xlsx')
    
    #获取每个player的姓名并统计
    player1_count=count(df,'player1')
    player2_count=count(df,'player2')
    
    # 统计总共出现的的人名数
    count_names=count_name(player1_count,player2_count) 
    # 将字典的键名转化为列表
    name_list = list(count_names.keys())   
    print(f"\n\n总共出现的的人名数为: {len(count_names)}\n其中player1有：{len(player1_count)}\tplayer2有：{len(player2_count)} \n ")
    
    #获取需要交换的列名
    print('获取要交换的列名ing')
    print('获取完成\n无需交换的有:')
    change_column_name_list1,change_column_name_list2=change_column_name(df)
    print(f'需要交换的有：\nplayer1:{change_column_name_list1}\nplayer2:{change_column_name_list2}\n')
    # print(change_column_name_list)
    
    # 打卡另一个DataFrame
    # 复制数据到新的 DataFrame
    df2 = df.copy()
    # df2= pd.read_excel('V1_middle_Wimbledon_featured_matches.xlsx')
    #交换列
    find_column(df,count_names,change_column_name_list1,change_column_name_list2,df2)
    #交换1、2
    change_1_2(df,df2)
    
    # 将新的 DataFrame 写入到新的 Excel 文件
    df2.to_excel('V1_middle_Wimbledon_featured_matches.xlsx', index=False)

