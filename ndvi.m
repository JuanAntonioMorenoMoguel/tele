% NDVI a partir de bandas R y NIR
% (Llevado a rango [1, 255])

function z = ndvi(x, y)

  [F, C] = size(x);
  x = double(x) / 255; # RED
  y = double(y) / 255; # NIR

  z = zeros(F, C);

  for f = 1:F
    for c = 1:C
      r = x(f, c);
      n = y(f, c);
      if r > 0 && n > 0
        ix = (n - r) / (n + r);
        ndp = (ix + 1) * 254 / 2 + 1;
        z(f, c) = ndp;
      end
    end
    f
  end
  
  z = uint8(z);

end
