#' Advent of Code, 2021 | Day 1

input <- scan("input.txt")

# Part I:
print(sum(diff(input) > 0))

# Part II:

rollsum <- function(vec, s = 3) {
  m <- length(vec) - s + 1
  d <- vec[1:s + rep.int(1:m, rep.int(s, m)) - 1]
  dim(d) <- c(s, m)
  colSums(d)
}

f <- function(vec) {
  if (TRUE)
    vec <- rollsum(vec, s = 3)
  sum(diff(vec) > 0)
}

print(f(input))
