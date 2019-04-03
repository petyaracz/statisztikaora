library(tidyverse)

#########################################
# join: gyakorlas
#########################################

# eloszor gyakoroljuk az oran megismert join fuggvenyt

# adatok negy gyerekrol: Tibike, Pannika, Sarika, Zolika.
szinek = read_csv(url("https://raw.githubusercontent.com/petyaracz/statisztikaora/master/data/gyerekek1.txt"))
jatekok = read_csv(url("https://raw.githubusercontent.com/petyaracz/statisztikaora/master/data/gyerekek2.txt"))

szinek
# Gyerek - szin parok. A Sarika hianyzik: nem tudjuk, mi a Sarika kedvenc szine.

jatekok
# Gyerek - jatek parok. A Zolika hianyzik: nem tudjuk, mi a Zolika kedvenc jateka.

left_join(szinek, jatekok)
# a "gyerek" oszlop alapjan rakjuk ossze a ket tibble-t.
# megtartottunk minden sort az elso tibble-bol.
# a masodik tibble-ben nincs adat Zolikara, ezert az R behelyettesit egy "NA" erteket.
# az NA egy kulonleges ertek: azt jelenti, hogy "Not Applicable" azaz hogy ide nincs adat.

left_join(jatekok, szinek)
# ugyanez pepitaban. megtartunk minden sort az elso tibble-bol. de az most a jatekok, nem a szinek. 
# a masodik tibble-ben nincs adat Sarikara, ezert NA erteket kap

# a left_ es a right_ azt mondja meg, hogy a ket tibble-bol melyik a kituntetett.
# ld.
right_join(jatekok, szinek)

# tartsunk meg minden sort mindket tibble-bol!
full_join(jatekok, szinek)
# ez kb a left_ es a right_ join kombinacioja.
# a sorrend emiatt tokmindegy, a vegeredmeny informaciotartalma ugyanaz:
full_join(szinek, jatekok)

# tartsuk meg csak azt a ket gyereket, akikrol van informacio mindket tibble-ben:
inner_join(szinek, jatekok)
# sorrend megintcsak mindegy
inner_join(jatekok, szinek)
# ez veszelyes: Sarikat es Zolikat kiszortuk. 

#########################################
# spread, gather: gyakorlas
#########################################

# most jon egy kis ujdonsag, az R-es tablazatmasszirozas utolso fontos eszkozei

# na rakjuk ossze a ket tibble-t:
gyerekek = full_join(jatekok, szinek)

gyerekek
# ez egy ugynevezett _szeles_ (wide) tibble: egy gyerek egy sor. minden sorhoz ket _meres_ tartozik: kedvenc szin es kedvenc jatek.
# jellemzoen excelben gyujtott adatok szoktak igy kinezni. szemmel jobban kovetheto.
# a masik alternativa a _hosszu_ (long) tibble: egy meres egy sor. egy gyerek tobb sor.
# az R kepes valtani a ketto kozott.

# gyujtsuk ossze az oszlopokat egy hosszu tibble-be.
gather(gyerekek, key = 'kedvenc.tipus', value = 'kedvenc.dolog', -gyerek)
# a "gyerek" oszlopot megtartottuk. a masik ket oszlopot atalakitottuk:
# "kedvenc jatek" "kedvenc szin" -> "jatek vagy szin" "mi az konkretan"

# mentsuk el:
gyerekek_hosszu = gather(gyerekek, key = 'kedvenc.tipus', value = 'kedvenc.dolog', -gyerek)
# most alakitsuk vissza szelesse.
spread(gyerekek_hosszu, key = kedvenc.tipus, value = kedvenc.dolog)
# ott vagyunk, ahol elindultunk.

# az R-ben vegzett elemzesek altalaban hosszu (egy meres egy sor) adatformatumokkal szeretnek dolgozni. ezert foleg a gather parancs lesz hasznos az ember eleteben. de neha raszorulunk a spread-re is.

#########################################
# most jon a hazi feladat!
#########################################

# mindjart huzunk be adatokat egy hipotetikus kiserletbol.
# ebben a hipotetikus kiserletben az alanyoknak motorkerekparokat kell megkulonboztetniuk egymastol. mindenki lat otven fenykeppart, es el kell dontenie, hogy ugyanaz a motorkerekpar van a ket kepen, vagy ket kulonbozo.
# termeszetesen koztudott, hogy a ferfiak a szaguldas, a technologia, es igy motorkerekpar szerelmesei. ezzel szemben a noket inkabb a lovak es a harfak erdeklik. ezert azt varjuk, hogy a ferfiak gyorsabban fognak donteni minden egyes kep parnal, mint a nok.
# keszitsunk egy abrat, amely ezt vizsgalja meg.
# itt aztan minden eddigi tudasunkra szuksegunk lesz!
# azzal fogok segiteni, hogy elarulom a szukseges igeket/fuggvenyeket minden lepeshez.
# hasznos lehet meg megnezni a relevans cheat sheetet:
# https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf
# illetve meg lehet nezni az adott parancsok helpjet is. ez peldaul itt a join helpje.
# en a "join tidyverse" sor megguglizasaval talaltam meg az iment:
# https://dplyr.tidyverse.org/reference/join.html

