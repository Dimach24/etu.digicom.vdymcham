% close all
pack = [1 1 1 1 -1 -1 -1 -1];

fs = 100;

graph = zeros(1, length(pack) * fs);
graph(1:length(graph)) = pack(floor((0:length(graph)-1)/fs) + 1); 

%%
close all

% Create figure
packFigure = figure;

% Create axes
axes1 = axes('Parent',packFigure);
hold(axes1,'on');

% Create plot
plot(0:length(graph)-1, graph,'LineWidth',2,'Color',[0 0 0]);

% Create ylabel
ylabel('g(t)','VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',16,...
    'FontName','Times New Roman',...
    'Rotation',0,'Position',[-20 1.05 -1]);

% Create xlabel
xlabel('t','FontName','Times New Roman', 'FontSize', 16);
xticklabels(0:length(graph)/fs)

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

% Create axes
axes1 = axes('Parent',packFigure);
hold(axes1,'on');

% Create plot
plot(-length(graph)+1:length(graph)-1, xcorr(graph)/length(graph),'LineWidth',2,'Color',[0 0 0]);

% Create ylabel
ylabel('B(t)','VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',16,...
    'FontName','Times New Roman',...
    'Rotation',0,'Position',[-20 1.02 -1]);

% Create xlabel
xlabel('t','FontName','Times New Roman', 'FontSize', 16);
xticklabels((-length(graph)/fs+1:length(graph)/fs-1) + 3)

% Create title
% title('КФ посылки','FontSize',12,'FontName','Times New Roman');

box(axes1,'on');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'XAxisLocation','origin', 'YAxisLocation','origin','XGrid','on','YGrid','on');