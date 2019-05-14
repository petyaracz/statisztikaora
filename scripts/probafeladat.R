library(tidyverse)

#########################################
# probafeladat!
#########################################

frequencies = read_csv(url("https://raw.githubusercontent.com/petyaracz/statisztikaora/master/data/english1.txt"))
ratings = read_csv(url("https://raw.githubusercontent.com/petyaracz/statisztikaora/master/data/english2.txt"))

# A frequencies táblázat a Celex korpuszból származik, angol szavak (lemmák) gyakoriságát, átírását, és szófaji tagjét tartalmazza. A gyakoriság, ahogyan az korpusznyelvészetben gyakori, úgy van megadva, hogy a szó egy, egymillió szavas mintában való előfordulásának a logaritmusa. (Az "abandon" szó egymillió szóban kb 1.6-szor fordul elő, ennek a természetes logaritmusa 0.48.)

# A ratings táblázat Kuperman et al Age of Acquisition kutatásából származik, és azt mondja meg, hogy egy adott szót kb hány évesen tanulnak meg az emberek. Erre ők több értékelést gyűjtöttek, ebben a táblázatban a szavankénti átlagukat találjuk.

# A lentiekben a szógyakoriság és az elsajítátís ideje közötti viszonyt fogjuk boncolgatni, górcső alá venni, stb.

# Feladatok

# 1. A frequencies táblázatban van egy rakás szó, amelyek extrém módon gyakoriak. Az ilyen úgynevezett outlier értékek torzíthatják az eredményeink, ezért ki kell őket hajigálni.

# Számold ki szófajonként az átlagos szógyakoriságot és a szógyakoriság standard deviation-jét (tippek: group_by, summarise). Definiálj szófajonként egy felső gyakorisági értéket, amely az átlag gyakoriság plusz a standard deviáció két és félszerese. Dobáld ki azokat a szavakat, amelyeknek a gyakorisága efölött az érték fölött van (filter).

# 2. Csinálj egy boxplotot, amin szófajonként látjuk a szógyakoriságot. A szófajok sorrendje feleljen meg a bennük lévő szavak gyakoriságának. (Az átlagosan leggyakoribb szófaj legyen az első, stb.)

# 3. Csinálj egy scatterplotot (points plotot), amely összeveti a szógyakoriságot a szó elsajátításának idejéve. Bontsd szét szófajokra. Jelöld rajta a két érték viszonyát egy lineáris model segítségével (stat_smooth(method = 'lm')).