# 0. az adatok

subjects = read_csv(url("https://raw.githubusercontent.com/petyaracz/statisztikaora/master/data/motorbike_subjects.txt"))
rts = read_csv(url("https://raw.githubusercontent.com/petyaracz/statisztikaora/master/data/motorbike_rts.txt"))

subjects
# ezt a fajlt a kiserleti asszisztensunk keszitette nekunk. benne van, hogy melyik kiserelti alany milyen nemu (M = Male, F = Female, itt most nincs mas opcio)

# latjuk, hogy tizenketten vannak, hat ferfi es hat no. minden subject egy sor.

rts
# ebbe a fajlba a kiserleti program irogatta be a reakcio idoket, es rogton meg is logolta nekunk. az nem baj, pont ugy szokas reakcioidokkel dolgozni.

# hu ez eleg csunya. itt minden subject egy oszlop. kiveve az elso oszlopot, ahol a kiserlet trial-jainak a sorrendje van. a szamok a reakcioidok. megintcsak kiveve az elso oszlopot, ahol a szam egyszeruen egy sorszam. tok gaz.

# ahhoz, hogy osszehasonlitsuk a ferfiak es a nok reakcioidejet, ossze kell passzintanunk a subjects as a rts tibble-eket.
# ahhoz, hogy osszepasszintsuk a ket tibble-t, a rts tibble-nek is ugy kene kineznie, hogy egy subject egy sor.
# ahhoz, hogy a rts tibble ugy nezzen ki, hogy egy subject egy sor, ossze kell huzni.

# 1. huzzuk ossze a rts tibblet. legyen egy sor egy subject. legyen a key (azonosito) az, hogy "subject", es a value (az ertek) az, hogy "reaction.time" (az R megbirkozik a szokozzel oszlopok neveben, de nem ajanlom, mert egy ido utan siras lesz a vege). a trial_number oszlopot ugyanugy ki kell hagyni, mint a fenti peldaban a gyerek oszlopot, mert azt meg akarjuk tartani ugy, hogy soronkent egy legyen belole. (ige: gather)

rts.long = gather(rts, key = 'subject', value = 'reaction.time', -trial_number)

# ha jol csinaltuk, az rts.long oszlop 12 subject x 10 trial per subject = 120 soros es harom (trial_number, subject, reaction.time) oszlopos.

# 2. rakjuk ossze a subjects es az rts.long tibble-oket. ugye az az oszlop, ami alapjan osszerakjuk oket, az a "subject" lesz. szerencsenk van, mert minden subject szerepel mindket tibble-ben, ezert minden join mukodni fog.

d = inner_join(subjects, rts.long)

# ha jol csinaltuk, a d ugy nez ki, mint az rts.long, csak benne van, hogy ki milyen nemu
# innen mar gyerekjatek!

# 3. szamoljuk ki minden subject atlagos reakcioidejet. (igek: group_by; summarise). vigyazat! egy tibble-ben kell lennie az atlagoknak es a gender-nek, hiszen ezt a kettot hasonlitjuk majd ossze.
# ket dolgot lehet csinalni kapasbol: vagy meg kell tartanunk a gender oszlopot is a group_by-ban, vagy kesobb megint oda kell joinolni. a dontest az olvasora bizom.

d2 = d %>% 
  group_by(subject, gender) %>% 
  summarise(
    mean.rt = mean(reaction.time)
  )

# vagy

d2 = d %>% 
  group_by(subject) %>% 
  summarise(
    mean.rt = mean(reaction.time)
  )

d2 = inner_join(d2, subjects)

# 4. johet is az abra! ugye egy faktort (ket csoport: nok es ferfiak) es egy szamvektort (mean.rt) hasonlitunk ossze, ezert a boxplot javasolt. (igek: ggplot)
# ezt persze megtudhatjuk a megfelelo cheat sheet-rol is.
# https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

ggplot(d2, aes(x = gender, y = mean.rt)) +
    geom_boxplot()

# aki brutalis kulonbseget lat a ket csoport kozott, ahol a F (female) kategoria atlag reakcioideje het korul van, a M (male) csoporte pedig 4.75 korul, az nyert.
