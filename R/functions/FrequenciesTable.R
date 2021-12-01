# Title     : Frequencies Table
# Objective : Frequencies Table
# Created by: greyhypotheses
# Created on: 01/12/2021


#' @param field: The column of a data frame
#' @param fieldname: The name of the column
FrequenciesTable <- function (field, fieldname = 'elements') {

  numbers <- data.frame(table(field, useNA = 'always'))
  names(numbers) <- c(fieldname, 'frequency')
  return(numbers)

}