##################################
# otodik ora (13/3/19)
##################################

library(tidyverse)

# korrelaciok

anscombe
# linearis viszonyt teszunk fol
ggplot(anscombe, aes(x1, y1)) +
  geom_point() +
  geom_smooth(method = 'lm', lty = 2)

ggplot(anscombe, aes(x2, y2)) +
  geom_point() +
  geom_smooth(method = 'lm', lty = 2)

ggplot(anscombe, aes(x3, y3)) +
  geom_point() +
  geom_smooth(method = 'lm', lty = 2)

ggplot(anscombe, aes(x4, y4)) +
  geom_point() +
  geom_smooth(method = 'lm', lty = 2)

with(anscombe, cor(x1, y1))
with(anscombe, cor(x2, y2))
with(anscombe, cor(x3, y3))
with(anscombe, cor(x4, y4))


# akarmilyen viszonyt teszunk fol
ggplot(anscombe, aes(x1, y1)) +
  geom_point() +
  geom_smooth(colour = 'red', lty = 2)
ggplot(anscombe, aes(x2, y2)) +
  geom_point() +
  geom_smooth(colour = 'red', lty = 2)
ggplot(anscombe, aes(x3, y3)) +
  geom_point() +
  geom_smooth(colour = 'red', lty = 2)
ggplot(anscombe, aes(x4, y4)) +
  geom_point() +
  geom_smooth(colour = 'red', lty = 2)




########################################
d = read_csv(url("https://raw.githubusercontent.com/petyaracz/statisztikaora/master/data/magyar.txt"))
d$initial = substr(d$word, 1, 1)

d



# a sziv segedigei

# szurj oszlop szerint: select()
# szurj sor szerint: filter()
# rakd sorba: arrange()
# foglald ossze: group_by()
# csinalj egy uj oszlopot a regiekbol: mutate()
# csinalj egy uj tibble-t a regibol: summarise()

########################################
# select()

select(d, word, pos)

d2 = select(d, word, pos, lemmafreq)

d2

########################################
# filter()

filter(d, initial == 'z')
filter(d, initial == 'z' | initial == 's')
filter(d, initial %in% c('z', 's'))

# lehet tobbet is

filter(d, initial == 'z', pos == 'NOUN')

# lehet operatorokat hasznalni

filter(d, initial == 'z' | pos == 'NOUN')

# lehet intervallumokra keresni

filter(d, freq == 7772593)

filter(d, freq > 7000000)

filter(d, freq > 7000000, freq < 8000000)

filter(d, freq > 8000000 | freq < 7000000)

# lehet beletenni fuggvenyeket is!

filter(d, log.freq > log(7000000))

filter(d, log.freq > mean(log.freq))

# mindezeket el lehet menteni valami uj tibble-be

d2 = filter(d, log.freq > mean(log.freq))

# aztan ezt meg is csodalhatjuk

d2
View(d2)

# feladatok
# azok a fonevek, amelyek m-el kezdodnek, es 50000-nel kevesebb van beloluk
# azok a szavak, amelyek zarhanggal kezdodnek (p,t,k,b,d,g), es tobb van beloluk, mint az atlag
# azok a szavak, amelyeknek a gyakorisaga PAROS
d$freq / 2
filter(d, freq )

########################################
# arrange()

arrange(d, log.freq)
arrange(d, -log.freq)
arrange(d, word) # karaktersorokat abc sorrendbe tesz
arrange(d, -word) # ilyen nincsen
tail(d) # de van ilyen!