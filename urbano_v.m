% SAR Urbano (Copernicus)
% (Version vectorizada)

function z = urbano_v(x, y)

  x = double(x) / 255; # VH
  y = double(y) / 255; # VV
  z = double((5.5 * x) > 0.5);
  z(:, :, 2) = y;
  z(:, :, 3) = x * 8;
  z = z * 255;
  z = uint8(z);

end
