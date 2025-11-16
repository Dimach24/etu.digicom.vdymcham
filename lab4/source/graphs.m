classdef graphs
    methods(Static)
        function model_graphs(q_dB, errors, method, color, marker)
            plot(q_dB, errors, "Marker", marker, "Color", color);
            plot(q_dB(1):0.1:q_dB(end), graphs.P_b_theor(q_dB(1):0.1:q_dB(end), method),"LineStyle","--", "Color", color);
        end

        function visual_model_graphs(time, data, hist, name)
            figure('Name',strcat("Сигнал, '",name, "'"))
            plot(time, data)
            grid on
            xlabel('t, с'), ylabel('|x|')
            figure('Name',strcat("Гистограмма, '", name, "'"))
            hold on
            hist_step = 0.1;
            values = 0:hist_step:4.999;
            bar(values, hist, 1)
            q0 = 1;
            w_values = graphs.w_theor(values, q0, name);
            plot(values, w_values * hist_step, "LineWidth", 2)
            grid on
            xlabel('|x|^2'); ylabel('P(|x|^2)')
        end

        function result = P_b_theor(q_dB, name) 
            q = db2pow(q_dB);
            
            switch name
                case 'АБГШ-канал'
                    result = 1/2 * exp(- q / 2); % 4.3.1 (AWGN)
                case 'Рэлеевский канал'
                    result =  1 ./ (2 + q); % 4.3.2 aka (RAYLEIGH)
                case 'Выбор наиболее сильной ветви'
                    result = 4 ./ (q.^2 + 6 * q + 8); % 4.3.4 (SC)
                case 'Оптимальное сложение ветвей'
                    result = 0.5 * (2 ./ (q + 2)) .^ 2; % 4.3.5 (MRC)
            end
        end

        function result = w_theor(q, q0, name)
            switch name
                case 'Рэлеевский канал'
                    result = 1 ./ q0 .* exp(- q ./ q0);
                case 'Выбор наиболее сильной ветви'
                    result = 2 ./ q0 .* (1 - exp(- q ./ q0)) .* exp(- q ./ q0);
            end
        end
    end
end