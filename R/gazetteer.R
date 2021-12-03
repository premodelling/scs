# Title     : Gazetteer
# Objective : Gazetteer
# Created by: Think
# Created on: 03/12/2021

# This piece of code extracts geographic data from the ONS
# post code files w.r.t. fields of interest
#
#   fields: fields of interest
#   colClasses: each field's type
#
# The data is saved in warehouse/geographic.csv
#
fields <- c('pcds', 'ru11ind', 'oac11', 'lat', 'long')
colClasses <- c(pcd = 'character', ru11ind = 'character',
                oac11 = 'character', lat = 'numeric', long = 'numeric')
AreaCodeMappings(fields = fields, colClasses = colClasses)