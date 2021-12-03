

mat <- scan(pipe("awk '{gsub(\"\", \" \", $1); print $1;}' input.txt"))
mat <- matrix(mat, nrow = 1000, ncol = 12, byrow = TRUE)

# Part I


bin <- (colSums(mat) / nrow(mat)) >= 0.5

bin2decimal <- function(bin) {
  pow <- 2 ** ((length(bin) - 1):0)
  sum(pow[bin])
}

gamma <- bin2decimal(bin)
epsilon <- bin2decimal(!bin)
print(gamma * epsilon)

# Part II:
