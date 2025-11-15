clc; clear all; close all;
%% Вводные

% диапазоны варьирования ОСШ
q_dB = {
    0:2:12, ... % 4.3.1 АБГШ-канал (AWGN) 
    0:5:30, ... % 4.3.2 Рэлеевский канал (RAYLEIGH)
    0:2:20, ... % 4.3.4 Выбор наиболее сильной ветви(SC)
    0:2:14  ... % 4.3.5 Оптимальное сложение ветвей(MRC)
};

DO_SIMULATION = true; % {true; false} если true, удалит предыдущие results и выполнит симуляцию заново
SIMULINK_VER = '2022'; % {'2022', '2025'}

%% Запуск

names = {
    'АБГШ-канал', ... % 4.3.1 aka AWGN
    'Рэлеевский канал', ... % 4.3.2 aka RAYLEIGH
    'Выбор наиболее сильной ветви', ... % 4.3.4 aka SC (Selection Combining)
    'Оптимальное сложение ветвей' % 4.3.5 aka MRC (Maximum Ratio Combining)
};

addpath("source\")
if (DO_SIMULATION)
    simulation % создаёт данные и строит графики по ним
else
    graphs % строит графики по ранее созданным данным
end