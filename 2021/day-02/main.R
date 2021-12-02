
input <- read.delim("input.txt", sep = " ", header = FALSE)

# Part I:

d <- aggregate(V2 ~ V1, input, FUN = "sum", simplify = TRUE)
x <- d$V2[d$V1 == "forward"]
y <- d$V2[d$V1 == "down"] - d$V2[d$V1 == "up"]

print(prod(x, y))


# Part II:

x <- 0
y <- 0
aim <- 0
aim_dir <- (as.integer(input$V1)  - 2) * -1

for (i in seq_len(nrow(input))) {
  if (aim_dir[i] == 0) {
    x <- x + input$V2[i]
    y <- y + aim * input$V2[i]
  } else {
    aim <- aim + aim_dir[i] * input$V2[i]
  }
}

print(prod(x, y))
