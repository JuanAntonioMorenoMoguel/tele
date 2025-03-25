% Histograma de una banda

function h = histo(x)

  [F, C] = size(x);

  h = zeros(1, 255);

  for f = 1:F
    for c = 1:C
      nd = x(f, c);
      if nd > 0
        h(nd) = h(nd) + 1;
      end
    end
    f
  end

end
