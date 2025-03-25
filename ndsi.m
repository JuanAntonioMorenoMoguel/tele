% NDSI a partir de bandas G y SWIR 1.6um
% (Llevado a rango [1, 255])

function z = ndsi(x, y)

  [F, C] = size(x);
  x = double(x) / 255;
  y = double(y) / 255;

  z = zeros(F, C);

  for f = 1:F
    for c = 1:C
      g = x(f, c);
      s = y(f, c);
      if g > 0 && s > 0
        ix = (g - s) / (g + s);
        ndp = (ix + 1) * 254 / 2 + 1;
        z(f, c) = ndp;
      end
    end
    f
  end
  
  z = uint8(z);

end
