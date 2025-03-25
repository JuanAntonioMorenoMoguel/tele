% Corte de colas en Saturacion de una imagen True-color

function z = cortehsv(x, p)

  b = 2;
  z = rgb2hsv(x);
  z = uint8(z * 255);
  z(:, :, b) = corte(z(:, :, b), p);
  z = double(z) / 255;
  z = hsv2rgb(z);
  z = uint8(z * 255);

end
