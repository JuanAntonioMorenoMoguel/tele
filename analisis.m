% Para cada imagen, calcula la media de luminosidad (nivel de gris promedio)
% y agrupa estos valores por año.
% Finalmente, se genera una gráfica de línea que muestra la evolución de
% la luminosidad a lo largo de los años.
% Script para analizar la banda NIR y mostrar histogramas de píxeles iluminados

clear;
clc;

% Ruta del dataset
base_path = fullfile(pwd, 'res');
disp(['Ruta absoluta del dataset: ', base_path]);

% Inicializar estructura para almacenar datos
luminosidad_anyo_mensual = struct();
umbral = 10; % Definir umbral de luminosidad

% Recorrer cada año y mes
for year = 2014:2023
    for month = 1:12
        month_folder = sprintf('%02d', month);
        full_path = fullfile(base_path, num2str(year), month_folder, 'true_color.png');

        % Verificar si el archivo existe
        if ~isfile(full_path)
            continue;
        end

        try
            banda = imread(full_path);
            if ndims(banda) == 3
                banda = mean(banda, 3);
            end
            media_luminosidad = mean(banda(:));

            % Guardar la media en la estructura
            year_str = num2str(year);
            if ~isfield(luminosidad_anyo_mensual, year_str)
                luminosidad_anyo_mensual.(year_str) = [];
            end
            luminosidad_anyo_mensual.(year_str) = [luminosidad_anyo_mensual.(year_str), media_luminosidad];

        catch ME
            disp(['Error al procesar ', full_path, ': ', ME.message]);
            continue;
        end
    end
end

% Calcular la media anual de luminosidad para cada año
years = [];
media_anual = [];
campos = fieldnames(luminosidad_anyo_mensual);

for i = 1:length(campos)
    year = str2double(campos{i});
    if isnan(year)
        continue;
    end
    years = [years, year];
    media_anual = [media_anual, mean(luminosidad_anyo_mensual.(campos{i}))];
end

% Verificar si hay datos antes de graficar
if isempty(years)
    disp('No hay datos para graficar.');
    return;
end

% Ordenar los años y las medias
[years, orden] = sort(years);
media_anual = media_anual(orden);

% Ajustar dinámicamente el eje Y
y_min = min(media_anual) * 0.95;
y_max = max(media_anual) * 1.05;
if y_min < 0
    y_min = 0;
end

% Graficar la evolución
figure;
plot(years, media_anual, 'mo-', 'LineWidth', 2, 'MarkerFaceColor', 'm');
xlabel('Año', 'FontSize', 14);
ylabel('Luminosidad Promedio', 'FontSize', 14);
title('Evolución de la Luminosidad a lo largo de los Años', 'FontSize', 16);
ylim([y_min, y_max]);
grid on;
frame = getframe(gcf);
close;
imagen = frame.cdata;
imwrite(imagen, fullfile(base_path, 'histograma_lum_por_anyo.png'));

