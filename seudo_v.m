% Seudocolor de una banda
% (Version vectorizada)

function z = seudo_v(x)

  UMBRAL = 128;

  b = x > 0;
  F = size(x, 1);
  C = size(x, 2);
  z = zeros(F, C);
  z(:, :, 2) = (x >= UMBRAL) * 255;
  z(:, :, 3) = (x <  UMBRAL) * 255;
  z = z .* b;
  z = uint8(z);

end
