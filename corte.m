% Corte de colas de una banda

function z = corte(x, p)

  [F, C] = size(x);

  h = histo(x);
  N = sum(h) * p;
  m = 1;
  s = h(m);
  while s < N
    m = m + 1;
    s = s + h(m);
  end
  M = 255;
  s = h(M);
  while s < N
    M = M - 1;
    s = s + h(M);
  end
  m
  M
  z = expan(x, m, M);

end
