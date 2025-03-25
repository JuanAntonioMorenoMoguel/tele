% Histograma de una banda
% (Version vectorizada)

function h = histo_v(x)

  h = histc(reshape(x, 1, []), 1:255);

end
