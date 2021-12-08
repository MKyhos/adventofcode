
fish <- function(t, r0 = 9, r = 7, b = 2) {
  print(sprintf("t := %s", t))
  # Return 1: if no additional fork is possible
  if (t <= r0) {
    print(sprintf("t <= %s => 1", r0))
    return(1)
  }

  # Return 2: if only one additional fork is possible
  if (t <= r0 + min(r, r0)) {
    print(sprintf("t <= %s => 2", r0 + min(r0, r)))
    return(2)
  }

  # Find future forks:
  t_n <- t - r0
  k_seq <-  t_n:0
  k_seq <- k_seq[k_seq %% r == 0]
  fr <- 1
  print(sprintf("k := {%s}", toString(k_seq)))

  for (ks in sort(k_seq, decreasing = TRUE))
    fr <- fr + fish(ks, r0 = 8, r, b)
  return(fr)
}


fishAdvanced <- function(inits, t) {
  sum <- 0
  for (p in inits) {
    sum <- sum + fish(t, r0 = p, r = 7, b = 2)
  }
  return(sum)
}

