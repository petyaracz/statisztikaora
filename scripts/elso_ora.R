##################################
# elso ora (13/2/19)
##################################


# R vs Excel: replicability
# R vs SPSS: ~
# R vs Matlab: penzbe kerul
# R vs python: mindegy
# R & RStudio: kezdoknek jo
# R libraries / CRAN / github
# tidyverse
# https://r4ds.had.co.nz/data-visualisation.html
# Rstudio reszei: mik az ablakok!

install.packages('tidyverse')
library('tidyverse')

##############
# alapveto muveletek
##############

# hello vilag
print('hello world')
'hello world' %>% print

# szamologep
1 + 1
2 * 2
R.Version()
sqrt(9)
log10(100)
log(2.71828)

# konstansok
pi
pi = 3.151493
pi
nekem.lampast.adott.kezembe.az.ur.pesten = pi
nekem.lampast.adott.kezembe.az.ur.pesten = pi
nekem.lampast.adott.kezembe.az.ur.pesten <- pi
pi -> nekem.lampast.adott.kezembe.az.ur.pesten

# valtozok
x = 1 + 1
1 + 1 -> x
x <- 1 + 1

y = x * 2
exp(y)

# vektorok
z = c(1, 2, 3, 4)
z = (1, 2, 3, 4)

# fuggvenyek
z + 1
z^2

# stringek

s = 'hello world' 
s = "hello world"
s*2
rep(s, 2)
s.vector = rep(s, 2)

# adathalmazok

d = as_tibble(iris)
View(d)


dim(d)
d %>% dim

head(d)
d %>% head

tail(d)
d %>% tail

summary(d)
str(d)

d %>% summary