%% 导入excel数据文件
% 指定文件路径
file_path = './TOPSIS.xlsx';

% 使用readtable函数读取整个表格
table_data = readtable(file_path);

% 显示所有列名
disp(table_data.Properties.VariableNames);

% 指定要提取的列名
column_names = {'TOPSIS_humdred_marks', 'runs_won_past', 'rate_of_point',...
    'runs_of_fails','p1_ace','p1_double_fault','p1_unf_err','p1_break_pt',...
    'p1_break_pt_won','p1_break_pt_missed','server','set_no','game_no','is_tie_breakers','rate_score_past'};

% 提取指定列的数据
selected_data = table_data(:, column_names);

% 将table类型的数据转换为数组
selected_data_array = table2array(selected_data);

%% 因子分类
%
% 表现因子
%     -topsis得分      TOPSIS_humdred marks
%
% 长期影响因子
%   -过去连胜场数   （new） runs_won_past       0.000***
%   -累计得分（比率）（new）rate_of_point       0.000***
%   -过去连败场数 （new）   runs_of_fails       0.000***
%   			
% 短期影响因子
%   -技巧（可控）
%     制胜发球          p1_ace                  0.001***
%     获胜方式（无触碰） p1_winner               0.872
%     获胜方式（正反手） winner_shot_type        0.159
%     双误次数          p1_double_fault         0.079*
%     非强制双误次数    p1_unf_err               0.081*
%     上网次数          p1_net_pt               0.939
%     上网得分次数      p1_net_pt_won           0.120
%     破发点次数        p1_break_pt             0.000***
%     破发点得分次数    p1_break_pt_won         0.000***
%     破发失误次数      p1_break_pt_missed      0.000*** 
%     跑动距离         p1_distance_run          0.622
%     回球次数         rally_count              0.506
%     发球速度         speed_mph                0.297
%     发球宽度         serve_width              0.905
%     发球深度         serve_depth              0.410
%     接发球深度       return_depth             0.738
%     
%     
%   -先后手              server                0.000***
%   -场次：
%       盘数          set_no                  0.361
%       局数          game_no                 0.000***
%   -特殊：是否为抢七局   is_tie_breakers      0.000***
%   -上一回合得分比 （new）rate_score_past     0.000***
%
%注：***、**、*分别代表1%、5%、10%的显著性水平
% 1. 先对XY之间是否存在统计上的显著性关系进行检验，判断P值是否呈现显著性(P<0.05)。
% 2. 若呈现显著性，则说明两变量之间存在相关性，反之，则两变量之间不存在相关性。

%% 将table类型的数据转换为数组

