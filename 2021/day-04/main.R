# Day 04

draws <- scan("input.txt", nlines = 1, sep = ",")
boards <- scan("input.txt", skip = 1)
n_boards <- length(boards) / 25

boards <- array(
  unlist(lapply(
    split(boards, f = rep(1:n_boards, each = 25)),
    function(s) matrix(s, nrow = 5, ncol = 5, byrow = TRUE))
  ),
  c(5, 5, 100)
)

calc_win <- function(array, last=FALSE) {
  boards_lgl <- boards == draws[1]
  idx_prev <- rep(FALSE, dim(array)[3])

  for (i in 2:length(draws)) {
    boards_lgl[boards == draws[i]] <- TRUE
    idx_win <- apply(boards_lgl, 3, function(x) max(colSums(x), rowSums(x)) == 5)
    recent <- which(idx_win & !idx_prev)
    idx_prev <- idx_win

    if ((last && all(idx_win)) || (!last && any(idx_win)))
        return(draws[i] * sum(boards[, , recent][!boards_lgl[, , recent]]))
  }
  message("No Winner!")
}

# Part I:
calc_win(boards)

# Part II:
calc_win(boards, last = TRUE)


