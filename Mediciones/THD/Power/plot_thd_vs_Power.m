
% Limpio todas las variables globales.
clear all;

% Cierro todos los gr�ficos.
close all;

clc;


images_directory= './';

%%

THD_sim = dlmread('THD_vs_power_sim.txt', '\t');

THD_measured = dlmread('THD_vs_power_measured.txt', '\t');

% Porcentaje de pantalla que ocupa la imagen.
sz_perc = 100;


% Calculo el tama�o y la posici�n de la imagen.

pict_size = sz_perc/100;
pict_pos = (1 - pict_size)/2;

% Genero la figura, a un % del tama�o de la panatalla y centrada.
% No parece funcionar en Octave, pero no genera errores tampoco.
figure1 = figure('units', 'normalized', 'outerposition', ...
    [pict_pos pict_pos pict_size pict_size]);


% Create axes
axes1 = axes('Parent', figure1);
hold(axes1,'on');

yyaxis(axes1,'left');

% Create plot
plot(axes1, THD_measured(:,1), THD_measured(:,2),...
    'DisplayName','Medidio','Marker','hexagram', ...
    'Color', [1 0 0]);

% Create title
title('THD vs Potencia');

box(axes1,'on');

% Set the remaining axes properties
set(axes1,'XGrid','on','XMinorTick','on','XTick',...
    (0:1:max(THD_sim(:,1))),...
    'YGrid','on','YMinorTick','on','YTick',...
    0:0.005:1.1*max(THD_measured(:,2)));

xlim(axes1, [0 42]);

xlabel('Potencia [W]');

ylabel('THD [%]');

ylim(axes1, [0 1.1*max(THD_measured(:,2))]);

axes1.XAxis.Exponent = 0;

axes1.YAxis(1).Exponent = 0;

axes1.YAxis(1).Color = [1 0 0];

xtickangle(axes1, 75);



yyaxis(axes1,'right')

plot(axes1, THD_sim(:,1), THD_sim(:,2), ...
    'DisplayName','Simulado', 'LineStyle', '--', ...
    'Color', [0 1 0]);

% Set the remaining axes properties
set(axes1,...
    'YGrid','on','YMinorTick','on','YTick',...
    0:0.0005:1.5*max(THD_sim(:,2)));


ylim(axes1, [0 1.5*max(THD_sim(:,2))]);

ylabel('THD [%]');

axes1.YAxis(2).Exponent = 0;

axes1.YAxis(2).Color = [0 1 0];


legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.75 0.76 0.105 0.088]);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ajustar a una curva monotona.

% n_data = length(THD_measured);
% 
% degree = 3;
% 
% % limit on derivative - in each data point
% b = zeros(n_data, 1);
% 
% % coefficient matrix
% C = nan(n_data, degree+1);
% % derivative coefficient matrix
% A = nan(n_data, degree);
% 
% % loop over polynomial terms
% for ii  = 1:degree+1
%     C(:,ii) = power.^(ii-1);
%     A(:,ii) = (ii-1)*power.^(ii-2);
% end
% 
% 
% % Constrained
% p3 = fliplr(lsqlin(C,THD_measured,-A,b).');
% 
% THDp = polyval(p3, power);
% 
% plot(axes1, power, THDp, 'LineStyle','--', 'Color', [0 0 1]);


%%
%%%



%%%
graph_complete_name = ...
    fullfile(images_directory, ...
    strjoin({'THD_vs_power', ...
    '.png'}, ''));

fprintf('Salvando el gr�fico en un archivo "PNG"......');

% Salvo el gr�fico en un archivo.
saveas(figure1, graph_complete_name);

% Salvado completo.
fprintf('Listo\n\n');
%%%

