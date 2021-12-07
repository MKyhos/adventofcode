

mat <- scan(pipe("awk '{gsub(\"\", \" \", $1); print $1;}' input.txt"))
mat <- matrix(mat, nrow = 1000, ncol = 12, byrow = TRUE)

# Part I


bin <- (colSums(mat) / nrow(mat)) >= 0.5

bin2decimal <- function(bin) {
  bin <- as.logical(bin)
  pow <- 2 ** ((length(bin) - 1):0)
  sum(pow[bin])
}

gamma <- bin2decimal(bin)
epsilon <- bin2decimal(!bin)
print(gamma * epsilon)

# Part II:

find_vals <- function(mat, rule = "oxygen") {
  for (j in seq_len(ncol(mat))) {
    freq_one <- sum(mat[, j]) / nrow(mat)
    if (freq_one > 0.5)
      common <- 1
    else if (freq_one < 0.5)
      common <- 0
    else
      common <- -1

    filter_val <- abs(common)
    if (rule == "co2")
      filter_val <- as.numeric(!common)

    msg <- sprintf("J: %s, rows: %s, freq_one: %s, filter: %s.", j, nrow(mat), freq_one, filter_val)
    message(msg)
    subsetter <- mat[, j] == filter_val

    mat <- mat[subsetter, ]

    if (sum(subsetter) == 1)
      return(mat)

  }
  return(mat)
}

oxygen <- bin2decimal(find_vals(mat, "oxygen"))
co2 <- bin2decimal(find_vals(mat, "co2"))
print(oxygen * co2)

