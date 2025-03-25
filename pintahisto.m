% Pinta un histograma

function pintahisto(h)

  bar(1:255, h);
  grid on;
  axis([1 255 0 inf]);
  title('Histograma');
  xlabel('ND');
  ylabel('h');

end
