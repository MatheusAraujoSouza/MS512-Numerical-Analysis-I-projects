# Numerical-Analysis-I-projects
This course aimed at teaching methods such as Choleski factorization, orthogonal, linear least squares, SVD and Iterative methods for solving linear and non-linear systems.  


Credits to:

Daniel Yan

Matheus Souza

Daysa Silva

Fábio Paiva


## Projetc I

The objective of this project is to visualize the behavior of sparse matrices, which have a large amount of null inputs, effectively. To do this, we look at a way to store arrays in memory in a way that reduces the space used by the program, called envelopes.

example of storing the envelope in a triangular matrix:
<p align="center">
<img src="https://github.com/MatheusAraujoSouza/MS512-Numerical-Analysis-I-projects/blob/main/captura1.png" width="700" height="200"/> 

Once the method is understood, we sought with this project to answer the following questions:

1)Write an algorithm to solve the linear system Ux = b, U ∈ IR ^ (n × n), b ∈ IRn by reverse substitution assuming the matrix U is upper triangular and stored according to the column envelope structure.

2)For matrix A, specify the column-oriented envelope for its upper triangular portion and the row-oriented envelope for its lower triangular portion, making, in this second case, the necessary adaptations in the definition and in the index vectors corresponding to the rows and columns.

Exemple of matrix A(7 x 7): 
<p align="center">
<img src="https://github.com/MatheusAraujoSouza/MS512-Numerical-Analysis-I-projects/blob/main/matriA2.png" width="300" height="200"/> 


3)Assuming that the LU factorization of A ∈ IRn × n is well defined, show that the envelope of L (by rows) is equal to the envelope of the lower triangular part of A, and that the envelope of U (by columns) coincides with the envelope from the upper triangular portion of A.

4)Expand the scope of the previous item, assuming now partial pivoting, so that PA = LU, where P ∈ IRn × n permutation matrix. Assuming the matrix P is known, show that the result of the previous item applies to the envelopes of L and U, with respect to the envelopes of the lower and upper triangular portions of PA, respectively.

5)To solve the system Ax = b, assume that the permutation matrix P is known a priori, so you will work with P Ax = Pb. Adapt the Gauss elimination algorithm studied in Numerical Calculus to construct the factors L and U such that PA = LU, working with the envelopes of the lower (by rows) and upper (by columns) triangular portions of P A. The triangular matrices L and U must be stored in envelopes, oriented by rows and columns, respectively.

6)The following figure shows a flat structure, called a truss, with 13 bars (numbered as indicated), connected by 8 nodes (numbered with circles). There are loads (in tons) applied to nodes 2, 5 and 6, and the objective is to determine the forces acting on each of the truss bars.

<p align="center">
<img src="https://github.com/MatheusAraujoSouza/MS512-Numerical-Analysis-I-projects/blob/main/estrutura.png"/> 

following strength settings:
  
<p align="center">
<img src="https://github.com/MatheusAraujoSouza/MS512-Numerical-Analysis-I-projects/blob/main/forces%20.png"/> 

The results for the proposed problems can be found in:
  
https://github.com/MatheusAraujoSouza/MS512-Numerical-Analysis-I-projects/blob/main/Project%201/Relatório_Projeto_1.pdf
  
## Project II 
