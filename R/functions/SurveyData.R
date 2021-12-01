# Title     : Survey Data
# Objective : Preparing the social contact survey data for exploration & analysis
# Created by: greyhypotheses
# Created on: 30/11/2021


# binary       c('postal', 'web')
# int          c('age', 'household_size', 'total_contacts')
# date         c('date')
# categorical  c('day_of_week', 'sex', 'occupation', 'unmatched_postcode')
# text         c('postcode')


source(file = 'R/functions/FrequenciesTable.R')
source(file = 'R/functions/IsReal.R')


SurveyData <- function () {

  survey <- read.csv(file = 'data/scs.csv', na.strings = c('NA', '-'))



  #' Binary fields
  #'

  # web & postal
  survey$web <- factor(x = survey$web, levels = c(0, 1), labels = c('no', 'yes'))
  survey$postal <- factor(x = survey$postal, levels = c(0, 1), labels = c('no', 'yes'))

  survey$method <- as.numeric(survey$postal == 'yes' & survey$web == 'no')
  survey$method <- factor(x = survey$method, levels = c(1, 0), labels = c('postal', 'online'))

  FrequenciesTable(field = survey$method, fieldname = 'method')



  #' Date fields
  #'

  # date
  survey$date <- as.Date(survey$date, format = '%d/%m/%Y')
  IsReal(field = survey$date, fieldname = 'date')



  #' Categorical fields
  #'

  # day_of_week
  survey$day_of_week <- factor(x = survey$day_of_week, levels = seq(from = 0, to = 6),
                               labels = c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
                               ordered = TRUE)

  # sex, the levels are in decreasing count order
  survey$sex <- factor(x = survey$sex, levels = c(0, 1, -1),
                       labels = c('female', 'male', 'unknown'))

  # occupation
  # it was stated during the lectures that ... in certain circumstances, and w.r.t. level definitions for
  # modelling/analysis ...the elements of a categorical field should be arranged in descending frequency order
  T <- FrequenciesTable(field = survey$occupation, fieldname = 'occupation') %>%
    arrange(-frequency) %>%
    filter(!is.na(occupation))
  survey$occupation <- factor(x = survey$occupation, levels = unlist(T$occupation))

  # unmatched_postcode
  # Each case below has 136
  #     is.na(survey$postcode) & survey$unmatched_postcode == -1
  #     survey$unmatched_postcode == -1
  survey$unmatched_postcode <- factor(x = survey$unmatched_postcode, levels = c(0, 1, -1),
                                      labels = c('no', 'yes', 'unspecified'))



  #' Integers
  #'

  # age
  survey[survey$age < 0, 'age'] <- NA
  survey$agegroup <- cut_interval(x = survey$age, length = 5)

  labelling <- FrequenciesTable(field = survey$agegroup, fieldname = 'agegroup') %>%
    arrange(-frequency) %>%
    filter(!is.na(agegroup))
  unlist(labelling$agegroup)

  survey$agegroup <- factor(x = survey$agegroup, levels = unlist(labelling$agegroup))
  FrequenciesTable(field = survey$agegroup, fieldname = 'agegroup')


  # household.size
  survey[survey$household_size >= 6, 'household_size'] <- '6+'
  survey$household_size <- factor(x = survey$household_size,
         levels = c('2', '1', '3', '4', '5', '6+', '-1'),
         labels = c('2', '1', '3', '4', '5', '6+', 'unknown'))
  FrequenciesTable(field = survey$household_size, fieldname = 'household_size')

  return(survey)

}