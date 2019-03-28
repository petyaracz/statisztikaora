##################################
# negyedik ora (6/3/19)
##################################

library(tidyverse)

# folytatjuk a ggplotot!

d = read_csv(url("https://raw.githubusercontent.com/petyaracz/statisztikaora/master/data/magyar.txt"))

head(d)
summary(d)
# ejnye, a pos aligha karaktervektor
d$pos = as.factor(d$pos)

# freq : lemmafreq

d %>% 
  ggplot() +
  geom_point(mapping = aes(x = freq, y = lemmafreq)) +
  geom_smooth(mapping = aes(x = freq, y = lemmafreq))

# ha az osszes grafikai objektumnak (itt: geom_point es geom_smooth) ugyanaz a mappingja, akkor a mappingot meg lehet adni a ggplot fuggvenyen belul is. kevesebbet gepelsz:

d %>% 
  ggplot(mapping = aes(x = freq, y = lemmafreq)) +
  geom_point() +
  geom_smooth()

# ha utana beteszel egy uj mappingot valamelyik objektumhoz, akkor ott felulirja a globalis mappingot, de mashol nem:

d %>% 
  ggplot(mapping = aes(x = freq, y = lemmafreq)) +
  geom_point(mapping = aes(x = log.freq, y = log.lemmafreq)) +
  geom_smooth()

# az abra azert nez ki hulyen, mert a geom_smooth maradt freq : lemmafreq, de a geom_point mar log.freq : log.lemmafreq

# ja es a mappingbol kihagyhato kb minden parameternev, es akkor ugy veszi, hogy az elso dolog az x, a masodik az y (es ha egy dolog van, az akkor x):

d %>% 
  ggplot(aes(freq, lemmafreq)) +
  geom_point() +
  geom_smooth()

# jatekos feladat:

# - geom_point: log.freq : log.lemmafreq + pos szerint szinezve (colour)
# - geom_boxplot: pos : freq + pos szerint szinezve (colour vagy fill)


# mibol hany van (ujfajta plot!!)

d2 = d %>% 
  group_by(pos) %>% 
  summarise(n = n())

head(d2)

d2 %>% 
  ggplot(aes(pos, n)) +
  geom_col()

# plot twist

d2$pos2 = reorder(d2$pos, d2$n)
  
d2 %>% 
  ggplot(aes(pos2, n)) +
  geom_col()

# persze ezt meg lehet csinalni ennel is konnyebben

d2 %>%
  ggplot(aes(pos)) + 
  geom_bar()

# meglepetes!

d %>% 
  ggplot(aes(log.freq, log.lemmafreq)) +
  geom_point() +
  geom_smooth() +
scale_y_continuous(sec.axis = sec_axis(~exp(.))) +
scale_x_continuous(sec.axis = sec_axis(~exp(.)))