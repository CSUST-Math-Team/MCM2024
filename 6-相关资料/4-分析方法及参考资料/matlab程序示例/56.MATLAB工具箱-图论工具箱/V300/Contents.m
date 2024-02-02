% MATLAB数学建模工具箱
% Version 1.2 28-March-2001
% Copyright (c) 2000
% 东华大学万维软件研究中心
% 上海市延安西路1882号
% Email: ljhu@dhu.edu.cn
%
% 本工具箱主要包含三部分内容
%       (支持平台MATLAB5.3或5.2,Symbolic math,optim,spline,stats)
% 1. MATLAB常用数学建模工具的中文帮助
% 2. 贡献MATLAB数学建模工具(打*号)
% 3. 中国大学生数学建模竞赛历年试题MATLAB程序
%
% 安装步骤
% 1. 将MATHMODL.zip解压缩至matlab11\toolbox\;
% 2. 启动Matlab,利用Path Browser中的Add path菜单将
%    matlab11\toolbox\mathmodl增至path中,放在最前面，并保存设置；
% 3. 回到你的工作目录。现在MATHMODL已成为一个普通的工具箱了。
%
% 可以使用命令help mathmodl查看内容或直接用命令mathmodl学习教程。
%
% 数据拟合
%   interp1    - 一元函数插值
%   spline     - 样条插值
%   polyfit    - 多项式插值或拟合    
%   curvefit   - 曲线拟合
%   caspe      - 各种边界条件的样条插值
%   casps      - 样条拟合
%   interp2    - 二元函数插值
%   griddata   - 不规则数据的二元函数插值
%  *interp     - 不单调节点插值
%  *lagrange   - 拉格朗日插值法
%
% 方程求根
%   inv        - 逆矩阵
%   roots      - 多项式的根
%   fzero      - 一元函数零点
%   fsolve     - 非线性方程组
%   solve      - 符号方程解
%  *newton     - 牛顿迭代法解非线性方程
%  
%微积分和微分方程
%   diff       - 差分
%   diff       - 符号导函数
%   trapz      - 梯形积分法
%   quad8      - 高精度数值积分
%   int        - 符号积分
%   dblquad    - 矩形域二重积分
%   ode45      - 常微分方程
%   dsolve     - 符号微分方程
%  *polyint    - 多项式积分法
%  *quadg      - 高斯积分法
%  *quad2dg    - 矩形域高斯二重积分
%  *dblquad2      - 非矩形域二重积分    
%  *rk4        - 常微分方程RungeKutta法
%
%随机模拟和统计分析
%   max,min    - 最大，最小值
%   sum        - 求和
%   mean       - 均值
%   std        - 标准差
%   sort       - 排序（升序）
%   sortrows   - 按某一列排序(升序)
%   rand       - [0，1]区间均匀分布随机数
%   randn      - 标准正态分布随机数
%   randperm   - 1...n 随机排列
%   regress    - 线性回归
%   classify   - 统计聚类
%  *trim       - 坏数据祛除
%  *specrnd    - 给定分布律随机数生成
%  *randrow    - 整行随机排列
%  *randmix    - 随机置换
%  *chi2test   - 分布拟合度卡方检验
%
% 数学规划
%   lp            - 线性规划
%   linprog       - 线性规划(在MATLAB5.3使用)
%   fmin          - 一元函数极值
%   fminu         - 多元函数极值拟牛顿法
%   fmins         - 多元函数极值单纯形搜索法
%   constr        - 非线性规划
%   fmincon       - 非线性规划(在MATLAB5.3使用)
%
% 离散优化
%  *enum       - 枚举法
%  *monte      - 蒙特卡洛法
%  *lpint      - 线性整数规划
%  *L01p_e     - 0-1整数规划枚举法
%  *L01p_ie    - 0-1整数规划隐枚举法
%  *bnb18      - 非线性整数规划(在MATLAB5.3使用)
%  *bnbgui     - 非线性整数规划图形工具(在MATLAB5.3使用)
%  *mintreek   - 最小生成树kruskal算法
%  *minroute   - 最短路dijkstra算法
%  *krusk      - 最小生成树kruskal算法mex程序
%  *dijkstra   - 最短路dijkstra算法mex程序
%  *dynprog    - 动态规划
%
%
% 图形
%   plot       - 平面曲线（一元函数）
%   plot3      - 空间曲线
%   mesh       - 空间曲面（二元函数）
%  *meshf      - 非矩形网格图
%  *draw       - 用鼠标划光滑曲线
%
%中国大学生数学建模竞赛题解
%   jm96a      - 捕鱼策略
%   jm96b      - 节水洗衣机
%   jm96bfun   - 节水洗衣机优化函数
%   jm97a      - 零件参数设计
%   jm97afun   - 零件参数函数  
%   jm97aoptim - 零件参数设计优化函数
%   jm97b      - 截断切割
%   jm97bcount - 截断切割枚举法
%   jm97brule  - 截断切割优化准则   
%   jm98a1     - 风险投资模型求解
%   jm98a2     - 风险投资模型讨论
%   jm98a3     - 收益与风险非线性模型求解
%   jm98a3fun  - 收益与风险非线性模型优化函数
%   jm98b      - 灾情巡视路线（C程序）
%   jm99a1     - 自动化车床模型一
%   jm99a1fun   - 自动化车床模型目标函数
%   jm99a1simu  - 自动化车床模型随机模拟
%   jm99asmfun  - 自动化车床模型费用函数
%
% 演示程序
%   funtool     - 函数计算器
%   tutdemo     - MATLAB优化工具箱教程
%   mathmodl    - 数学建模工具箱演示
