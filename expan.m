% Expansion lineal de una banda

function z = expan(x, m, M)

  [F, C] = size(x);
  x = double(x);

  z = zeros(F, C);

  for f = 1:F
    for c = 1:C
      nd = x(f, c);
      if nd > 0
        ndp = ((nd - m) * 254) / (M - m) + 1;
        if ndp < 1
          ndp = 1;
        end
        if ndp > 255
          ndp = 255;
        end
        z(f, c) = ndp;
      end
    end
    f
  end

  z = uint8(z);

end
