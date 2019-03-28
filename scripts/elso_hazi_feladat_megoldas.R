#  
# házi föladat megoldása:  
#

library(tidyverse)
# A githubra feltettem a "sleepstudy.txt" nevű adathalmazt. Ezt a read_csv függvény segítségével tudjátok elérni, a path ugyanaz, mint a "magyar.txt" és "heid.txt" fájloknál, csak a fájlnév különbözik.
d = read_csv(url("https://raw.githubusercontent.com/petyaracz/statisztikaora/master/data/sleepstudy.txt"))

# 
# Az adathalmazban kísérleti alanyok vannak ("Subject"). Mindegyiket napokon át tartják ébren ("Days"). Minden nap megmérik a reakcióidejüket valamilyen feladattal (ha meglátod a fényt, nyomd meg a gombot, ilyesmi). ("Reaction").
d

# 
# Ez egy gonosz kísérlet.
# 
# Sejtjük, hogy egy kilenc napja ébren lévő ember kicsit lassabban reagál, mint egy egy napja ébren lévő.
# 
# Íme a feladat: az órán megismert módon
# 
# - csináljatok egy új adathalmazt (tibble-t), amibe azt teszitek, hogy
d2 = 
# - fogjátok az eredeti "sleepstudy" adathalmazt
  d %>% 
# - csoportosítjátok benne az adatokat ébrenlét napja szerint (ez ugye az, hogy hány napja vannak ébren az egyes alanyok)
  group_by(Days) %>% 
# - kiszámoljátok minden csoportnak a reakció idő átlagát.
  summarise(
    mean.Reaction = mean(Reaction)
  )
# 
d2
# A végeredménynek tíz sora lesz, és két oszlopa. Az első oszlop a nap száma (első nap, második nap, stb). A második oszlop az alanyok által produkált reakciódiők aznapi átlaga.
# 
# Ezután készítsetek egy ábrát, amin scatterplot segítségével összevetitek a nap számát (0-9) és a napi átlag reakcióidőt. 
ggplot(d2, aes(Days, mean.Reaction)) +
  geom_point()
# Rajzoljatok az ábrára egy egyenest az órán látott módon, ami megmutatja, milyen erős a két változó viszonya, és mekkora a mérés hibája. 
ggplot(d2, aes(Days, mean.Reaction)) +
  geom_point() +
  geom_smooth(method = 'lm')