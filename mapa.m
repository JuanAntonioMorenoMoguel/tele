% Genera un mapa de clasificacion a color de
% una imagen clasificada de hasta 7 categorias

function z = mapa(x)

  RGB = [  0,   0, 255  ;  % AZUL
           0, 255,   0  ;  % VERDE
         255,   0,   0  ;  % ROJO
         255, 255,   0  ;  % AMARILLO
         255,   0, 255  ;  % VIOLETA
         255, 166,   0  ;  % NARANJA
           0, 255, 255 ];  % CELESTE

  [F, C] = size(x);
  x = double(x);

  z = zeros(F, C, 3);

  for f = 1:F
    for c = 1:C
      nd = double(x(f, c));
      if nd > 0
        z(f, c, :) = RGB(nd, :);
      end
    end
    f
  end

  z = uint8(z);

end
