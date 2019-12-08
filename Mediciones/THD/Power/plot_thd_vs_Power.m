
% Limpio todas las variables globales.
clear all;

% Cierro todos los gráficos.
close all;

clc;


power = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 20 25 30 35 40];


THD = [0.038 0.033 0.026 0.028 0.030 0.021 0.030 0.038 0.042 0.062 ...
    0.093 0.098 0.075 0.066 0.077 0.075 0.068 0.074 0.074 0.073];

% Porcentaje de pantalla que ocupa la imagen.
sz_perc = 100;

images_directory = ".";

% Calculo el tamaño y la posición de la imagen.

pict_size = sz_perc/100;
pict_pos = (1 - pict_size)/2;

% Genero la figura, a un % del tamaño de la panatalla y centrada.
% No parece funcionar en Octave, pero no genera errores tampoco.
figure1 = figure('units', 'normalized', 'outerposition', ...
    [pict_pos pict_pos pict_size pict_size]);


% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create plot
plot(power, THD, 'Color', [1 0 0]);

% Create title
title('THD vs Potencia');

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XGrid','on','XMinorTick','on','XTick',...
    (0:1:40),...
    'YGrid','on','YMinorTick','on','YTick',...
    0:0.005:0.1);


axes1.XAxis.Exponent = 0;

axes1.YAxis.Exponent = 0;

xtickangle(axes1, 75);



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ajustar a una curva monotona.

n_data = length(THD);

degree = 3;

% limit on derivative - in each data point
b = zeros(n_data, 1);

% coefficient matrix
C = nan(n_data, degree+1);
% derivative coefficient matrix
A = nan(n_data, degree);

% loop over polynomial terms
for ii  = 1:degree+1
    C(:,ii) = power.^(ii-1);
    A(:,ii) = (ii-1)*power.^(ii-2);
end


% Constrained
p3 = fliplr(lsqlin(C,THD,-A,b).');

THDp = polyval(p3, power);

plot(axes1, power, THDp,'LineStyle','--', 'Color', [0 0 1]);


%%
%%%



%%%
graph_complete_name = ...
    fullfile(images_directory, ...
    strjoin({'THD_vs_power', ...
    '.png'}, ''));

fprintf('Salvando el gráfico en un archivo "PNG"......');

% Salvo el gráfico en un archivo.
saveas(figure1, graph_complete_name);

% Salvado completo.
fprintf('Listo\n\n');
%%%

