% Filtro de mediana de una banda
% (Version vectorizada)

function z = fmediana_v(x)

  x = double(x);
  [F, C, B] = size(x);

  z = zeros(F, C);

  y(1, :) = reshape(x(1:F-2, 1:C-2), 1, (F-2)*(C-2));
  y(2, :) = reshape(x(1:F-2, 2:C-1), 1, (F-2)*(C-2));
  y(3, :) = reshape(x(1:F-2, 3:C  ), 1, (F-2)*(C-2));
  y(4, :) = reshape(x(2:F-1, 1:C-2), 1, (F-2)*(C-2));
  y(5, :) = reshape(x(2:F-1, 2:C-1), 1, (F-2)*(C-2));
  y(6, :) = reshape(x(2:F-1, 3:C  ), 1, (F-2)*(C-2));
  y(7, :) = reshape(x(3:F,   1:C-2), 1, (F-2)*(C-2));
  y(8, :) = reshape(x(3:F,   2:C-1), 1, (F-2)*(C-2));
  y(9, :) = reshape(x(3:F,   3:C  ), 1, (F-2)*(C-2));
  z(2:F-1, 2:C-1) = reshape(median(y), F-2, C-2);

  z = uint8(z);

end
