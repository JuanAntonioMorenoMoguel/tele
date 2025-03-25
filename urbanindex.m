% Indice urbano a partir de SAR Urbano (Copernicus)

function z = urbanindex(x, y)

  [F, C] = size(x);
  x = double(x) / 255; # VH
  y = double(y) / 255; # VV

  z = zeros(F, C);

  for f = 1:F
    for c = 1:C
      vh = x(f, c);
      vv = y(f, c);
      if vh > 0 && vv > 0
        z(f, c) = 255 * (vh + vv);
      end
    end
    f
  end
  
  z = uint8(z);

end
