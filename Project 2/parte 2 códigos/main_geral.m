clear
max_i = 19;
residuos = zeros(1, max_i);
filepath = strcat('/espaco_tempo/dados_gerais.csv');
infile = strcat('dados', filepath);
outfile = strcat('resultados', filepath);
file = csvread(infile);
b = file(:,2);
t = 0:length(b)-1;
for i = 1:max_i
  A = vander(t, i + 1);
  c = QRGS(A, b);
  residuos(i) = norm(polyval(c, t)'-b);
  norm(polyval(c, t)'-b)
end
[minval, minindex] = min(residuos);
A = vander(t, minindex + 1);
c = QRGS(A, b);
t = 0:length(b)-1;
result = zeros(length(b),2);
result(:,1) = t;
result(:,2) = polyval(c, t)';
csvwrite('resultados/espaco_tempo/dados_gerais_coef.csv', c);
csvwrite(outfile, result);

%plot(t, b) #PLOTANDO A FUNCAO ORIGINAL
%hold on
%plot(t, polyval(c, t)) #PLOTANDO DA FUNCAO AJUSTADA
%hold on
%title("Fatoracao QR + Gran-Schmidt modificado", "fontsize", 20)
%legend("Funcao Real", "Aproximacao");

