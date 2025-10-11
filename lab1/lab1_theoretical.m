% close all
pack = [1 1 1 1 -1 -1 -1 -1];
corpack = [0 xcorr(pack) 0];


graph = zeros(1, length(pack) * fs);
graph = pack(fix((0:length(pack) * fs - 1)/fs) + 1);
corgraph = corpack(fix((0:length(corpack) * fs - 1)/fs) + 1);
corgraph = xcorr(graph)/fs;
spectrumgraph = fft(corgraph);

%%
close all

fs = 1000;
xval = 0:length(graph)-1;
yval = graph;

% Create figure
packFigure = figure;

% Create axes
axes1 = axes('Parent',packFigure);
hold(axes1,'on');

% Create plot
plot(xval, yval,'LineWidth',2,'Color',[0 0 0]);

% Create ylabel
ylabel('g(t)','VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',16,...
    'FontName','Times New Roman',...
    'Rotation',0,'Position',[-20 1.05 -1]);

% Create xlabel
xlabel('t','FontName','Times New Roman', 'FontSize', 16);
xticklabels(0:length(yval)/fs)

% Create title
% title('Форма посылки','FontSize',12,'FontName','Times New Roman');

box(axes1,'on');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'XAxisLocation','origin', 'YAxisLocation','origin','XGrid','on','YGrid','on');

%%
% createfigure(0:length(graph)-1, graph, 'Форма посылки')

% Create figure
packFigure = figure;

fs = 1;
xval = 0:length(corpack)-1;
yval = corpack;

% Create axes
axes1 = axes('Parent',packFigure);
hold(axes1,'on');

% Create plot
border = (length(corpack)-1)/2;
plot(-border:border, corpack,'LineWidth',2,'Color',[0 0 0]);

% Create ylabel
ylabel('B(t)','VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',16,...
    'FontName','Times New Roman',...
    'Rotation',0,'Position',[-20 max(corgraph)*1.02 -1]);

% Create xlabel
xlabel('t','FontName','Times New Roman', 'FontSize', 16);
xticklabels((-length(pack)/fs+1:length(pack)/fs-1) + 3)

% Create title
% title('КФ посылки','FontSize',12,'FontName','Times New Roman');

box(axes1,'on');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'XAxisLocation','origin', 'YAxisLocation','origin','XGrid','on','YGrid','on');

%% 

% fv = -4:0.01:4;
% 
% fun1 = @(t, f) -2*(t+4)*exp(-1j * 2 * pi .* f.*t);
% fun2 = @(t, f) (6*t + 8)*exp(-1j * 2 * pi .* f.*t);
% fun3 = @(t, f) (-6*t + 8)*exp(-1j * 2 * pi .* f.*t);
% fun4 = @(t, f) (2*(t-4))*exp(-1j * 2 * pi .* f.*t);
% 
% spectrum = [integral(@(t) fun1(t, fv), -4, -2, "ArrayValued",true)];
% spectrum = spectrum + [integral(@(t) fun2(t, fv), -2, 0, "ArrayValued",true)];
% spectrum = spectrum + [integral(@(t) fun3(t, fv), 0, 2, "ArrayValued",true)];
% spectrum = spectrum + [integral(@(t) fun4(t, fv), 2, 4, "ArrayValued",true)];
% 
% figure
% plot(10 * log10(abs(spectrum)))
% xticks(0:length(spectrum)/8:length(spectrum))
% xticklabels(strsplit(int2str(-4:4)))
% xlim([0 length(spectrum)])
% grid on
% xlabel("f, Гц")
% ylabel("W(f), дБ")

syms t f SPM manualSPM

SPM = int((-2*(t+4))*exp(-1j*2*pi*f*t), t, [-4 -2]) ...
    + int((6*t+8)*exp(-1j*2*pi*f*t), t, [-2 0]) ...
    + int((-6*t+8)*exp(-1j*2*pi*f*t), t, [0 2]) ...
    + int((2*(t-4))*exp(-1j*2*pi*f*t), t, [2 4]);
SPM = simplify(SPM)

manualSPM = 1/(2*f^2*pi^2)*(6+2*cos(8*pi*f)-8*cos(4*pi*f));

figure
fplot(f, 10*log10(abs(manualSPM)), [-4 4])

grid on
xlabel("f, Гц")
ylabel("W(f), дБ")
