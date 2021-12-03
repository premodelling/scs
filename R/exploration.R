# Title     : Exploration
# Objective : Exploration of Social Contact Survey Data
# Created by: greyhypotheses
# Created on: 30/11/2021


# The base plot area: mar = c(bottom, left, top, right)
graphics::par(mar = c(6, 5, 2, 2) )



# Custom/local external functions
source(file = 'R/functions/SurveyData.R')
source(file = 'R/mapping/AreaCodeMappings.R')
source(file = 'R/functions/GeographicData.R')



source(file = 'R/functions/FrequenciesTable.R')
source(file = 'R/functions/ExploreDayMethod.R')
source(file = 'R/functions/ExploreAgeSex.R')
source(file = 'R/functions/ExploreAgeMethod.R')
source(file = 'R/functions/ExploreOccupationContacts.R')


# The inspected/prepared survey data
survey <- SurveyData()


# A Gazetteer: This snippet will create a geographic
# dictionary.  Study R/gazetteer.R
source(file = 'R/gazetteer.R')


# Geographic data, which can be merged with 'survey' via
# the 'postcode' field.  This snippet depends on the
# dictionary created by R/gazetteer.R
geography <- survey %>%
  select(postcode) %>%
  unique() %>%
  filter(!is.na(postcode)) %>%
  GeographicData()

survey <- left_join(x = survey, y = geography[, c('postcode', 'ru11ind', 'ru11name')],
                    by = 'postcode')



# The function FrequenciesTable() outlines the elements frequencies
# of categorical/binary fields
FrequenciesTable(field = survey$agegroup, fieldname = 'agegroup')
FrequenciesTable(field = survey$occupation, fieldname = 'occupation')
FrequenciesTable(field = survey$day_of_week, fieldname = 'day_of_week')

FrequenciesTable(field = survey$sex, fieldname = 'sex')
FrequenciesTable(field = survey$method, fieldname = 'method')



# Graphs
barplot(table(survey$agegroup), col = 'black', las = 2,
        xlab = '\n', ylab = 'count\n', main = 'Age Groups')

barplot(table(survey$occupation), col = 'black', las = 2,
        xlab = '\n', ylab = 'count\n', main = 'Occupations')

barplot(table(survey$day_of_week), col = 'black', las = 2,
        xlab = '\n', ylab = 'count\n', main = 'Day of Week')


# Age Group & Sex
GraphAgeSex(survey = survey)

# Day of Week & Survey Method
GraphDayMethod(survey = survey)

# Age Group & Method
MixedGraphAgeMethod(survey = survey)
SplitGraphAgeMethod(survey = survey)

# Occupations & Contacts
FrameOccupationContacts(survey = survey)
GraphOccupationContacts(survey = survey)


