# Title     : Get Geograaphic Data
# Objective : Geographic data
# Created by: Think
# Created on: 03/12/2021

source(file = 'R/mapping/AreaCodeDescriptions.R')

#' @param frame: A data frame of unique postcodes; field name 'postcode'
#'
#' @return A data frame wherein each post code is associated with a number
#'         of geographic Office for National Statistics (UK) Codes & Descriptions
#'
GeographicData <- function (frame) {

  # Geographic Data
  geographicdata <- fread(file = 'warehouse/geographic.csv')

  # Mapping the postcodes in 'frame' to those in 'geographicdata'
  mappings <- left_join(x = frame, y = geographicdata, by = 'postcode')

  # Enhance ...
  descriptions <- AreaCodeDescriptions(mappings = mappings)

  return(descriptions)

}