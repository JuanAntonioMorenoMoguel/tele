% Corte de colas de una banda
% (Version vectorizada)

function z = corte_v(x, p)

  s = cumsum(histo_v(x));
  [N, m, M] = [s(255), min(find(s >= p * N)), max(find(s <= (1 - p) * N))]
  z = expan_v(x, m, M);

end
