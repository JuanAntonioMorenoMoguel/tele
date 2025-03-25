% Clasifica una banda mediante umbralizacion

function z = umbraliza(x)

  UMBRAL = [0, 154, 182, 255];

  [F, C] = size(x);
  x = double(x);

  z = zeros(F, C);

  for f = 1:F
    for c = 1:C
      nd = double(x(f, c));
      if nd > 0
        ndp = 0;
        for u = 1:3
          if nd > UMBRAL(u) && nd <= UMBRAL(u + 1)
            ndp = u;
          end
        end
        z(f, c) = ndp;
      end
    end
    f
  end

  z = uint8(z);

end
