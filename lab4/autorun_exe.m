clc; clear all; close all;
%% Вводные

% диапазоны варьирования ОСШ
q_dB = {
    0:2:12, ... % 4.3.1 АБГШ-канал (AWGN) 
    0:5:30, ... % 4.3.2 Рэлеевский канал (RAYLEIGH)
    0:2:20, ... % 4.3.4 Выбор наиболее сильной ветви(SC)
    0:2:14  ... % 4.3.5 Оптимальное сложение ветвей(MRC)
};

SIMULINK_VER = '2022'; % {'2022', '2025'}

names = {
    'АБГШ-канал', ... % 4.3.1 aka AWGN
    'Рэлеевский канал', ... % 4.3.2 aka RAYLEIGH
    'Выбор наиболее сильной ветви', ... % 4.3.4 aka SC (Selection Combining)
    'Оптимальное сложение ветвей' % 4.3.5 aka MRC (Maximum Ratio Combining)
};

colors = orderedcolors("gem");

markers = {"+", "x", "pentagram", "*"};

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
%% Запуск симуляции с удалением старых данных

simulation % создаёт данные (удаляет старые)
addpath("results\")

%% Построение графиков

close all;

% строит графики по ранее созданным данным
% п. 1, 2, 4, 5
figure("Name", "Кривые помехоустойчивости")
hold on
for i = 1:4 
    load(save_files{i}(1))
    graphs.model_graphs(snrs, errors, names{i}, colors(i,:), markers{i})
end 
yscale log
xlabel("E_b/N_0"); ylabel("P_{ош}")
xlim([min(cell2mat(q_dB)) - 1, max(cell2mat(q_dB)) + 1])
grid on
legend(names{1}, '', names{2}, '', names{3}, '', names{4}, '')

% п. 3
for i = 5:6 
    load(save_files{i}(1))
    graphs.visual_model_graphs(time, data, hist, names{i - 3})
    disp(strcat("Средняя мощность в модели '", names{i - 3}, "', составляет ", num2str(mean_power)))
end
%%
disp("Скрипт завершён")