# Title     : Is Real
# Objective : Tally of real & missing elements of a data frame field
# Created by: greyhypotheses
# Created on: 01/12/2021


#' @param field: The column of a data frame
#' @param fieldname: The name of the column
IsReal <- function (field, fieldname) {

  N <- length(field)
  real <- sum(!is.na(field))
  numbers <- data.frame('real' = real, 'missing' = (N - real), row.names = fieldname)
  return(numbers)

}