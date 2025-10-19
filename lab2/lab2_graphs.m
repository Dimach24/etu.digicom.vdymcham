close all; clear all
indexes = 1:10;

E_b_over_N_0 = [11:21; 6:16; 2:12; 2:12; -2:8; 6:16];
n_min = [4 4 4 4 4 4]; % PLACEHOLDERS
d_min = [1 1 1 1 1 1]; % PLACEHOLDERS
sigm_a = [5 5 5 5 5 5]; % PLACEHOLDERS

graphsCount = length(E_b_over_N_0(:,1));
x_axis_title = "Eb / N0, дБ";
y_axis_title = "Pош, дБ";
graph_titles = ["АМ-16" "ФМ-16" "КАМ-16" "КАМ-16 (посл. код)" "КАМ-4" "КАМ-64"];

m = [4 4 4 4 2 6];
b_mean = [1 1 1 2 1 1]; % for Gray code b_mean = 1, else idk
P_b = zeros(size(E_b_over_N_0));
for i = 1:length(E_b_over_N_0(:,1))
P_b(i,:) = b_mean(i) ./ m(i) * 2 .* n_min(i) ./ 2.^m(i) ...
    .* qfunc( ...
        sqrt(d_min(i).^2 .* m(i) .* 10 .^(E_b_over_N_0(i,:)/10) ...
        ./ (2 .* sigm_a(i).^2)) ...
       );
end

figure('Name','Кривые помехоустойчивости 16-позиционных АМ, ФМ, КАМ', 'NumberTitle', 'off')
hold on; grid on
plot(E_b_over_N_0(1,:), 10 * log10(P_b(1,:)),'LineStyle','--')
plot(E_b_over_N_0(2,:), 10 * log10(P_b(2,:)),'LineStyle','--')
plot(E_b_over_N_0(3,:), 10 * log10(P_b(3,:)),'LineStyle','--')
legend('АМ-16', 'ФМ-16', 'КАМ-16')
graphwrapper(x_axis_title, y_axis_title)

figure('Name','Кривые помехоустойчивости КАМ-16 с разными кодировками', 'NumberTitle', 'off')
hold on; grid on; 
plot(E_b_over_N_0(3,:), 10 * log10(P_b(3,:)),'LineStyle','--');
plot(E_b_over_N_0(4,:), 10 * log10(P_b(4,:)), 'LineStyle','--');
legend('Код грея', 'Посл. код')
graphwrapper(x_axis_title, y_axis_title)

figure('Name','Кривые помехоустойчивости КАМ с разными числом позиций', 'NumberTitle', 'off')
hold on; grid on
plot(E_b_over_N_0(5,:), 10 * log10(P_b(5,:)),'LineStyle','--')
plot(E_b_over_N_0(3,:), 10 * log10(P_b(3,:)),'LineStyle','--')
plot(E_b_over_N_0(6,:), 10 * log10(P_b(6,:)),'LineStyle','--')
legend('КАМ-4', 'КАМ-16', 'КАМ-64')
graphwrapper(x_axis_title, y_axis_title)

function graphwrapper(x_axis_title, y_axis_title)
    xlabel(x_axis_title);
    ylabel(y_axis_title);
end