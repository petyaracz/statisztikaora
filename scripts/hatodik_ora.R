##################################
# hatodik ora (18/3/19)
##################################

library(tidyverse)

d = read_csv(url("https://raw.githubusercontent.com/petyaracz/statisztikaora/master/data/heid.txt"))

# d = read_csv('heid.txt')

# transform>visualise>model>transform etc
# mi ez az adathalmaz: reaction time kiserletek. (letezo es kamu szavak, ismerem/nem ismerem)

# 1. na mi ez
d
# kimeneti valtozo: RT. prediktor: BaseFrequency (az adatokbol ez nem trivialis!). mindketto log transzformalt.
# RT = reaction time. milyen gyorsan reagalsz az adott szora (altalaban valami gombokat kell nyomkodni ilyen kiserletekben).
# BaseFrequency: ezek ugye kepzett fonevek (melleknev + heid). ez a szam a SZOTO gyakorisaga valami holland nyelvu korpuszban.

# 2. milyen a kimeneti valtozo (RT) es a prediktor (BaseFrequency) eloszlasa?
ggplot(d, aes(RT)) + geom_histogram()
ggplot(d, aes(BaseFrequency)) + geom_histogram()

# 2.5 hogyan neznek ki a nyers adatok?
d = 
  d %>% 
  mutate(
    RT.raw = exp(RT),
    BaseFrequency.raw = exp(BaseFrequency)
  )

ggplot(d, aes(RT.raw)) + geom_histogram()
ggplot(d, aes(BaseFrequency.raw)) + geom_histogram()

# 3. milyen a viszony a BaseFrequency es a RT kozott?
ggplot(d, aes(BaseFrequency, RT)) +
  geom_point()

# 4. miert van egy csomo pont egy-egy oszlopban?
ggplot(d, aes(BaseFrequency, RT, colour = Word)) +
  geom_point()

# 5. egy szo: sok meres. nem a scatterplot a legjobb eszkoz erre.
ggplot(d, aes(Word, RT, colour = Word)) +
  geom_boxplot()

# tegyuk sorba!
d %>% 
  mutate(
    Word2 = reorder(Word, RT)
  ) %>% 
  ggplot(aes(Word2, RT, colour = Word2)) +
  geom_boxplot()
  
# mutate fuggveny: https://r4ds.had.co.nz/transform.html#add-new-variables-with-mutate

# 6. valamiert nagyon szet vannak huzva ezek az eloszlasok. kiktol jonnek a pontok?
ggplot(d, aes(BaseFrequency, RT, colour = Subject)) +
  geom_point() + 
  guides(colour = F) # kikapcsolom a legend-et, mert itt eleg keveset ad hozza az elmenyhez.
# ennek semmi ertelme.

# 7. egy subject: sok meres. boxplot!
ggplot(d, aes(BaseFrequency, RT, colour = Subject)) +
  geom_boxplot() +
  guides(colour = F)

# tegyuk sorba!
d %>% 
  mutate(
    Subject2 = reorder(Subject, RT)
  ) %>% 
  ggplot(aes(Subject2, RT, colour = Subject2)) +
  geom_boxplot() +
  guides(colour = F)

# 8. minden subjectre igaz, hogy van valami viszony a BaseFrequency es a RT kozott

d %>% 
mutate(
    Subject2 = reorder(Subject, RT)
  ) %>% 
ggplot(aes(BaseFrequency, RT)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  facet_wrap( ~ Subject2)

# 9. ki kene szamolni valami atlagokat. 

d.words = 
  d %>% 
  group_by(Word, BaseFrequency) %>% 
  summarise(Word.RT.mean = mean(RT), Word.RT.sd = sd(RT))

# group_by es summarise fuggvenyek: https://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise

d.words %>% 
ggplot(aes(BaseFrequency, Word.RT.mean)) +
  geom_point()

# de persze egy csomo informaciot kidobaltunk
d.words %>% 
ggplot(aes(BaseFrequency, Word.RT.mean)) +
  geom_point() +
  geom_errorbar(aes(ymin = Word.RT.mean-Word.RT.sd, ymax = Word.RT.mean+Word.RT.sd))

# de sebaj.

ggplot(d.words, aes(BaseFrequency, Word.RT.mean)) +
  geom_point() +
  geom_smooth(method = 'lm') # linearis modell segitsegevel egyenest illesztunk a pontokra

fit1 = lm(Word.RT.mean ~ BaseFrequency, data = d.words) # ugyanezt megcsinaljuk sima R-ben, a ggploton kivul.
summary(fit1) # igy mar megnezhetjuk a relevans szamokat is. nem baj, ha itt nem ertjuk mindent, hogy mi micsoda.
# a lenyeg a BaseFrequency hatasahoz rendelt p value. (Pr(>|t|)). ez 0.00153.

# minden egy kepen (nem szerencses):

ggplot(d, aes(BaseFrequency, RT, colour = Subject)) +
  geom_point() +
  geom_smooth(method = 'lm', se = F)