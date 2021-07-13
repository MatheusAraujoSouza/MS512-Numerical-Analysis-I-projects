clear
residuos = zeros(12, 19);
for mes = 1:12
  filepath = strcat('/espaco_tempo/mes_', num2str(mes),'.csv');
  infile = strcat('dados', filepath);
  outfile = strcat('resultados', filepath);
  file = csvread(infile);
  b = file(:,2);
  max_i = length(b)-1;
  t = 0:length(b)-1;
  for i = 1:max_i
    A = vander(t, i + 1);
    c = QRGS(A, b);
    residuos(mes,i) = norm(polyval(c, t)'-b);
  end
  [minval, minindex] = min(residuos(mes,:));
  A = vander(t, minindex + 1);
  c = QRGS(A, b);
  t = 0:length(b)-1;
  result = zeros(length(b),2);
  result(:,1) = t;
  result(:,2) = polyval(c, t)';
  csvwrite(strcat('resultados/espaco_freq/mes_', num2str(mes),'_coef.csv'), c);
  csvwrite(outfile, result)
end

