# Title     : Area Code Mapping
# Objective : Area Code Mapping
# Created by: greyhypotheses
# Created on: 02/12/2021


AreaCodeMappings <- function (fields, colClasses) {

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
  fwrite(x = features, file = 'warehouse/geographic.csv')

}