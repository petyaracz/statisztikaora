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

########################
# megoldás!

tossCoin = function(ntoss = 1){ # ntoss a valtozo neve, ami azt mondja meg, hanyszor dobunk. itt beallitottam egy default erteket, ami az egy
  coin = c('heads', 'tails')
  coin.throws = sample(coin, size = ntoss, replace = T)
  heads = coin.throws[coin.throws == 'heads'] %>% length
  heads.ratio = heads / ntoss
  return(heads.ratio)
}

tossCoin()
tossCoin(1) # ez ugyanaz
tossCoin(10^8) # ez tizmillio dobas, egy darabig eltart
