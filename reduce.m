% Reduce una imagen

dir = 'gaza';
N = 8; % Factor de diezmado

disp('');
disp('Reduciendo imagen Sentinel-1...');
try
  vh = imread(strcat(dir, '/sar_vh.png'));
  vv = imread(strcat(dir, '/sar_vv.png'));
  [F, C] = size(vh);
  vh = vh(1:N:F, 1:N:C);
  vv = vv(1:N:F, 1:N:C);
  imwrite(vh, strcat('sar_vh.png'));
  imwrite(vv, strcat('sar_vv.png'));
  disp('OK: imagen Sentinel-1 reducida');
catch
  disp('Warning: imagen Sentinel-1 no encontrada');
end_try_catch

disp('');
disp('Reduciendo imagen Sentinel-2...');
try
  br  = imread(strcat(dir, '/msi04red.png'));
  bg  = imread(strcat(dir, '/msi03green.png'));
  bb  = imread(strcat(dir, '/msi02blue.png'));
  bn  = imread(strcat(dir, '/msi08nir.png'));
  %bs1 = imread(strcat(dir, '/msi11swir1.png'));
  %bs2 = imread(strcat(dir, '/msi12swir2.png'));
  [F, C] = size(br);
  br  = br(1:N:F, 1:N:C);
  bg  = bg(1:N:F, 1:N:C);
  bb  = bb(1:N:F, 1:N:C);
  bn  = bn(1:N:F, 1:N:C);
  %bs1 = bs1(1:N:F, 1:N:C);
  %bs2 = bs2(1:N:F, 1:N:C);
  imwrite(br, strcat('msi04red.png'));
  imwrite(bg, strcat('msi03green.png'));
  imwrite(bb, strcat('msi02blue.png'));
  imwrite(bn, strcat('msi08nir.png'));
  %imwrite(bs1, strcat('msi11swir1.png'));
  %imwrite(bs2, strcat('msi12swir2.png'));
  disp('OK: imagen Sentinel-2 reducida');
catch
  disp('Warning: imagen Sentinel-2 no encontrada');
end_try_catch

disp('');
