# Title     : Play area
# Objective : Play area
# Created by: Think
# Created on: 03/12/2021



# The fields of interest in the post code data files
fields <- c('pcds', 'ctry', 'cty', 'ru11ind', 'oac11', 'lat', 'long')
colClasses <- c(pcd = 'character', ctry = 'character', cty = 'character',
                ru11ind = 'character', oac11 = 'character', lat = 'numeric', long = 'numeric')

source(file = 'R/mapping/AreaCodeMapping.R')
AreaCodeMapping(fields = fields, colClasses = colClasses)