% Filtro de media de una banda

function z = fmedia(x)

  [F, C] = size(x);
  x = double(x);

  z = zeros(F, C);

  for f = 2:F-1
    for c = 2:C-1
      nd = x(f, c);
      if nd > 0
        en = x(f-1:f+1, c-1:c+1);
        ndp = sum(sum(en)) / 9;
      else
        ndp = 0;
      end
      z(f, c) = ndp;
    end
    f
  end

  z = uint8(z);

end
