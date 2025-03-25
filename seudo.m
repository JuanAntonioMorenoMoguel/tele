% Seudocolor de una banda

function z = seudo(x)

  UMBRAL = 128;

  [F, C] = size(x);
  x = double(x);

  z = zeros(F, C, 3);

  for f = 1:F
    for c = 1:C
      nd = x(f, c);
      if nd > 0
        if nd < UMBRAL
          z(f, c, :) = [0 0 255];
        else
          z(f, c, :) = [0 255 0];
        end
      end
    end
    f
  end

  z = uint8(z);

end
