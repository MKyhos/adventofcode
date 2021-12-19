
dim <- 100
input <- matrix(
  scan(
    pipe("awk '{gsub(\"\", \" \", $1); print $1;}' input.txt"),
    what = integer()
  ),
  nrow = dim,
  byrow = TRUE
)



# Dynamic programming approach:
# Breaking down the problem in small steps, safe intermediate results
# in appropriate auxiliary data structure (here: just another matrix of the
# same dimension as the input, the "cost").
minimumPath <- function(mat, n ,m, incr = 0) {
  st <- matrix(0 , nrow = n, ncol = m)
  for (i in 2:n)
    st[i, 1] <- st[i - 1, 1] + mat[i, 1]

  for (j in 2:m)
    st[1, j] <- st[1, j - 1] + mat[1, j]

  for (i in 2:n) {
    for (j in 2:m)
      st[i, j] <- mat[i, j] + min(st[i, j - 1], st[i - 1, j])
  }
  return(st[n, m])
}

# C Version

dyn.load("minimumPath.so")
minimumPathC <- function(mat, n, m) {
  .Call("minimumPath_", mat, as.integer(n), as.integer(m))
}


minimumPath(input, dim, dim)
minimumPathC(input, dim, dim)

bench::mark(
  minimumPath(input, dim, dim),
  minimumPathC(input, dim, dim)
)


# Construct larger map

# We can use the base function to construct a Kronecker sum, by first defining
# the summation matrix that gives the amount that every submatrics should get
# added.
# Afterwards, we have to assure that the values fall into 1, ..., 9. For doing
# so, one can apply Modulo 9 and subsequently "fix" the 0s back to 9s.

sum_mat <- matrix(rep(0:4, 5) + rep(0:4, each = 5), byrow = TRUE, nrow = 5)

input2 <- kronecker(sum_mat, input, FUN = "+") %% 9
input2[input2 == 0] <- 9
mode(input2) <- "integer"


# Test input passes, however main input does not...

minimumPath(input2, dim * 5, dim * 5)
minimumPathC(input2, dim * 5, dim * 5)

bench::mark(
  minimumPath(input2, dim*5, dim*5),
  minimumPathC(input2, dim*5, dim*5)
)
