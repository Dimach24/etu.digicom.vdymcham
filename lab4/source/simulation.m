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

%% Чистка
if exist("results\", 'dir')
    rmdir("results\","s")
end
mkdir("results")
%% Моделирование 4.3.1 (1), 4.3.2 (2), 4.3.4 (3), 4.3.5 (4)
for i = 1
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
        end
        disp(errors)
    end
    if (i~=3)
        save(save_files{i}, 'snrs', 'errors')
    else
        save(save_files{i}, 'snrs', 'errors')
    end
    disp(strcat("Выполнено"))
    % graphs.model_graphs(snrs, errors, names{i})
end

%% Моделирование 4.3.3
for i = 5:6
    model = Simulink.SimulationInput(model_names{i});
    out=sim(model.setVariable("EbPerNo",20));
    time = out.Scope{1}.Values.Time;
    data = squeeze(out.Scope{1}.Values.Data);
    hist = out.Hist;
    if (i~=6)
        save(save_files{i}, "time", "data", "hist")
    else
        mean_power=out.MeanPower;
        save(save_files{i}, "time", "data", "hist", "mean_power")
    end
    disp(strcat("Моделирование Simulink-модели '", names{i - 2}, " - наблюдение' выполнено"))
    % graphs.visual_model_graphs(timeData(:,1), timeData(:,2), hist, names{i - 2})
end