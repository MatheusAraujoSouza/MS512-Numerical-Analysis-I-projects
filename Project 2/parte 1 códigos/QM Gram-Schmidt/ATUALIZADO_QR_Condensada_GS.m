clear all

#---------------for iteracao = 1:10
x = linspace(0, 1, 21);
b = exp(sin(6*x))';

M = 21
N = 11

A =zeros(M,N);
for j = 1:N
  A(:,j) = x.^(j-1);
endfor

Q = zeros(M,M);
R = zeros(M,N);
V = zeros(M,N);

#ALGORITMO DE GS MODIFICADO
for j = 1:N
  V(:,j) = A(:,j);
endfor

for j = 1:N
  for i = 1:(j-1)
    R(i,j) = (Q(:,i))'*V(:,j);
    V(:,j) = V(:,j) - R(i,j)*Q(:,i);
  endfor
  
  R(j,j) = norm(V(:,j));
  
  if R(j,j) == 0
    print("Estamos num caso LD")
  else
    Q(:,j) = (1/R(j,j))*V(:,j);
  endif
endfor

R_Chapeu = R(1:N,1:N);
Q_1 = Q(:,1:N);

c = R_Chapeu\(Q_1' * b);

#---------------endfor

#Aparentemente os coeficientes tão invertidos (?)
for i = 1:11
  C(i) = c(12-i);
endfor

output_precision(16)

norma_gs = norm(polyval(C, x)-exp(sin(6*x)))
str_residuo = strcat("Norma do Resíduo:  ", num2str((norma_gs)))
t = linspace(0,1,101);
figure(1, 'position',[250,120,1000,500]);



#-------------------COMPARANDO O ORIGINAL E O AJUSTADO

rodar_plot = 1
if rodar_plot == 1
  plot(t, exp(sin(6*t))) #PLOTANDO A FUNÇÃO ORIGINAL
  hold on
  scatter(x, polyval(C, x)) #SCATTER DA FUNÇÃO AJUSTADA
  hold on
  
  title("Fatoração QR + Gran-Schimidt modificado", "fontsize", 20)
  #text (0.45, 2.75,str_residuo, "fontsize", 20);
  
  h= legend("Função Real", "Aproximação")
  legend(h);
  set(h, "fontsize", 20);
endif
#-------------------PLOTANDO A DIFERENÇA

rodar_plot = 0
if rodar_plot == 1
  plot(x, polyval(C, x)-exp(sin(6*x)));
  hold on
  scatter(t, polyval(C, t)-exp(sin(6*t)));
  title("Erro: Fatoração QR + Gran-Schimidt modificado", "fontsize", 20)
  #text (0.57, 0.013,str_residuo, "fontsize", 20);
  
  h= legend("Avaliando 21 pontos", "Avaliando 101 pontos")
  legend(h);
  set(h, "fontsize", 20);  
endif

#-------------------A\b A DIFERENÇA
c_oct = A\b;
for i = 1:11
  C_oct(i) = c_oct(12-i);
endfor

norma_oct = norm(polyval(C_oct, t)-exp(sin(6*t)))