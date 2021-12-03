# Title     : Area Code description
# Objective : Area code description
# Created by: greyhypotheses
# Created on: 03/12/2021


AreaCodeDescriptions <- function (mappings) {

  # Output Area Classifications; Includes Rural & Urban Demarcations
  oac11 <- fread(file = 'data/postcodes/dictionaries/2011_output_area_classification_uk.csv',
                 select = c('OAC11', 'Supergroup', 'Group'), strip.white = TRUE,
                 colClasses = c(OAC11 = 'character', Supergroup = 'character', Group = 'character'),
                 data.table = FALSE)
  names(oac11) <- c('oac11', 'oac_supergroup', 'oac_group')
  oac11$oac_supergroup <- tolower(oac11$oac_supergroup)
  oac11$oac_group <- tolower(oac11$oac_group)



  # Rural Urban Classifications
  ru11ind <- fread(file = 'data/postcodes/dictionaries/2011_rural_urban_indicator_gb.csv',
                   colClasses = list(character = c('RU11IND', 'RU11NM')),
                   data.table = FALSE)
  names(ru11ind) <- c('ru11ind', 'ru11name')



  # The descriptions for the codes in mappings
  descriptions <- mappings %>%
    left_join(y = oac11, by = 'oac11') %>%
    left_join(y = ru11ind, by = 'ru11ind' )

  return(descriptions)


}