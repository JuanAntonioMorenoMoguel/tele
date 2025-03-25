% Realiza una composicion a color

function z = combina(r, g, b)

  z = r;
  z(:, :, 2) = g;
  z(:, :, 3) = b;

end
