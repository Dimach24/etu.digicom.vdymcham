classdef graphs
    methods(Static)
        function model_graphs(q_dB, errors, name)
            figure("Name", name)
            hold on
            scatter(q_dB, errors, Marker="+");
            plot(q_dB(1):0.1:q_dB(end), graphs.P_b_theor(q_dB(1):0.1:q_dB(end), name),"LineStyle","--");
            yscale log
            xlabel("Eb/No"); ylabel("P_{ош}")
            xlim([q_dB(1) - 1, q_dB(end) + 1])
            grid on

        end

        function visual_model_graphs(time, data, hist, name)
            figure('Name',strcat("Сигнал, метод '",name, "'"))
            plot(time, data)
            grid on
            xlabel('t, с'), ylabel('|x|')
            figure('Name',strcat("Гистограмма, метод '", name, "'"))
            bar(0:.1:4.999, hist, 1)
            grid on
            xlabel('|x|^2'); ylabel('P(|x|^2)')
        end

        function result = P_b_theor(q_dB, name) 
            q = db2pow(q_dB);
            
            switch name
                case 'АБГШ-канал'
                    result = 1/2 * exp(- q / 2); % 4.3.1 aka AWGN 
                case 'Рэлеевский канал'
                    result =  1 ./ (2 + q); % 4.3.2 aka RAYLEIGH
                case 'Выбор наиболее сильной ветви'
                    result = 4 ./ (q.^2 + 6 * q + 8); % 4.3.4 aka STRONG_CHOICE
                case 'Оптимальное сложение ветвей'
                    result = 0.5 * (2 ./ (q{4} + 2)) .^ 2; % 4.3.5 aka OPTIUM_SUM
            end
        end
    end
end