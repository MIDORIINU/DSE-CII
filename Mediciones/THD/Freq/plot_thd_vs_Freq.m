
% Limpio todas las variables globales.
clear all;

% Cierro todos los gráficos.
close all;

clc;


freq = flip([19000 18000 17000 16000 15000 14000 13000 12000 11000 ...
    10000 9000 8000 7000 6000 5000 4000 3000 2000 1000 ...
    900 800 700 600 500 400 300 200 100 50 20]);


THD = flip([0.32 0.32 0.37 0.32 0.31 0.27 0.26 0.27 0.25 0.28 0.24 0.24 ...
    0.19 0.17 0.15 0.13 0.11 0.08 0.05 0.03 0.06 0.02 0.02 0.03 ...
    0.08 0.01 0.008 0.005 0.003 0.01]);

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
plot(axes1, freq, THD,'Marker','hexagram', 'Color', [0 1 0]);

% Create title
title('THD vs Frecuencia');

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XScale','log','XGrid','on','XMinorTick','on','XTick',...
    [ 20:50:900 1000:500:4500 5000:1000:20000 ],...
    'YGrid','on','YMinorTick','on','YTick',...
    0:0.01:0.4);

xlim(axes1, [20 20000]);

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
    C(:,ii) = freq.^(ii-1);
    A(:,ii) = (ii-1)*freq.^(ii-2);
end


% Constrained
p3 = fliplr(lsqlin(C,THD,-A,b).');

THDp = polyval(p3, freq);

plot(axes1, freq, THDp, 'LineStyle','--', 'Color', [0 0 1]);


%%
%%%


graph_complete_name = ...
    fullfile(images_directory, ...
    strjoin({'THD_vs_frequency', ...
    '.png'}, ''));

fprintf('Salvando el gráfico en un archivo "PNG"......');

% Salvo el gráfico en un archivo.
saveas(figure1, graph_complete_name);

% Salvado completo.
fprintf('Listo\n\n');
%%%

