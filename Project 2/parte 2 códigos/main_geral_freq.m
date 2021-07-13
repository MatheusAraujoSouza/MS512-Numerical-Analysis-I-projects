clear
max_i = 19;
residuos_real = zeros(1, max_i);
residuos_imag = zeros(1, max_i);
filepath = strcat('/espaco_freq/dados_gerais.csv');
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
  residuos_real(i) = norm(polyval(c, t)-b_real);
end
[minval_real, minindex_real] = min(residuos_real);

A = vander(t, minindex_real + 1);
c = QRGS(A, b_real);
file(:,3) = polyval(c, t);
csvwrite(strcat('resultados/espaco_freq/dados_gerais_real_coef.csv'), c);

%AJUSTE PARTE IMAGINARIA
for i = 1:max_i
  A = vander(t, i + 1);
  c = QRGS(A, b_imag);
  residuos_imag(i) = norm(polyval(c, t)-b_imag);
end
[minval_imag, minindex_imag] = min(residuos_imag);

A = vander(t, minindex_imag + 1);
c = QRGS(A, b_imag);
file(:,4) = polyval(c, t);
csvwrite(strcat('resultados/espaco_freq/dados_gerais_imag_coef.csv'), c);
csvwrite(outfile, file)

