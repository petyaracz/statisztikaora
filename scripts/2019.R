library(tidyverse)

# 1. The data

av_subjects = read_csv('https://raw.githubusercontent.com/petyaracz/statisztikaora/master/data/av_subjects.txt')

av_data = read_csv('https://raw.githubusercontent.com/petyaracz/statisztikaora/master/data/av_data.txt')

View(av_subjects)
View(av_data)

# 1.2 We need to pair up subject profession and subject response times

av = left_join(av_subjects, av_data, by = 'Subject')

av

# 1.3 This dataset is WIDE. One participant per line. We need to make it LONG. One observation per line.

av_long = pivot_longer(av, - c(Subject, Group), names_to = 'Condition', values_to = 'RT')

av_long

# 1.4 What do the distributions of RT-s look like? Do we need to logtransform them?

hist(av_long$RT)

av_long$log.RT = log(av_long$RT)

hist(av_long$log.RT)

# 2. Now we're ready to look at the data.

# 2.1 What are the basic differences between the two types of stimuli?

ggplot(av_long, aes(x = Condition, y = log.RT) ) +
  geom_boxplot()

# 2.2 Some participants are musicians, others aren't. Does this make a difference?

ggplot(av_long, aes(x = Group, y = log.RT) ) +
  geom_boxplot()

# 2.3 Evidently so. What about an interaction?

ggplot(av_long, aes(x = Condition, y = log.RT, fill = Group)) +
  geom_boxplot()

# 2.4 Alternatively.

ggplot(av_long, aes( x = Group, y = log.RT, fill = Condition)) +
  geom_boxplot()

# 2.5 Correlations between RT-s to auditory and visual stimuli?

ggplot(av, aes(x = auditory, y = visual)) +
  geom_point()

# 2.6 Correlation between this and whether the person's a musician?

ggplot(av, aes(x = auditory, y = visual, colour = Group)) +
  geom_point()

# 2.7 Let's check the trend lines.

ggplot(av, aes(x = auditory, y = visual, colour = Group)) +
  geom_point() +
  geom_smooth(method = 'lm')

# 3. Now it's your turn!!!


