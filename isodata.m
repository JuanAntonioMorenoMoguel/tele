% Clasifica una imagen mediante ISODATA

function z = isodata_v(x)

  N      = 5  ; % Numero de categorias
  MAX    = 10 ; % Maximo de iteraciones
  RANDOM = 0  ; % Asignacion aleatoria de centroides (0/1)

  x = double(x);
  [F, C, B] = size(x);

  % Posicion inicial de centroides:

  if (RANDOM == 1) % Asignacion aleatoria
    display('Posicion inicial de centroides: Asignacion aleatoria');
    v = [];
    nd = zeros(1, B);
    for n = 1:N
      q = 0;
      while q == 0
        f = round(rand * F);
        c = round(rand * C);
        for b = 1:B
          nd(b) = x(f, c, b);
        end
        if min(nd) > 0
          q = 1;
        end
      end
      v = [v ; nd];
    end
  else % Asignacion centrada
    display('Posicion inicial de centroides: Asignacion centrada');
    v = [];
    for n = 1:N    
      for b = 1:B
        m = mean([min(min(x(:, :, b))), max(max(x(:, :, b)))]);
        a = min([m, 255 - m]);
        nd(1, b) = m - a / 2 + (n - 1) * a / N;
      end
      v = [v ; nd];
    end
  end

  display('Centroides iniciales:');
  v

  z = ones(F, C);

  % Clasificacion:

  Iteracion = 0;
  q = 1;
  while q == 1 && Iteracion < MAX
    Iteracion = Iteracion + 1
    q = 0;
    for f = 1:F
      for c = 1:C
        for b = 1:B
          nd(b) = x(f, c, b);
        end
        if min(nd) > 0
          v0 = z(f, c);
          d0 = sqrt(sum((nd - v(v0, :)) .^ 2));
          for n = 1:N
            d = sqrt(sum((nd - v(n, :)) .^ 2));
            if d < d0 && n ~= v0
              z(f, c) = n;
              q = 1;
            end
          end
        else
          z(f, c) = 0;
        end
      end
    end

    pintanubepuntos(Iteracion, x, v);

    if q == 1 % Si se ha reclasificado agun pixel reposicionar centroides:
      disp('Reposicionando centroides...');
      for n = 1:N
        s = zeros(1, B);
        T = 0;
        for f = 1:F
          for c = 1:C
            v0 = z(f, c);
            if v0 == n
              for b = 1:B
                nd(b) = x(f, c, b);
              end
              s = s + nd;
              T = T + 1;
            end
          end
        end
        if T > 0
          s = s ./ T;
          v(n, :) = s; % Centroide reposicionado
        end
      end
      v
    end
  end
  
  z = uint8(z);

end

function pintanubepuntos(Iteracion, x, v);
  [F, C, B] = size(x);
  x = reshape(x, F*C, 1, B);
  plot(x(:, 1, 1), x(:, 1, 2), '.y');
  grid on;
  hold on;
  plot(v(:, 1), v(:, 2), '.b', 'markersize', 20);
  title(strcat('Iteracion=', num2str(Iteracion)));
  hold off;
  pause(0.01);
end
