clear;
clc;

base_origin_path = fullfile(pwd, 'dataset');
base_target_path = fullfile(pwd, 'res');

umbral = 10

for year = 2015:2020
    for month = 1:12

        month_folder = sprintf('%02d', month);
        filename = sprintf('viirs_nightlights_%d-%02d-01.tif', year, month);
        origin_path = fullfile(base_origin_path, num2str(year), month_folder, filename);
        target_path = fullfile(base_target_path,num2str(year),month_folder)

        if ~exist(target_path, 'file')
          mkdir(target_path);
        endif

        if exist(origin_path, 'file')
            fprintf('Procesando archivo: %s\n', origin_path);
            img = imread(origin_path);

            [rows, cols, bands] = size(img);
            if bands < 3
                fprintf('Advertencia: La imagen %s no tiene suficientes bandas para análisis.\n', origin_path);
                continue;
            end

            banda_nir = mean(img, 3);
            pixeles_relevantes = banda_nir(banda_nir > umbral);

            if isempty(pixeles_relevantes)
                fprintf('No se encontraron píxeles relevantes en %s\n', origin_path);
                continue;
            end

            banda_filtrada = banda_nir;
            banda_filtrada(banda_nir <= umbral) = 0;
            imwrite(uint8(banda_filtrada / max(banda_filtrada(:)) * 255), fullfile(target_path, 'banda_nir.png'));

            figure;
            hist(pixeles_relevantes, 256, 'FaceColor', 'r', 'EdgeColor', 'k');
            xlabel('Nivel de intensidad (NIR)');
            ylabel('Frecuencia');
            title(sprintf('Histograma de Píxeles Relevantes (NIR) - %d-%02d', year, month));
            frame = getframe(gcf);
            close;
            imagen = frame.cdata;

            imwrite(imagen, fullfile(target_path, 'histograma.png'));

            imwrite(uint8(img),fullfile(target_path, 'true_color.png'))

            false_color_img = zeros(rows, cols, 3, 'uint8');
            false_color_img(:, :, 1) = uint8(banda_nir / max(banda_nir(:)) * 255);
            false_color_img(:, :, 2) = img(:, :, 1);
            false_color_img(:, :, 3) = img(:, :, 2);
            imwrite(uint8(false_color_img),fullfile(target_path, 'false_color.png'))

            data = isodata_v(img)
            plot(uint8(data))

            %Genera el mapa de clasificacion
            banda_filtrada = banda_filtrada / max(banda_filtrada(:)) * 6;
            banda_filtrada = round(banda_filtrada)+1;
            banda_filtrada = min(max(banda_filtrada, 1), 7);
            mapa_class = mapa_v(banda_filtrada)
            imwrite(mapa_class,fullfile(target_path, 'mapa_clasificacion.png'));
        else
            fprintf('Imagen no encontrada: %s\n', origin_path);
        end
    end
end
