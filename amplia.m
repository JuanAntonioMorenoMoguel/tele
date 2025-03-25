% Amplia una banda

function z = amplia(x)

  [F, C] = size(x);
  x = double(x);

  z = zeros(2*F, 2*C);

  for f = 1:F
    for c = 1:C
      z(2*f-1, 2*c-1) = x(f, c);
    end
    f
  end

  for f = 2:2:2*F-1
    z(f, :) = (z(f-1, :) + z(f+1, :)) / 2;
  end

  for c = 2:2:2*C-1
    z(:, c) = (z(:, c-1) + z(:, c+1)) / 2;
  end

  z = uint8(z);

end
