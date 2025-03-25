% Clasifica una imagen mediante metodo supervisado

function z = supervis(x)

  x = double(x);
  [F, C, B] = size(x);

  % Campos de entrenamiento:

  %%% Coordenadas:

  k1a = [118,  70, 170, 110];
  k1b = [113, 153, 152, 179];
  k2a = [ 51, 130,  91, 174];
  k2b = [230,  25, 283,  83];

  %%% Dimensiones:

  L1a = tamano(k1a);
  L1b = tamano(k1b);
  L2a = tamano(k2a);
  L2b = tamano(k2b);

  %%% Dibujo:

  y = cortehsv(uint8(x(:, :, 1:3)), 0.01);
  y = rectangulo(y, 2, k1a);
  y = rectangulo(y, 2, k1b);
  y = rectangulo(y, 3, k2a);
  y = rectangulo(y, 3, k2b);
  figure(1);
  imshow(y);
  imwrite(y, 'fields.png');

  %%% Calculo de centroides:

  k1 = [reshape(x(k1a(2):k1a(4), k1a(1):k1a(3), :), 1, L1a, B), reshape(x(k1b(2):k1b(4), k1b(1):k1b(3), :), 1, L1b, B)];
  k2 = [reshape(x(k2a(2):k2a(4), k2a(1):k2a(3), :), 1, L2a, B), reshape(x(k2b(2):k2b(4), k2b(1):k2b(3), :), 1, L2b, B)];
  for b = 1:B
    v1(1, 1, b) = sum(k1(:, :, b)) ./ (L1a + L1b);
    v2(1, 1, b) = sum(k2(:, :, b)) ./ (L2a + L2b);
  end
  v1
  v2

  % Clasificacion:

  z = zeros(F, C);
  for f = 1:F
    for c = 1:C
      px = x(f, c, :);
      if prod(px) > 0
        d1 = sqrt(sum(px - v1) .^ 2);
        d2 = sqrt(sum(px - v2) .^ 2);
        if d1 < d2
          z(f, c) = 1;
        else
          z(f, c) = 2;
        end
      end
    end
    f
  end

  z = uint8(z);

end

function z = rectangulo(x, b, k)
  x = double(x);
  d = 0;
  x(k(2)-d:k(4)+d, k(1)-d:k(1)+d, b) = 255;
  x(k(2)-d:k(4)+d, k(3)-d:k(3)+d, b) = 255;
  x(k(2)-d:k(2)+d, k(1)-d:k(3)+d, b) = 255;
  x(k(4)-d:k(4)+d, k(1)-d:k(3)+d, b) = 255;
  z = uint8(x);
end

function z = tamano(x)
  z = (x(3) - x(1) + 1) * (x(4) - x(2) + 1);
end

