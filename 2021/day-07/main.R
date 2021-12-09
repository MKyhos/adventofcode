x <- scan("input.txt", sep = ",")

# Part I

sum(abs(x - median(x)))


# Part II

# We can use the closed form solution for the
# nth partial sum of the series of natural numbers,
# 1, 2, 3, ..., which is denoted as
#
# \sum_{k=1}^n = \frac{n(n + 1)}{2}
#
# This can be used to write a loss function to be put
# into some optimizer function, e.g. `optim`.
optim(
  par = median(x),
  fn = function(i) {
    d <- abs(x - as.integer(i))
    sum(d * (d + 1) / 2)
  },
  method = "Brent",
  lower = 0,
  upper = max(x)
)
