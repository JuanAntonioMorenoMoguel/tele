% NDSI a partir de bandas G y SWIR 1.6um
% (Llevado a rango [1, 255])
% (Version vectorizada)

function z = ndsi_v(x, y)

  b = x > 0 & y > 0;
  g = double(x) / 255; # GREEN
  s = double(y) / 255; # SWIR 1.6um
  z = (g - s) ./ (g + s);
  z = (z + 1) * 254 / 2 + 1;
  z = z .* b;
  z = uint8(z);

end
