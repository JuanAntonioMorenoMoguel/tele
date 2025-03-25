% Expansion lineal de una banda
% (Version vectorizada)

function z = expan_v(x, m, M)

  b = x > 0;
  x = double(x);
  z = max(1, ((x - m) * 254) / (M - m) + 1);
  z = z .* b;
  z = uint8(z);

end
