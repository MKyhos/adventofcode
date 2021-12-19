#include <R.h>
#include <Rdefines.h>

int min(int x, int y) {
  return (x < y) ? x : y;
}

int minimumPathC(int * x, int n, int m, int nrow, int ncol) {
  int i,j;
  int cost[nrow*ncol];
  int res;
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

  res = cost[n-1+(m-1)*nrow];
  return res;
}



SEXP minimumPath_(SEXP X_, SEXP n_, SEXP m_) {

  // Standard declarations
  int i, j;
  int res;

  // Turn R input into C types, extract information
  int * x = INTEGER(X_);
  int n = asInteger(n_);
  int m = asInteger(m_);

  // Check dimensions of input matrix
  SEXP dim = PROTECT(getAttrib(X_, R_DimSymbol));
  int nrow = INTEGER(dim)[0];
  int ncol = INTEGER(dim)[1];
  UNPROTECT(1);

  res =  minimumPathC(x, n, m, nrow, ncol);
  return ScalarInteger(res);
}
