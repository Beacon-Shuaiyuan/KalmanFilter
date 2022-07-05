%-------------  Optimal Recursive Data Processing Algorithm  -------------%
close all;
clear;
clc;
%% System Defination
% System Matrix
A = [1, 1; 0, 1];
H = [1, 0; 0, 1];

% Recursive Times
L = 100;
TimeAxis = 1:L;

%% Input Defination

% Random Notise
Q = [1.00, 0; 0, 1.00]; Epro = [0; 0];% Process Noise Covariance Matrix and Mathematical Expectaion
R = [0.10, 0; 0, 0.10]; Emea = [0; 0];% Measurement Noise Covariance Matrix and Mathematical Expectation
w = mvnrnd(Epro, Q, L);
v = mvnrnd(Emea, R, L);

% Initial Value
x = zeros(2, 1, L);    x(:,:,1) = [0.000; 1.000]; % Real Position and Real Speed
xhat = zeros(2, 1, L); xhat(:,:,1) = [0.000; 1.000]; % Estimatation Postion and Speed
p = zeros(2, 2, L);    p(:,:,1) = [1, 0; 0, 1];

% Measurement Position and Speed Value
z = zeros(2, 1, L);

% 先验数组
xpri = zeros(2, 1, L);
ppri = zeros(2, 2, L);

%% Data Simulation

for k = 2:L
    x(:, :, k) = A*x(:,:,k-1) + w(k-1);
    z(:, :, k) = H*x(:,:,k) + v(k);
end

%% Recursive Algorithm
for k = 2:L
    % Prediction 
    xpri(:,:,k) = A * xhat(:,:,k-1);
    ppri(:,:,k) = A * p(:,:,k-1) * A' + Q;
    % Corrent
    KalmanGain = (ppri(:,:,k) * H')/(H * ppri(:,:,k) * H' + R);
    xhat(:,:,k) = xpri(:,:,k) + KalmanGain*(z(:,:,k) - H * xpri(:,:,k));
    p(:,:,k) = (eye(2,2) - KalmanGain*H)*ppri(:,:,k);
end
%% Visualization Results
fig1 = figure(1);
% fig1.Position = [0 0 800 600];
fig1.Units = 'inches';%设置图窗的测量单位
fig2 = figure(2);
% fig2.Position = [0 0 500 700];
fig2.Units = 'inches';%设置图窗的测量单位
fontsize = 14;
fontname = 'Times New Roman';

figure(fig1);
% 绘图
plot(TimeAxis,reshape(x(1,1,:),L,1),'Linewidth',1.5);
hold on;
plot(TimeAxis,reshape(z(1,1,:),L,1),'Linewidth',1.5);
hold on;
plot(TimeAxis,reshape(xpri(1,1,:),L,1),'Linewidth',1.5);
hold on;
plot(TimeAxis,reshape(xhat(1,1,:),L,1),'Linewidth',1.5);

ax1 = fig1.CurrentAxes; %通过fig.CurrentAxes获取当前图窗中的目标坐标区进行属性设置
%坐标轴
ax1.LineWidth = 1;
ax1.FontSize = fontsize;
ax1.FontName = fontname;
% 网格线
ax1.XGrid = 'on';%每个坐标轴方向的主网格线的显示方式
ax1.YGrid = 'on';
ax1.GridLineStyle = '--';
ax1.GridColor = 'black';
ax1.GridAlpha = 0.5;
ax1.Layer = 'bottom';

%图例设置
legend();
ax1.Legend.Interpreter = 'Tex';
ax1.Legend.FontSize = fontsize;
ax1.Legend.FontName = '宋体';
ax1.Legend.Position = [0.20 0.60 0.20 0.25];
ax1.Legend.String = {'实际位置','测量位置','先验估计位置','后验估计位置'};

% 总标题
ax1.Title.Interpreter = 'LaTex';
ax1.Title.FontSize = fontsize;
ax1.Title.String = '$\textbf{Position Comparision}$';
% X轴标题
ax1.XLabel.Interpreter = 'LaTex';
ax1.XLabel.FontSize = fontsize;
ax1.XLabel.String = '$\textbf{Recursion Times}$'; %字体设置

figure(fig2);
% 绘图
plot(TimeAxis,reshape(x(2,1,:),L,1),'Linewidth',1.5);
hold on;
plot(TimeAxis,reshape(z(2,1,:),L,1),'Linewidth',1.5);
hold on;
plot(TimeAxis,reshape(xpri(2,1,:),L,1),'Linewidth',1.5);
hold on;
plot(TimeAxis,reshape(xhat(2,1,:),L,1),'Linewidth',1.5);

ax1 = fig2.CurrentAxes; %通过fig.CurrentAxes获取当前图窗中的目标坐标区进行属性设置
%坐标轴
ax1.LineWidth = 1;
ax1.FontSize = fontsize;
ax1.FontName = fontname;
% 网格线
ax1.XGrid = 'on';%每个坐标轴方向的主网格线的显示方式
ax1.YGrid = 'on';
ax1.GridLineStyle = '--';
ax1.GridColor = 'black';
ax1.GridAlpha = 0.5;
ax1.Layer = 'bottom';

%图例设置
legend();
ax1.Legend.Interpreter = 'Tex';
ax1.Legend.FontSize = fontsize;
ax1.Legend.FontName = '宋体';
ax1.Legend.Position = [0.40 0.65 0.20 0.25];
ax1.Legend.String = {'实际速度','测量速度','先验估计速度','后验估计速度'};

% 总标题
ax1.Title.Interpreter = 'LaTex';
ax1.Title.FontSize = fontsize;
ax1.Title.String = '$\textbf{Speed Comparision}$';
% X轴标题
ax1.XLabel.Interpreter = 'LaTex';
ax1.XLabel.FontSize = fontsize;
ax1.XLabel.String = '$\textbf{Recursion Times}$'; %字体设置

