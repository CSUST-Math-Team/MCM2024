% 读取比赛数据
% 假设你有一个包含比赛详细数据的表，列名包括 'feature1', 'feature2', 'performance_label'
% 这里的 feature1、feature2 等代表你的比赛数据中的各种特征
% data = readtable('your_data.csv');

% 提取特征和标签
X = data{:, {'feature1', 'feature2'}};  % 选择你认为对表现有影响的特征
y = data{:, 'performance_label'};  % 'performance_label' 是你想要预测的表现

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
    lstmLayer(numHiddenUnits, 'Activation', 'relu')  % LSTM层
    fullyConnectedLayer(1)  % 全连接层，用于输出
    regressionLayer  % 回归层，用于回归问题的输出
];

% 配置训练选项
options = trainingOptions('adam', ...
    'MaxEpochs', 10, ...
    'MiniBatchSize', 32, ...
    'Verbose', 1, ...
    'Plots', 'training-progress');

% 训练模型
net = trainNetwork(X_train', y_train', layers, options);

% 评估模型
predictions = predict(net, X_test');

% 计算均方误差
mse = mean((predictions - y_test').^2);
fprintf('Mean Squared Error on Test Data: %.4f\n', mse);
