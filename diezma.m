% Diezma una banda

function z = diezma(x)

  [F, C] = size(x);
  x = double(x);

  z = x(1:2:F, 1:2:C);

  z = uint8(z);

end
