% Script para analizar la banda NIR y mostrar histogramas de píxeles iluminados
clear;
clc;

% Ruta del dataset
base_origin_path = fullfile(pwd, 'dataset');
base_target_path = fullfile(pwd, 'res');

disp(['Ruta absoluta del dataset: ', base_origin_path]);
disp(['Ruta absoluta de los resultados: ', base_target_path]);

umbral = 10
% Recorrer cada año y mes
for year = 2015:2023
    for month = 1:12
        % Crear la ruta completa del archivo
        month_folder = sprintf('%02d', month);
        filename = sprintf('viirs_nightlights_%d-%02d-01.tif', year, month);
        origin_path = fullfile(base_origin_path, num2str(year), month_folder, filename);
        target_path = fullfile(base_target_path,num2str(year),month_folder)

        % Verificar si el archivo existe
        if ~exist(target_path, 'file')
          mkdir(target_path);
        endif
        if exist(origin_path, 'file')
            fprintf('Procesando archivo: %s\n', origin_path);

            % Leer la imagen
            img = imread(origin_path);

            % Verificar las dimensiones de la imagen
            [rows, cols, bands] = size(img);
            if bands < 3
                fprintf('Advertencia: La imagen %s no tiene suficientes bandas para análisis.\n', origin_path);
                continue;
            end

            % Extraer la banda NIR (tercera banda)
            banda_nir = mean(img, 3);

            % Filtrar los píxeles no negros (intensidad mayor que el umbral)
            pixeles_relevantes = banda_nir(banda_nir > umbral);

            if isempty(pixeles_relevantes)
                fprintf('No se encontraron píxeles relevantes en %s\n', origin_path);
                continue;
            end
            % Guardar la banda NIR filtrada
            banda_filtrada = banda_nir;
            banda_filtrada(banda_nir <= umbral) = 0;
            imwrite(uint8(banda_filtrada / max(banda_filtrada(:)) * 255), fullfile(target_path, 'banda_nir_filtrada.png'));

            % Histograma de píxeles relevantes
            figure;
            hist(pixeles_relevantes, 256, 'FaceColor', 'r', 'EdgeColor', 'k');
            xlabel('Nivel de intensidad (NIR)');
            ylabel('Frecuencia');
            title(sprintf('Histograma de Píxeles Relevantes (NIR) - %d-%02d-01', year, month));
            frame = getframe(gcf);
            close;
            imagen = frame.cdata;

            % Guardar la imagen con imwrite
            imwrite(imagen, fullfile(target_path, 'histograma_con_imwrite.png'));
            % Composición True-Color (RGB estándar)
            imwrite(uint8(img),fullfile(target_path, 'true_color.png'))

            % Composición en falso color (NIR-R-G)
            false_color_img = zeros(rows, cols, 3, 'uint8');
            false_color_img(:, :, 1) = uint8(banda_nir / max(banda_nir(:)) * 255); % NIR como Rojo
            false_color_img(:, :, 2) = img(:, :, 1);  % Red original como Verde
            false_color_img(:, :, 3) = img(:, :, 2);  % Green original como Azul
            imwrite(uint8(false_color_img),fullfile(target_path, 'false_color.png'))
        else
            fprintf('Imagen no encontrada: %s\n', origin_path);
        end
    end
end
