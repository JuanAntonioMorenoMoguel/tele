% Genera un mapa de clasificacion a color de
% una imagen clasificada de hasta 7 categorias

function z = mapa_v(x)

  RGB = [  0,   0, 255  ;  % AZUL
           0, 255,   0  ;  % VERDE
         255,   0,   0  ;  % ROJO
         255, 255,   0  ;  % AMARILLO
         255,   0, 255  ;  % VIOLETA
         255, 166,   0  ;  % NARANJA
           0, 255, 255 ];  % CELESTE

  [F, C] = size(x);

  z = zeros(F, C, 3);

  b = x > 0;
  for n = 1:7
    v = x == n;
    w          = v * RGB(n, 1);
    w(:, :, 2) = v * RGB(n, 2);
    w(:, :, 3) = v * RGB(n, 3);
    z = z + w;
  end
  z = z .* b;

  z = uint8(z);

end
