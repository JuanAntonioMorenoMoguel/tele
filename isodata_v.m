% Clasifica una imagen mediante ISODATA
% (Version vectorizada)

function z = isodata_v(x)

  N      = 5    ; % Numero de categorias
  MAX    = 1000 ; % Maximo de iteraciones
  RANDOM = 0    ; % Asignacion aleatoria de centroides (0/1)

  [F, C, B] = size(x);

  % Mascara de pixeles validos:

  vnd = true(F, C);
  for m = 1:B
    vnd = vnd & (x(:, :, m) > 0);
  end

  % Conversion de imagen a celdas:

  x = num2cell(double(x), [1 2]);
  
  % Posicion inicial de centroides:

  if (RANDOM == 1) % Asignacion aleatoria
    display('Posicion inicial de centroides: Asignacion aleatoria');
    v = cell(N, 1);
    for n = 1:N
      b = 0;
      while b == 0
        f = round(rand * (F - 1) + 1);
        c = round(rand * (C - 1) + 1);
        for m = 1:B
          w(m) = x{m}(f, c);
        end
        b = all(w);
      end
      v(n) = w;
    end
  else % Asignacion centrada
    display('Posicion inicial de centroides: Asignacion centrada');
    v = cell(N, 1);
    for n = 1:N    
      for b = 1:B
        m = mean([min(min(x{b}(:, :))), max(max(x{b}(:, :)))]);
        a = min([m, 255 - m]);
        w(1, b) = m - a / 2 + (n - 1) * a / N;
      end
      v(n) = w;
    end
  end

  display('Centroides iniciales:');
  celldisp(v)

  % Clasificacion:

  z = zeros(F, C);
  dmin = ones(F, C) * sqrt(255^2 * N);
  d = cell(1, N);
  Iteracion = 0;
  b = 1;
  while b == 1 && Iteracion < MAX
    display('Clasificando...');
    Iteracion = Iteracion + 1
    b = 0;
    for n = 1:N
      d{n} = zeros(F, C);
      for m = 1:B
        d{n} = d{n} + (x{m} - v{n}(m)) .^ 2;
      end
      d{n} = sqrt(d{n});
      t = (d{n} < dmin) & vnd;
      b = any(any(t));
      z(t) = n;
      dmin = min(dmin, d{n});
    end
    pintanubepuntos(Iteracion, x, v, F, C, N);
    if b == 1 % Si se ha reclasificado algun pixel reposicionar centroides:
      display('Reposicionando centroides...');
      for n = 1:N
        for m = 1:B
          v{n}(m) = mean(mean(x{m}(z == n)));
        endfor
      endfor
      display('Centroides actuales:');
      celldisp(v)
    endif
  endwhile
  display('Total iteraciones:');
  Iteracion
  display('Centroides finales:');
  celldisp(v)

  z = uint8(z);

end

function pintanubepuntos(Iteracion, x, v, F, C, N);
  px = reshape(x{1}(:, :), F*C, 1);
  py = reshape(x{2}(:, :), F*C, 1);
  plot(px, py, '.y');
  grid on;
  hold on;
  for n = 1:N
    plot(v{n}(1), v{n}(2), '.b', 'markersize', 20);
  end
  title(strcat('Iteracion=', num2str(Iteracion)));
  hold off;
  pause(0.5);
end
