library(checkmate)

dyn.load("minimumPath.so")
minimumPathC <- function(mat, n, m) {
  assertInteger(n)
  assertInteger(m)
  assertMatrix(mat, mode = "integerish")

  if (!testMatrix(mat, mode = "integer"))
    mode(mat) <- "integer"

  .Call("minimumPath_", mat, as.integer(n), as.integer(m))
}

dim <- 3L
test_mat <- matrix(1:9, nrow = dim)
mode(test_mat) <- "integer"
res <- minimumPathC(test_mat, dim, dim)

sprintf("Result is: %s.", res)
