##################################
# harmadik ora (27/2/19)
##################################

library(tidyverse)

# eloszlasok

set.seed(1337)
a = rnorm(1000, 0, 1)
b = rnorm(1000, 3, 1)
c = rnorm(1000, 6, 1) 
d = rnorm(1000, 0, 10)
e = c(rnorm(500, -3, 10),rnorm(500, 3, 10))
f = runif(n = 1000, -2, 2)

a
a %>% density %>% plot
a %>% hist
# szinten erdekesek:
d
e
f

# abrak
d = as_tibble(iris)
View(d)
# mit latunk
summary(d)

# https://www.rstudio.com/resources/cheatsheets/

## scatter plot

d %>% 
  ggplot() +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width))

d %>% 
  ggplot() +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width, colour = Species))

d %>% 
  ggplot() +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width, color = Species))

d %>% 
  ggplot() +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
  facet_wrap( ~ Species)

library(ggthemes)
library(RColorBrewer)

d %>% 
  ggplot() +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
  theme_dark() +
  scale_colour_brewer(palette = 'Set2')

## boxplot

d %>% 
  ggplot() +
  geom_boxplot(mapping = aes(x = Species, y = Sepal.Length, fill = Species))

d %>% 
  ggplot() +
  geom_violin(mapping = aes(x = Species, y = Sepal.Length, colour = Species))

d %>% 
  ggplot() +
  geom_violin(mapping = aes(x = Species, y = Sepal.Length, fill = Species))

# countplot

counts = d %>%
  mutate(big.plant = Petal.Length > mean(Petal.Length)) %>% 
  group_by(big.plant) %>% 
  summarise(n = n())

counts %>% 
  ggplot() +
  geom_col(mapping = aes(x = big.plant, y = n))