#' Advent of Code, 2021 | Day 1

input <- as.integer(readLines("input.txt"))
input <- input[!is.na(input)]

rollsum <- function(vec, s = 3) {
  vapply(
    X = s:length(vec),
    FUN = function(k) sum(vec[(k - s + 1):k]),
    FUN.VALUE = numeric(1)
  )
}

f <- function(vec) {

  if (TRUE)
    vec <- rollsum(vec, s = 3)
  sum(diff(vec) > 0)
}

print(f(input))

