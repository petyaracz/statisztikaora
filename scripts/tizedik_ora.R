#################################
# tizedik ora
#################################
# loptam:
# https://r4ds.had.co.nz/iteration.html


# Imagine we have this simple tibble:

df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

# We want to compute the median of each column. You could do with copy-and-paste:

median(df$a)
#> [1] -0.246
median(df$b)
#> [1] -0.287
median(df$c)
#> [1] -0.0567
median(df$d)
#> [1] 0.144

# But that breaks our rule of thumb: never copy and paste more than twice. Instead, we could use a for loop:

output <- vector("double", ncol(df))  # 1. output
for (i in seq_along(df)) {            # 2. sequence
  output[[i]] <- median(df[[i]])      # 3. body
}
output
#> [1] -0.2458 -0.2873 -0.0567  0.1443

map(df, median)
map_dbl(df, median)
map_chr(df, median)

# tegyunk bele fuggvenyt!
hMean = function(x){
  h.mean.x = 1 / mean( 1 / x)
  return(h.mean.x)
}

map(df, hMean)

# most eztet:

geometric.mean.x = exp(mean(log(x)))