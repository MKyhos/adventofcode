#include <R.h>
#include <Rdefines.h>

/**
 * Minimum of two integers
 */
int min(int x, int y) {
  return (x < y) ? x : y;
}


/**
 * Minimum cost for path traversing a matrix
 * @param x int-pointer to 1-dim array, representing 2-dim matrix
 * @param n int row coordinate of destination, 0-indexed
 * @param m int col coordinate of destination, 0-indexed
 * @param nrow int row dimension of original matrix
 * @param ncol int col dimension of original matrix
 * @return int cost for minimal traversing path.
 */
int minimumPathC(int * x, int n, int m, int nrow, int ncol) {
  int i,j;
  int cost[nrow*ncol];
  memset( cost, 0, nrow*ncol*sizeof(int) );
  // Init first row / first column
  for (i = 1; i<n;i++)
    cost[i] = x[i] + cost[i-1];

  for (j = 1; j<m; j++)
    cost[j*ncol] = x[j*nrow] + cost[(j-1)*nrow];

  // Iterate over all other fields
  for (i = 1; i<n; i++) {
    for (j = 1; j<m; j++) {
      cost[i+j*nrow] = x[i+j*nrow] +
        min(cost[i-1+j*nrow], cost[i+(j-1)*nrow]);
    }
  }

  return cost[n-1+(m-1)*nrow];
}

/**
 * Wrapper for minimumPath for R C API
 * @param X_ Two dimensional matrix, integer
 * @param n_ integer(1) row coordinate of destination, 1-indexed
 * @param m_ integer(1) col coordinate of destination, 1-indexed
 * @return integer(1) minimal cost traversing X_
 */
SEXP minimumPath_(SEXP X_, SEXP n_, SEXP m_) {
  // Standard declarations
  int i, j;

  // Turn R input into C types, extract information
  int * x = INTEGER(X_);
  int n = asInteger(n_);
  int m = asInteger(m_);

  // Check dimensions of input matrix
  SEXP dim = PROTECT(getAttrib(X_, R_DimSymbol));
  int nrow = INTEGER(dim)[0];
  int ncol = INTEGER(dim)[1];
  UNPROTECT(1);

  return ScalarInteger(minimumPathC(x, n, m, nrow, ncol));
}
