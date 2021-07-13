clear
starttime = time();
for count = 1:100
  % Define os dados iniciais
  set_problem 
  % Calcula a melhor solucao de Ax = b 
  % usando transformacoes de householder
  rp = qrhh(A, b); 
end
endtime = (time() - starttime) / 100

x = linspace(0, 1, 21);
output_precision(16)

norma_hh = norm(polyval(rp, x)-exp(sin(6*x)))
str_residuo = strcat("Norma do Residuo:  ", num2str((norma_hh)));
t = linspace(0,1,101);
figure(1, 'position',[250,120,1000,500]);


rodar_plot = 1;
if rodar_plot == 1
  plot(t, exp(sin(6*t))) #PLOTANDO A FUN��O ORIGINAL
  hold on
  scatter(x, polyval(rp, x))
  hold on
  
  title("Fatoracao QR por transformacoes de householder", "fontsize", 20)
  #text (0.45, 2.75,str_residuo, "fontsize", 20);
  
  h= legend("Funcao Real", "Aproximacao");
  legend(h);
  set(h, "fontsize", 20);
endif
#-------------------PLOTANDO A DIFEREN�A

rodar_plot = 0;
if rodar_plot == 1
  plot(x, polyval(rp, x)-exp(sin(6*x)));
  hold on
  scatter(t, polyval(rp, t)-exp(sin(6*t)));
  title("Erro: Fatoracao QR por transformacoes de householder", "fontsize", 20)
  #text (0.57, 0.013,str_residuo, "fontsize", 20);
  
  h= legend("Avaliando 21 pontos", "Avaliando 101 pontos");
  legend(h);
  set(h, "fontsize", 20);  
endif

#-------------------A\b A DIFEREN�A
c_oct = A\b;


norma_oct = norm(polyval(c_oct, t)-exp(sin(6*t)))