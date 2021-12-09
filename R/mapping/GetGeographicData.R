# Title     : Get Geograaphic Data
# Objective : Get Geographic Data
# Created by: Think
# Created on: 03/12/2021

source(file = 'R/mapping/AreaCodeDescriptions.R')

#' @param frame: A data frame of unique postcodes; field name 'postcode'
#'
#' @return A data frame wherein each post code is associated with a number
#'         of geographic Office for National Statistics (UK) Codes & Descriptions
#'
GetGeographicData <- function (frame) {

  # Geographic Data
  # geographicdata <- fread(file = 'warehouse/geographic.csv')
  # geographicdata <- read.csv(file = unz(description = 'warehouse/geographic.zip', filename = 'geographic.csv'))
  geographicdata <- data.table::fread(cmd = 'unzip -cq warehouse/geographic.zip')

  # Mapping the postcodes in 'frame' to those in 'geographicdata'
  mappings <- dplyr::left_join(x = frame, y = geographicdata, by = 'postcode')

  # Enhance ...
  descriptions <- AreaCodeDescriptions(mappings = mappings)


  # number of people per postcodecensus; unfortunately incomplete
  # https://www.nomisweb.co.uk/census/2011/postcode_headcounts_and_household_estimates
  postcodecensus <- fread(file = 'data/postcode_census_estimate.csv')
  names(postcodecensus) <- c('postcode', 'total_population', 'male_population',
                             'female_population', 'occupied_households')
  descriptions <- left_join(x = descriptions,
                     y = postcodecensus[, c('postcode', 'total_population')],
                     by = 'postcode')


  return(descriptions)

}