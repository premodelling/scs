# Title     : Area Code Mapping
# Objective : Area Code Mapping
# Created by: greyhypotheses
# Created on: 02/12/2021


AreaCodeMapping <- function (frame) {

  # The fields of interest in the post code data files
  fields <- c('pcds', 'ctry', 'cty', 'ru11ind', 'oac11', 'lat', 'long')
  colClasses <- c(pcd = 'character', ctry = 'character', cty = 'character',
                  ru11ind = 'character', oac11 = 'character', lat = 'numeric', long = 'numeric')

  # The list post code directories
  listof <- list.files(path = 'data/postcodes/codes/', pattern = '*.csv', full.names = TRUE)

  # A read function for the data files
  read <- function (filestr) {
    data.table::fread(file = filestr, header = TRUE, select = fields, colClasses = colClasses,
                      encoding = 'UTF-8', strip.white = TRUE, data.table = FALSE)
  }

  # Reading the fields of interest from multiple files
  features <- lapply(X = listof, FUN = read)
  features <- dplyr::bind_rows(features)
  names(features)[names(features) == 'pcds'] <- 'postcode'

  # Mapping
  mappings <- left_join(x = frame, y = features, by = 'postcode')

  return(mappings)

}