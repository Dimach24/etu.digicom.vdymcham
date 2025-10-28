close all; clear all
indexes = 1:10;

% rcosdesign(1, 6, 16, 'sqrt')*4
load("lab2.mat")
errors = [errors_am; errors_pm; errors_qam16; errors_qam_bin; errors_qam4; errors_qam64];
clear errors_am errors_pm errors_qam16 errors_qam_bin errors_qam4 errors_qam64
clear snrs_am snrs_pm snrs_qam16 snrs_qam_bin snrs_qam4 snrs_qam64
E_b_over_N_0 = [11:21; 6:16; 2:12; 2:12; -2:8; 6:16];
n_min = [15 16 24 24 4 112];
d_min = [0.2169 0.3901 0.6325 0.6325 1.4142 0.3086];
sigm_a = [1 1 1 1 1 1];

graphsCount = length(E_b_over_N_0(:,1));
x_axis_title = "Eb / N0, дБ";
y_axis_title = "Pош, дБ";
graph_titles = ["АМ-16" "ФМ-16" "КАМ-16" "КАМ-16 (посл. код)" "КАМ-4" "КАМ-64"];

m = [4 4 4 4 2 6];
b_seq = ((1+2+1+1+2+1+1+2+1+1+2+1)+(2+2+2+2)+(1+1+1+1+1+1+1+1))/24;
b_mean = [1 1 1 b_seq 1 1];
P_b = zeros(size(E_b_over_N_0));
for i = 1:length(E_b_over_N_0(:,1))
P_b(i,:) = b_mean(i) ./ m(i) * 2 .* n_min(i) ./ 2.^m(i) ...
    .* qfunc( ...
        sqrt(d_min(i).^2 .* m(i) .* 10 .^(E_b_over_N_0(i,:)/10) ...
        ./ (2 .* sigm_a(i).^2)) ...
       );
end
%%
colors = orderedcolors("gem");
figure
% figure('Name','Кривые помехоустойчивости 16-позиционных АМ, ФМ, КАМ', 'NumberTitle', 'off')
subplot(2,2,1)
hold on; grid on
plot(E_b_over_N_0(1,:), 10 * log10(errors(1,:)), 'LineStyle','-','Color',colors(1,:),Marker='.', MarkerSize=10)
plot(E_b_over_N_0(1,:), 10 * log10(P_b(1,:)),'LineStyle','--','Color',colors(1,:))
plot(E_b_over_N_0(2,:), 10 * log10(errors(2,:)), 'LineStyle','-','Color',colors(2,:),Marker='x', MarkerSize=10)
plot(E_b_over_N_0(2,:), 10 * log10(P_b(2,:)),'LineStyle','--','Color',colors(2,:))
plot(E_b_over_N_0(3,:), 10 * log10(errors(3,:)), 'LineStyle','-','Color',colors(3,:),Marker='o', MarkerSize=5)
plot(E_b_over_N_0(3,:), 10 * log10(P_b(3,:)),'LineStyle','--','Color',colors(3,:))
legend('АМ-16', '', 'ФМ-16','', 'КАМ-16','')
graphwrapper(x_axis_title, y_axis_title, 'Кривые помехоустойчивости 16-позиционных АМ, ФМ, КАМ')

% figure('Name','Кривые помехоустойчивости КАМ-16 с разными кодировками', 'NumberTitle', 'off')
subplot(2,2,2)
hold on; grid on; 
plot(E_b_over_N_0(3,:), 10 * log10(errors(3,:)),'LineStyle','-','Color',colors(1,:),Marker='.', MarkerSize=10);
plot(E_b_over_N_0(3,:), 10 * log10(P_b(3,:)),'LineStyle','--','Color',colors(1,:));
plot(E_b_over_N_0(4,:), 10 * log10(errors(4,:)),'LineStyle','-','Color',colors(2,:),Marker='x', MarkerSize=10);
plot(E_b_over_N_0(4,:), 10 * log10(P_b(4,:)), 'LineStyle','--','Color',colors(2,:));
legend('Код грея', '', 'Посл. код','')
graphwrapper(x_axis_title, y_axis_title,'Кривые помехоустойчивости КАМ-16 с разными размещениями')

% figure('Name','Кривые помехоустойчивости КАМ с разными числом позиций', 'NumberTitle', 'off')
subplot(2,2,3)
hold on; grid on
plot(E_b_over_N_0(5,:), 10 * log10(errors(5,:)),'LineStyle','-','Color',colors(1,:),Marker='.', MarkerSize=10);
plot(E_b_over_N_0(5,:), 10 * log10(P_b(5,:)),'LineStyle','--','Color',colors(1,:))
plot(E_b_over_N_0(3,:), 10 * log10(errors(3,:)),'LineStyle','-','Color',colors(2,:),Marker='x', MarkerSize=10);
plot(E_b_over_N_0(3,:), 10 * log10(P_b(3,:)),'LineStyle','--','Color',colors(2,:))
plot(E_b_over_N_0(6,:), 10 * log10(errors(6,:)),'LineStyle','-','Color',colors(3,:),Marker='o', MarkerSize=5);
plot(E_b_over_N_0(6,:), 10 * log10(P_b(6,:)),'LineStyle','--','Color',colors(3,:))
legend('КАМ-4', '', 'КАМ-16', '', 'КАМ-64', '')
graphwrapper(x_axis_title, y_axis_title,'Кривые помехоустойчивости КАМ с разными числом позиций')

function graphwrapper(x_axis_title, y_axis_title, plot_title)
    xlabel(x_axis_title);
    ylabel(y_axis_title);
    title(plot_title);
end
rcosine