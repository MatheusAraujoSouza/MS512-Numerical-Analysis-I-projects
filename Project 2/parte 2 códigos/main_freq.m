clear
max_i = 19;
residuos_real = zeros(12, max_i);
residuos_imag = zeros(12, max_i);
for mes = 1:12
  filepath = strcat('/espaco_freq/mes_', num2str(mes),'.csv');
  infile = strcat('dados', filepath);
  outfile = strcat('resultados', filepath);
  file = csvread(infile);
  t = file(:,2);
  b_real = file(:,3);
  b_imag = file(:,4);
  
  % AJUSTE PARTE REAL
  for i = 1:max_i
    A = vander(t, i + 1);
    c = QRGS(A, b_real);
    residuos_real(mes, i) = norm(polyval(c, t)-b_real);
  end
  [minval_real, minindex_real] = min(residuos_real(mes,:));

  A = vander(t, minindex_real + 1);
  c = QRGS(A, b_real);
  file(:,3) = polyval(c, t);
  csvwrite(strcat('resultados/espaco_freq/mes_', num2str(mes),'_real_coef.csv'), c);
  
  %AJUSTE PARTE IMAGINARIA
  for i = 1:max_i
    A = vander(t, i + 1);
    c = QRGS(A, b_imag);
    residuos_imag(mes, i) = norm(polyval(c, t)-b_imag);
  end
  [minval_imag, minindex_imag] = min(residuos_imag(mes,:));

  A = vander(t, minindex_imag + 1);
  c = QRGS(A, b_imag);
  file(:,4) = polyval(c, t);
  csvwrite(strcat('resultados/espaco_freq/mes_', num2str(mes),'_imag_coef.csv'), c);
  csvwrite(outfile, file)
end