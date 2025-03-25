% SAR Urbano (Copernicus)

function z = ndvi(x, y)

  [F, C] = size(x);
  x = double(x) / 255; # VH
  y = double(y) / 255; # VV

  z = zeros(F, C, 3);

  for f = 1:F
    for c = 1:C
      vh = x(f, c);
      vv = y(f, c);
      r = 255 * double((5.5 * vh) > 0.5);
      g = 255 * vv;
      b = 255 * 8 * vh;
      z(f, c, :) = [r, g, b];
    end
    f
  end
  
  z = uint8(z);

end
