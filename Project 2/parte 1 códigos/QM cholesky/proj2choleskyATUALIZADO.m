function x=proj2choleskyATUALIZADO
tic
format long;
h=0.05;
A=zeros(21,11);
[m,n]=size(A);
b=zeros(m,1);

for i=1:m
    for j=1:n
        A(i,j)=((i-1)*h)^(j-1);
    end
end

for i=1:m
    b(i,1)=exp(sin(6*(h*(i-1))));
end
%%%%%%%%%%%%%%%%%%%%%fatoração Cholesky%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R = chol(A' * A);
%%%%%%%%%%%%%%%%%%%%%%%%%%%AT*b%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ATb= A'*b;
%%%%%%%%%%%%%%%%%%%%%% RTw = ATb para w %%%%%%%%%%%%%%%%%%%%%%%%%%%
w=R'\ATb;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Rx = w %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rp=R\w;
toc

%%%%%%%%%%%%%%%%%%%%%%%%%%||Ax - b ||2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
residuo = norm((A*rp - b),2)

hold off
syms x
fplot(rp(1,1)+rp(2,1)*x + rp(3,1)*x^2+rp(4,1)*x^3+rp(5,1)*x^4+rp(6,1)*x^5+rp(7,1)*x^6+rp(8,1)*x^7+rp(9,1)*x^8+rp(10,1)*x^9+rp(11,1)*x^10,[0,1]);

hold on 
t=0:0.05:1;
scatter(t,exp(sin(6*t)),20,[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);


hold off
fplot((rp(1,1)+rp(2,1)*x + rp(3,1)*x^2+rp(4,1)*x^3+rp(5,1)*x^4+rp(6,1)*x^5+rp(7,1)*x^6+rp(8,1)*x^7+rp(9,1)*x^8+rp(10,1)*x^9+rp(11,1)*x^10) - exp(sin(6*x)),[0,1]);

rb=rp;
%calculando a norma
for i=1:11
    rp(i)=rb(11-i+1);
end
norm(polyval(rp, t)-exp(sin(6*t)))
hold off
t=0:0.05:1;
%scatter(t,(polyval(rp, t)-exp(sin(6*t))),20,[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5)
plot(t,(polyval(rp, t)-exp(sin(6*t))))
hold on 
t=0:0.01:1;
scatter(t,(polyval(rp, t)-exp(sin(6*t))),20,[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5)
legend("Avaliando 21 pontos", "Avaliando 101 pontos");
title("Erro: Fatoracao QR por transformacoes de householder", "fontsize", 20)
title("Erro: Equações normais via fatoração de Cholesky", "fontsize", 10)
end