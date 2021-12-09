# Title     : Data
# Objective : Data
# Created by: greyhypotheses
# Created on: 09/12/2021

source(file = 'R/functions/SurveyData.R')
source(file = 'R/mapping/AreaCodeMappings.R')
source(file = 'R/mapping/GetGeographicData.R')

WithPlacesData <- function () {

  # The inspected/prepared survey data
  survey <- SurveyData()


  # Geographic data, which can be merged with 'survey' via
  # the 'postcode' field.  This snippet depends on
  # warrehouse/geographic.csv
  geography <- survey %>%
    dplyr::select(postcode) %>%
    unique() %>%
    dplyr::filter(!is.na(postcode)) %>%
    GetGeographicData()

  survey <- left_join(x = survey, y = geography[, c('postcode', 'ru11ind', 'ru11name', 'lat', 'long')],
                      by = 'postcode')


  # Variables of interest
  variables <- c('total_contacts', 'age', 'agegroup', 'postcode', 'ru11ind', 'ru11name', 'occupation',
                 'household_size', 'sex', 'method', 'day_of_week', 'lat', 'long')
  focus <- survey[, variables]



  # focus on records that have a post code
  focus <- focus[!is.na(focus$postcode), ]



  # Exclude Scotland; Instead of merging rural/urban classifications
  excl <- c('1':'8', 'Z9')
  focus <- focus[ !(focus$ru11ind %in% excl), ]
  any(focus$ru11ind %in% excl)


  # age limit
  focus <- focus %>%
    filter(age >= 35)


  # number of people per postcodecensus; unfortunately incomplete
  # https://www.nomisweb.co.uk/census/2011/postcode_headcounts_and_household_estimates
  # postcodecensus <- fread(file = 'data/postcode_census_estimate.csv')
  # names(postcodecensus) <- c('postcode', 'total_population', 'male_population',
  #                            'female_population', 'occupied_households')
  # focus <- left_join(x = focus, y = postcodecensus, by = 'postcode')


  return(focus)
}