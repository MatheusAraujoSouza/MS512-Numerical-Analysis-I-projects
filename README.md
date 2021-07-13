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
<img src="https://github.com/MatheusAraujoSouza/MS512-Numerical-Analysis-I-projects/blob/main/captura1.png" width="1600" height="250"/> 

Once the method is understood, we sought with this project to answer the following questions:

1)Write an algorithm to solve the linear system Ux = b, U ∈ IR ^ (n × n), b ∈ IRn by reverse substitution assuming the matrix U is upper triangular and stored according to the column envelope structure.

2)For matrix A, specify the column-oriented envelope for its upper triangular portion and the row-oriented envelope for its lower triangular portion, making, in this second case, the necessary adaptations in the definition and in the index vectors corresponding to the rows and columns.

Exemple of matrix A(7 x 7): 

<img src="https://github.com/MatheusAraujoSouza/MS512-Numerical-Analysis-I-projects/blob/main/matrixA.png" width="600" height="250"/> 

## Project II 
