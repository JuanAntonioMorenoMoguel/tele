% NDVI a partir de bandas R y NIR
% (Llevado a rango [1, 255])
% (Version vectorizada)

function z = ndvi_v(x, y)

  b = x > 0 & y > 0;
  r = double(x) / 255; # RED
  n = double(y) / 255; # NIR
  z = (n - r) ./ (n + r);
  z = (z + 1) * 254 / 2 + 1;
  z = z .* b;
  z = uint8(z);

end
