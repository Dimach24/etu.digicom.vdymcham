clc; clear all; close all;
%% Вводные

% диапазоны варьирования ОСШ
q_dB = {
    0:2:12, ... % 4.3.1 АБГШ-канал (AWGN) 
    0:5:30, ... % 4.3.2 Рэлеевский канал (RAYLEIGH)
    0:2:20, ... % 4.3.4 Выбор наиболее сильной ветви(SC)
    0:2:14  ... % 4.3.5 Оптимальное сложение ветвей(MRC)
};

DO_SIMULATION = false; % {true; false} если true, удалит предыдущие results и выполнит симуляцию заново
SIMULINK_VER = '2022'; % {'2022', '2025'}

%% Запуск модели (можно отключить) и построение графиков

names = {
    'АБГШ-канал', ... % 4.3.1 aka AWGN
    'Рэлеевский канал', ... % 4.3.2 aka RAYLEIGH
    'Выбор наиболее сильной ветви', ... % 4.3.4 aka SC (Selection Combining)
    'Оптимальное сложение ветвей' % 4.3.5 aka MRC (Maximum Ratio Combining)
};

save_files = {
    "fm2_awgn.mat", ... % 4.3.1 (AWGN)
    "fm2_awgn_oneRay.mat", ... % 4.3.2 (RAYLEIGH)
    "fm2_awgn_twoRaysMax.mat", ... % 4.3.4 (SC)
    "fm2_awgn_twoRayMRC.mat", ... % 4.3.5 (MRC)
    "time_data_hist1.mat", ... % 4.3.4 (SC)
    "time_data_hist2.mat" % 4.3.4 (MRC)
};

for i = 1:length(save_files)
    for j = 1:length(save_files{i})
        save_files{i}(j) = strcat("results\", save_files{i}(j));
    end
end

addpath("source\")
if (DO_SIMULATION)
    simulation % создаёт данные (удаляет старые)
end

addpath("results\")

% строит графики по ранее созданным данным
for i = 1:4 % п. 1, 2, 4, 5
    load(save_files{i}(1))
    graphs.model_graphs(snrs, errors, names{i})
end 

for i = 5:6 % п. 3
    load(save_files{i}(1))
    graphs.visual_model_graphs(time, data, hist, names{i - 2})
end