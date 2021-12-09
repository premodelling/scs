# Title     : Places
# Objective : Interested in rural/urban interactions, etc
# Created by: greyhypotheses
# Created on: 08/12/2021


source(file = 'R/functions/SurveyData.R')
source(file = 'R/mapping/AreaCodeMappings.R')
source(file = 'R/mapping/GetGeographicData.R')


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



# Sample for Sex, Age Group, Population
census <- read.csv(file = 'data/census.csv')
census$AgeGroup <- as.factor(census$AgeGroup)

focus <- focus %>%
  filter(age >= 35)




# Modelling
modelglmnb <- glm.nb(formula = total_contacts ~ agegroup + ru11ind + occupation + household_size + sex, data = focus)
summary(modelglmnb)
plot(modelglmnb)

modelglmnb <- glm.nb(formula = total_contacts ~ agegroup + ru11ind + occupation + household_size, data = focus)
summary(modelglmnb)
plot(modelglmnb)

modelglmnb <- glm.nb(formula = total_contacts ~ agegroup + ru11ind + occupation, data = focus)
summary(modelglmnb)
plot(modelglmnb)

modelglmnb <- glm.nb(formula = total_contacts ~ agegroup * ru11ind * occupation, data = focus)
modelglmnbstep <- step(modelglmnb, trace = 0)
summary(modelglmnbstep)
plot(modelglmnbstep)