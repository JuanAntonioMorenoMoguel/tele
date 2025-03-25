% Indice urbano a partir de SAR Urbano (Copernicus)
% (Version vectorizada)

function z = urbanindex_v(x, y)

  b = x > 0 & y > 0;
  x = double(x) / 255; # VH
  y = double(y) / 255; # VV
  z = 255 * (x + y);
  z = z .* b;
  z = uint8(z);

end
