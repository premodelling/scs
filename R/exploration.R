# Title     : Exploration
# Objective : Exploration of Social Contact Survey Data
# Created by: greyhypotheses
# Created on: 30/11/2021


# The base plot area: mar = c(bottom, left, top, right)
graphics::par(mar = c(6, 5, 2, 2) )



# Custom/local external functions
source(file = 'R/functions/SurveyData.R')
source(file = 'R/mapping/AreaCodeMappings.R')
source(file = 'R/mapping/GetGeographicData.R')
source(file = 'R/functions/FrequenciesTable.R')
source(file = 'R/functions/ExploreDayMethod.R')
source(file = 'R/functions/ExploreAgeSex.R')
source(file = 'R/functions/ExploreAgeMethod.R')
source(file = 'R/functions/ExploreOccupationContacts.R')



# The inspected/prepared survey data
survey <- SurveyData()


# This snippet creates a geographic dictionary.
# source(file = 'R/mapping/Gazetteer.R')
# Gazetteer()


# Geographic data, which can be merged with 'survey' via
# the 'postcode' field.  This snippet depends on the zipped
# version of warehouse/geographic.csv, i.e., on warehouse/geographic.zip
geography <- survey %>%
  dplyr::select(postcode) %>%
  unique() %>%
  dplyr::filter(!is.na(postcode)) %>%
  GetGeographicData()

survey <- left_join(x = survey, y = geography[, c('postcode', 'ru11ind', 'ru11name', 'lat', 'long')],
                    by = 'postcode')



# The function FrequenciesTable() outlines the elements frequencies
# of categorical/binary fields
FrequenciesTable(field = survey$agegroup, fieldname = 'agegroup')
FrequenciesTable(field = survey$occupation, fieldname = 'occupation')
FrequenciesTable(field = survey$day_of_week, fieldname = 'day_of_week')

FrequenciesTable(field = survey$sex, fieldname = 'sex')
FrequenciesTable(field = survey$method, fieldname = 'method')
FrequenciesTable(field = survey$ru11name, fieldname = 'ru11name')



# How many Scotland based records? Only 326 records are explicitly associated with
# Scotland.  Hence instead of re-classifying the rural/urban categories, exclude
# the records from rural/urban modelling & analysis
places <- FrequenciesTable(field = survey$ru11name, fieldname = 'ru11name')
sum(places[12:19, 'frequency'])



# Graphs
ggplot(data = survey) +
  geom_density(mapping = aes(x = total_contacts)) +
  theme_minimal()

ggplot(data = survey) +
  geom_histogram(mapping = aes(x = total_contacts)) +
  theme_minimal()

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



# power graph: proportion vs log scale