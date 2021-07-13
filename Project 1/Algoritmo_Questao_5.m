clear all

#GRUPO:
#
# Daniel Yan - 214793
# Matheus Araujo Souza - 184145
# Daysa De Campos Da Silva - 233469
# Fabio Henrique Polidoro Paiva - 215570

#------------------------ Definindo as matrizes

r = sqrt(2)/2;

A=[ 0 1 0 0  0  -1 0 0  0  0  0  0  0;
    0 0 1 0  0  0  0 0  0  0  0  0  0;
    r 0 0 -1 -r 0  0 0  0  0  0  0  0;
    r 0 1 0  r  0  0 0  0  0  0  0  0;
    0 0 0 1  0  0  0 -1 0  0  0  0  0;
    0 0 0 0  0  0  1 0  0  0  0  0  0;
    0 0 0 0  r  1  0 0  -r -1 0  0  0;
    0 0 0 0  r  0  1 0  r  0  0  0  0;
    0 0 0 0  0  0  0 0  0  1  0  0  -1;
    0 0 0 0  0  0  0 0  0  0  1  0  0;
    0 0 0 0  0  0  0 1  r  0  0  -r 0;
    0 0 0 0  0  0  0 0  r  0  1  r  0;
    0 0 0 0  0  0  0 0  0  0  0  -r 1];
    

P = [ 0 0 1 0 0 0 0 0 0 0 0 0 0;
      1 0 0 0 0 0 0 0 0 0 0 0 0;
      0 1 0 0 0 0 0 0 0 0 0 0 0;
      0 0 0 1 0 0 0 0 0 0 0 0 0;
      0 0 0 0 1 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 1 0 0 0 0 0 0;
      0 0 0 0 0 1 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 0 1 0 0;
      0 0 0 0 0 0 0 1 0 0 0 0 0;
      0 0 0 0 0 0 0 0 1 0 0 0 0;
      0 0 0 0 0 0 0 0 0 1 0 0 0;
      0 0 0 0 0 0 0 0 0 0 0 1 0;
      0 0 0 0 0 0 0 0 0 0 0 0 1];

c= [0;10;0;0;0;0;0;15;0;20;0;0;0]; 
b=P*c;

      
DIAG = [r 1 1 0 0 1 1 1 r 1 1 r 1];
ENV_sup = [-1 0 0 -r 0 0 r -1 0 0 0 -1 0 0 -r 0 r -1 0 0 0 -r 0 0 0 -1 0 0 0];
ENVcol_sup = [1 1 1 1 4 8 12 12 15 18 22 22 26 29];
ENVlin_sup = [1 2 3 1 2 3 4 2 3 4 5 5 6 7 6 7 8 6 7 8 9 8 9 10 11 10 11 12];

ENV_inf =    [r 0 1 1 r r 0 1 0 r 0 1 -r 0];
ENVlin_inf = [1 1 1 1 4 5 6 6 6 10 10 10 13 14];
ENVcol_inf = [1 2 3 4 5 5 6 7 8 9 10 11 12];
    
#------------------------------------------------------------------

function [top, indices] = acha_indices(value, array, n)
    indices = zeros(1,n);
    top = 1;
    for i = 1:length(array)
        if array(i) == value
            indices(top) = i;
            top=top+1;
        end
    end
end

#------------------------------------------------------------------

function pos = onde_esta(i,ini, ENVpos, n)
    pos = 0;
    for j = ini:n
        if (ENVpos(j)) <= i && ENVpos(j+1) > i
            pos = j;
            break
        end
    end
end

#---------------------- Fatoração LU

n = max(size(DIAG));

for k = 1:n-1
    % aux junta os indices dos elementos que estao no envelope na linha k
    [size_u, aux_u] = acha_indices(k, ENVlin_sup, n);
    [size_l, aux_l] = acha_indices(k, ENVcol_inf, n);
    for i = 1:size_l-1
        ENV_inf(aux_l(i)) = ENV_inf(aux_l(i))/DIAG(k);
        lin = onde_esta(aux_l(i), 1, ENVlin_inf, n);
        for j = 1:size_u-1
            col = onde_esta(aux_u(j), 1, ENVcol_sup, n);
            sub = ENV_inf(aux_l(i))*ENV_sup(aux_u(j));
            
            if lin > col
                % procura a coluna no ENVcol_inf
                [top, aux] = acha_indices(col, ENVcol_inf, n);
                for x = 1:top-1
                    if (onde_esta(aux(x), 1, ENVlin_inf, n) == lin)
                        ENV_inf(aux(x)) = ENV_inf(aux(x)) - sub;
                    end
                end
            elseif lin < col
                % procura a coluna no ENVlin_sup
                [top, aux] = acha_indices(lin, ENVlin_sup, n);
                for x = 1:top-1
                    if (onde_esta(aux(x), 1, ENVcol_sup, n) == col)
                        ENV_sup(aux(x)) = ENV_sup(aux(x)) - sub;
                    end
                end
            else
                DIAG(lin) = DIAG(lin)- sub;
            end
            
        end
    end
end



#---------------------- Resolver o sistema para Ly = b
for i = 1:n
    for j = ENVlin_inf(i):ENVlin_inf(i+1)-1
        b(i) = b(i) - b(ENVcol_inf(j)) *ENV_inf(j);
    end
end

#---------------------- Resolver o sistema Ux = y
for j = n:-1:1
	b(j) = b(j)/DIAG(j);
	for i = ENVcol_sup(j+1)-1:-1:ENVcol_sup(j)
		b(ENVlin_sup(i)) = b(ENVlin_sup(i)) - b(j) *ENV_sup(i);
	end
end

f_envelope = b;

#---------------------- COMPARANDO OS RESULTADOS

f_octave = (P*A)\(P*c);
