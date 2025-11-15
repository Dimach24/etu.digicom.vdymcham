%% Вводные (менять на свой трах и риск)

model_names = {
    'model_fm2', ... % 4.3.1 (AWGN)
    'model_fm2_siso', ... % 4.3.2 (RAYLEIGH)
    'model_fm2_2siso', ... % 4.3.4 (SC)
    'model_fm2_2siso_opt', ... % 4.3.5 (MRC)
    'model_fm2_siso_visual', ... % 4.3.4 (RAYLEIGH)
    'model_fm2_2siso_visual' % 4.3.4 (RAYLEIGH)
};

% Выбор версии Simulink
if(~ismember(SIMULINK_VER, ['2022' '2025']))
    error("SIMULINK_VER имеет некорректное значение (должен быть '2022' или '2025')")
end
warning("off"); rmpath("R2022a\","R2025b\"); warning("on")
if (strcmp(SIMULINK_VER, '2022'))
    addpath("R2022a\");
else
    addpath("R2025b\");
end

save_files = {
    ["fm2_awgn.mat","errors","snrs"], ... % 4.3.1 (AWGN)
    ["fm2_awgn_oneRay.mat","errors","snrs"], ... % 4.3.2 (RAYLEIGH)
    ["fm2_awgn_twoRaysMax.mat","errors","snrs","mean_power"], ... % 4.3.4 (SC)
    ["fm2_awgn_twoRayMRC.mat","errors","snrs"], ... % 4.3.5 (MRC)
    ["scope_1ray.fig", "hist_1ray.fig"], ... % 4.3.4
    ["scope_2ray.fig", "hist_2ray.fig"] % 4.3.4
};

for i = 1:length(save_files)
    for j = 1:length(save_files{i})
        save_files{i}(j) = strcat("results\", save_files{i}(j));
    end
end

%% Чистка
if exist("results\", 'dir')
    rmdir("results\")
end
mkdir("results")
%% Моделирование 4.3.1, 4.3.2, 4.3.4, 4.3.5
for i = 1:4
    disp(strcat("Моделирование Simulink-модели '", names{i}, "'..."))
    snrs=q_dB{i};
    model = Simulink.SimulationInput(model_names{i});
    errors=zeros(1, length(snrs));
    for j=1:length(snrs)
        in=model.setVariable("EbPerNo", snrs(j));
        out=sim(in);
        errors(j)= out.Errors(1);
        if (out.Errors(2) < 100)
            disp("Warning: errors count less then 100")
            disp(errors)
        end
    end
    figure("Name", names{i})
    scatter(snrs, errors, Marker="+");
    yscale(gca(), "log")
    xlabel("Eb/No"); ylabel("P_{ош}")
    xlim([q_dB{i}(1) - 1, q_dB{i}(end) + 1])
    grid on
    for k = 1:length(save_files{i})
        save(save_files{i}(k))
    end
    % clear all;
    disp(strcat("Выполнено"))
end

%% Моделирование 4.3.3
for i = 5:6
    model = Simulink.SimulationInput(model_names{i});
    out=sim(model.setVariable("EbPerNo",20));
    figure('Name',strcat("Сигнал, метод '",names{i - 2}, "'"))
    plot(out.Scope{1}.Values.Time, squeeze(out.Scope{1}.Values.Data))
    grid on
    xlabel('t, с'), ylabel('|x|')
    savefig(save_files{i}(1))
    figure('Name',strcat("Гистограмма, метод '",names{i - 2}, "'"))
    bar(0:.1:4.999,out.Hist,1)
    grid on
    xlabel('|x|^2'); ylabel('P(|x|^2)')
    savefig(save_files{i}(2))
    if (i == 6)
        mean_power=out.MeanPower;
    end
    disp(strcat("Моделирование Simulink-модели '", names{i - 2}, " - наблюдение' выполнено"))
end