% Segmentacion de una banda
% (Version vectorizada)

function z = segmenta_v(x)

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

  b = x > 0;
  [F, C] = size(x);
  x = double(x);

  z = ones(F, C, 3) .* RGB(1);
  for n = 1:7
    v = (x > UMBRAL(n)) & (x <= UMBRAL(n + 1));
    w          = v * RGB(n + 1, 1);
    w(:, :, 2) = v * RGB(n + 1, 2);
    w(:, :, 3) = v * RGB(n + 1, 3);
    z = z + w;
  end
  z = z .* b;

  z = uint8(z);

end
