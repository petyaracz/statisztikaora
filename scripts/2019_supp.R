setwd('~/Work/lectures_apps/lectures/statisztika2019/statgit/statisztikaora/')
library(tidyverse)

av = read_csv(url("https://vincentarelbundock.github.io/Rdatasets/csv/Stat2Data/AudioVisual.csv"))

av = av[, 2:5]
av
av = pivot_wider(av, names_from = Stimulus, values_from = ResponseTime)

hist(av$auditory)

av_subjects = av[, c('Subject', 'Group')]
av_data = av[,c('Subject', 'auditory', 'visual')]

write_csv(av_subjects, 'data/av_subjects.txt')
write_csv(av_data, 'data/av_data.txt')

lt = read_csv('~/Downloads/dolog.txt')

lt = lt %>% select(-SD,-Mean)
lt
e1 = lt %>% filter(Experiment==1)
e2 = lt %>% filter(Experiment==2)
write_csv(e1, 'data/lt_e1.txt')
write_csv(e2, 'data/lt_e2.txt')
