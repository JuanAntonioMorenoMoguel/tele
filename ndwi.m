% NDWI a partir de bandas G y NIR
% (Llevado a rango [1, 255])

function z = ndwi(x, y)

  [F, C] = size(x);
  x = double(x) / 255; # G
  y = double(y) / 255; # NIR

  z = zeros(F, C);

  for f = 1:F
    for c = 1:C
      g = x(f, c);
      n = y(f, c);
      if g > 0 && n > 0
        ix = (g - n) / (g + n);
        ndp = (ix + 1) * 254 / 2 + 1;
        z(f, c) = ndp;
      end
    end
    f
  end
  
  z = uint8(z);

end
