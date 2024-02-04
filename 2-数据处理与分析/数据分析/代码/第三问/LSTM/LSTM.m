%% 导入excel数据文件
clc,clear;
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
data = table_data(:, column_names);

%% 提取特征和标签
X = data{:, { 'runs_won_past', 'rate_of_point',...
    'runs_of_fails','p1_ace','p1_double_fault','p1_unf_err','p1_break_pt',...
    'p1_break_pt_won','p1_break_pt_missed','server','set_no','game_no','is_tie_breakers','rate_score_past'}};  % 选择你认为对表现有影响的特征
y = data{:, 'TOPSIS_humdred_marks'};  % 'performance_label' 是你想要预测的表现

% 数据标准化
X_scaled = zscore(X);

% 划分训练集和测试集
rng(42);  % 设置随机种子以保证可复现性
[trainIdx, testIdx] = crossvalind('HoldOut', size(X_scaled, 1), 0.2);
X_train = X_scaled(trainIdx, :);
X_test = X_scaled(testIdx, :);
y_train = y(trainIdx);
y_test = y(testIdx);

% 构建循环神经网络模型
numFeatures = size(X_train, 2);
numHiddenUnits = 100;  % 可根据实际情况调整

% 构建神经网络层
layers = [ ...
    sequenceInputLayer(numFeatures)  % 输入层
    lstmLayer(numHiddenUnits)  % LSTM层
    fullyConnectedLayer(1)  % 全连接层，用于输出
    reluLayer()  % 使用 'relu' 作为激活函数
    regressionLayer  % 回归层，用于回归问题的输出
];



% 配置训练选项
options = trainingOptions('adam', ...
    'MaxEpochs', 500, ...
    'MiniBatchSize', 32, ...
    'Verbose', 1, ...
    'Plots', 'training-progress');

% 训练模型
net = trainNetwork(X_train', y_train', layers, options);

%% 评估模型
predictions = predict(net, X_test');

% 输出模型的拟合优度
trainPredictions = predict(net, X_train');
trainMSE = mean((trainPredictions - y_train').^2);
fprintf('Mean Squared Error on Training Data: %.4f\n', trainMSE);

% 在测试集上进行预测
testPredictions = predict(net, X_test');

% 计算均方误差
testMSE = mean((testPredictions - y_test').^2);
fprintf('Mean Squared Error on Test Data: %.4f\n', testMSE);

try
% 可视化训练进度
figure;
plot(options.MaxEpochs, net.Layers(end).AverageSquaredError, 'b-', 'LineWidth', 2);
xlabel('Epoch');
ylabel('Mean Squared Error');
title('Training Progress');
grid on;
catch e
    disp(e)
end

% 显示拟合结果
figure;
subplot(2,1,1);
plot(y_test, 'b-', 'LineWidth', 2);
hold on;
plot(testPredictions, 'r--', 'LineWidth', 2);
legend('Actual', 'Predicted');
title('Actual vs Predicted on Test Data');
xlabel('Sample');
ylabel('Performance');

subplot(2,1,2);
residuals = y_test - testPredictions;
plot(residuals, 'k-', 'LineWidth', 2);
title('Residuals on Test Data');
xlabel('Sample');
ylabel('Residual');

% 输出拟合优度
fprintf('R-Squared on Test Data: %.4f\n', 1 - testMSE/var(y_test));

%% 显示拟合结果
figure;
plot(y_test, 'b-', 'LineWidth', 2);
hold on;
plot(testPredictions, 'r--', 'LineWidth', 2);
legend('Actual', 'Predicted');
title('Actual vs Predicted on Test Data');
xlabel('Sample');
ylabel('Performance');

% 计算均方误差
testMSE = mean((testPredictions - y_test').^2);
fprintf('Mean Squared Error on Test Data: %.4f\n', testMSE);

% 输出拟合优度
fprintf('R-Squared on Test Data: %.4f\n', 1 - testMSE/var(y_test));

