% Concentracion de NO2 a partir de visualizacion (Copernicus)
% (Version vectorizada)

function z = no2(x, a)

  x = double(x); # Datos
  a = a == 255;  # Alpha
  z = rgb2hsv(x / 255);
  z = abs(1 - z(:, :, 1));
  z = 128 + (z * 3 - 1) / 2 * 127;
  z = z .* a;
  z = uint8(z);

end
