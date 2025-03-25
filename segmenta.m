% Segmentacion de una banda

function z = segmenta(x)

  N = 7; # MAXIMO = 7
  MIN = 128;
  MAX = 255;
  UMBRAL = [MIN];
  for n = 1:N
    UMBRAL = [UMBRAL, MIN + (n * (MAX - MIN)) / N];
  end
  UMBRAL

  RGB = [ 64,  64,  64  ;  % GRIS OSCURO
         255,   0, 255  ;  % VIOLETA
           0,   0, 255  ;  % AZUL
           0, 255, 255  ;  % CELESTE
           0, 255,   0  ;  % VERDE
         255, 255,   0  ;  % AMARILLO
         255, 166,   0  ;  % NARANJA
         255,   0,   0 ];  % ROJO

  [F, C] = size(x);
  x = double(x);

  z = zeros(F, C, 3);

  for f = 1:F
    for c = 1:C
      nd = double(x(f, c));
      if nd > 0
        z(f, c, :) = RGB(1);
        for n = 1:N
          if nd > UMBRAL(n) && nd <= UMBRAL(n + 1)
            z(f, c, :) = RGB(n + 1, :);
          end
        end
      end
    end
    f
  end

  z = uint8(z);

end
