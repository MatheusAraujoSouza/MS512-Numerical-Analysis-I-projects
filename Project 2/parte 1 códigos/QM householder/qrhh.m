function rp = qrhh(A, b)
  [m, n] = size(A);
  for k = 1:n
    norm_ak = norm(A(k:m, k));
    sig = sign(A(k, k));
    if (sig == 0) sig = 1; end
    tau = sig*norm_ak;
    u = ones(m-k+1, 1);
    u(2:end) = A(k+1:m, k)./(tau + A(k, k));
    for j = k+1:n
      aux = A(k,j) + A(k+1:m, j)'*u(2:end);
      aux = aux * (1 + A(k, k)/tau);
      A(k, j) = A(k, j) - aux;
      A(k+1:m, j) = A(k+1:m, j) - aux*u(2:end);
    endfor
    A(k,k) = -tau;
    A(k+1:m,k) = u(2:end);
  end
  % R eh a parte triangular superior de A
  R = triu(A);
  
  % Calculo de Q'*b
  for k = 1:n
    u = ones(m-k+1, 1);
    u(2:end) = A(k+1:m, k);
    b(k:m) = b(k:m) - 2/(u'*u)*(u'*b(k:m))*u;
  end
  rp=R\b;
end