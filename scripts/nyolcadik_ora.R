###########################
# nyolcadik ora (3/4/19)
###########################

# függvények!

library(tidyverse)

# függvény == kód, amit ismételgetsz
# függvények vs copy-paste
# 1. adhatsz neki valami frappáns nevet
# 2. ha meg akarsz később változtatni valamit, akkor elég egy helyen változtatni
# 3. kevesebbszer van alkalmad hibázni (igen hasznos)

# persze már használtunk függvényeket

szamok = c(1,2,3,4,5,6,7,8,9,10)
mean(szamok)
# ahelyett, hogy
( 1+2+3+4+5+6+7+8+9+10 ) / 10 # ugye tiz darab szam van, es az egyik a tiz.

# sőt, meg is ismételtük őket, hiszen a group_by pontosan ezt csinálja

iris %>%  # kedvenc virágméret adathalmazunk
  group_by(Species) %>% 
  summarise(
    mean.Petal.Length = mean(Petal.Length)
  )

# mi is definiálhatunk függvényeket

  # https://en.wikipedia.org/wiki/Harmonic_mean#/media/File:MathematicalMeans.svg

# fuggvenyNeve()
# valtozo.neve
# valtozo_neve
# harmonicMean()
# harmonic.mean

harmonicMean = function(some.numbers){
  h.mean = 1 / mean( 1 / some.numbers )
  return(h.mean)
}

# szerencsetlen nevek:
# rebrusPeter = function(torkenczy.miklos){
#   siptar.peter = 1 / mean ( 1 / torkenczy.miklos)
#   return(torkenczy.miklos)
# }

mean(szamok)
harmonicMean(szamok)

# a függvény részei: név (harmonicMean). argumentumok (some.numbers). test (a {} közötti rész)
# persze ez már másnak is eszébe jutott:
# install.packages('psych')
# psych::harmonic.mean(szamok)

iris %>%
  group_by(Species) %>% 
  summarise(
    h.mean.Petal.Length = harmonicMean(Petal.Length),
    h.mean.Petal.Width = harmonicMean(Petal.Width),
    h.mean.Sepal.Length = harmonicMean(Sepal.Length),
    h.mean.Sepal.Width = harmonicMean(Sepal.Width)
  )

# mennyivel jobb ez, mint ez

iris %>%
  group_by(Species) %>% 
  summarise(
    h.mean.Petal.Length = 1 / mean( 1 / Petal.Length),
    h.mean.Petal.Width = 1 / mean( 1 / Petal.Width),
    h.mean.Sepal.Length = 1 / mean( 1 / Sepal.Length),
    h.mean.Sepal.Width = 1 / mean( 1 / Sepal.Width)
  )

# de a legeslegjobb az, ha ezt a fuggvenyt is csak egyszer hasznaljuk.

iris.long = iris %>% 
  gather(key, value, -Species)

iris.long %>% head

iris.h.means = iris.long %>% 
  group_by(Species, key) %>% 
  summarise(h.mean = harmonicMean(value))

iris.h.means %>% 
  spread(key, h.mean)

iris %>%
  group_by(Species) %>% 
  summarise(
    h.mean.Petal.Length = harmonicMean(Petal.Length),
    h.mean.Petal.Width = harmonicMean(Petal.Width),
    h.mean.Sepal.Length = harmonicMean(Sepal.Length),
    h.mean.Sepal.Width = harmonicMean(Sepal.Width)
  )

# röviden, tömören

iris %>% 
  gather(key, value, -Species) %>% 
  group_by(Species, key) %>% 
  summarise(h.mean = harmonicMean(value)) %>% 
  spread(key, h.mean)

# a sok oszlopból csináltunk egyet, és az volt a függvény argumentuma.
# meg lehet azt is csinálni ehelyett, hogy automatikusan végigmegyünk minden oszlopon, de azt majd legközelebb.

# mi történik?
# függvényeket fűzünk össze, ahelyett, hogy egy függvényt ismételgetnénk. funkcionális programozás.
# mire jó ez?
# - nem tudjuk elrontani a valtozok neveit
# - nem tudunk megfeledkezni egy oszloprol
# - csak egyszer tudjuk elrontani a fuggvenyt

# a funkcionális programozás főleg azt jelenti, hogy egymásba tudjuk ágyazni a függvényeket. a pipe operátor pontosan ezt csinálja, ha nem is látható módon, hiszen a fenti kifejezés pipe nélkül valójában így néz ki:

spread(summarise(group_by(gather(iris, key, value, -Species), Species, key), h.mean = harmonicMean(value)), key, h.mean)

# ez kicsit erős persze. egy normális ember ezt valahogyan így írná le:
d1 = gather(iris, key, value, -Species)
d1 = group_by(d1, Species, key)
d1 = summarise(d1, h.mean = harmonicMean(value))
spread(d1, key, h.mean)

# a lényeg, hogy ti már hónapok óta, mit sem sejtve, funkcionálisan programoztok.

# játékos feladat!

# irj egy fuggvenyt, ami kiszamolja a geometriai kozepet

# itt a formula segitsegnek:
geometric.mean.x = exp(mean(log(x)))
# a cel:

szamok %>% log %>% mean %>% exp

geometricMean = function(x){
  g.mean = exp(mean(log(x)))
  return(g.mean)
}
  
geometricMean(szamok)

###################################
# random számok jönnek, rakjunk be egy seed-et
set.seed(438478)
# dobáljuk a kockát!
kocka = c(1,2,3,4,5,6)
# ez ugyanaz mint
kocka = 1:6

kiskocka1 = sample(kocka, size = 10, replace = T)
kiskocka2 = sample(kocka, size = 10, replace = T)
mean(nagykocka1 + nagykocka2)
# hát ez nem nagyon hét
gigakocka1 = sample(kocka, size = 10^6, replace = T)
gigakocka2 = sample(kocka, size = 10^6, replace = T)
mean(sum(gigakocka1)+sum(gigakocka2))
# ez már majdnem hét

# a sample bármivel működik
péz = c('fej', 'írás')
kisdobás = sample(péz, size = 10, replace = T)
# hányszor fej
fejek = kisdobás[kisdobás == 'fej'] %>% length
# hányszor dobtuk föl összesen
összes = kisdobás %>% length
# fejek aránya
fejek/összes
# hát ez nagyon nem 0.5

kisdobás = sample(péz, size = 10^6, replace = T)
# hányszor fej
fejek = kisdobás[kisdobás == 'fej'] %>% length
# hányszor dobtuk föl összesen
összes = kisdobás %>% length
# fejek aránya
arány = fejek/összes
arány
# ez már elég jó

########################
# házi feladat!

# csinálj egy függvényt, ami pénzt dobál. a végén kiírja, hogy mi volt a fejek aránya (ez fent a fejek/összes). az argumentuma az, hányszor dobjuk föl a pénzt.
# valami ilyen lesz:

tossCoin(number.of.tosses)
# és így kell használni
tossCoin(10)
tossCoin(100)
tossCoin(5760000000)