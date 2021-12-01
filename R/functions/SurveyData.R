# Title     : Survey Data
# Objective : Preparing the social contact survey data for exploration & analysis
# Created by: greyhypotheses
# Created on: 30/11/2021

#'
#' binary       c('postal', 'web')
#' int          c('age', 'household_size', 'total_contacts')
#' date         c('date')
#' categorical  c('day_of_week', 'sex', 'occupation', 'unmatched_postcode')
#' text         c('postcode')


SurveyData <- function () {

  survey <- read.csv(file = 'data/scs.csv', na.strings = c('NA', '-'))
  N <- nrow(survey)



  #' Functions
  #'

  # element frequencies w.r.t. categorical/binary fields
  frequencies <- function (field) {
    numbers <- data.frame(table(survey[, field], useNA = 'always'))
    names(numbers) <- c(field, 'frequency')
    return(numbers)
  }

  # missing elements
  real <- function (field){
    elements <- sum(!is.na(survey[, field]))
    data.frame('real' = elements, 'missing' = (N - elements), row.names = field)
  }



  #' Binary fields
  #'

  # web & postal
  survey$web <- factor(x = survey$web, levels = c(0, 1), labels = c('no', 'yes'))
  survey$postal <- factor(x = survey$postal, levels = c(0, 1), labels = c('no', 'yes'))

  survey$method <- as.numeric(survey$postal == 'yes' & survey$web == 'no')
  survey$method <- factor(x = survey$method, levels = c(1, 0), labels = c('postal', 'online'))

  lapply(X = c('postal', 'web', 'method'), FUN = frequencies)



  #' Date fields
  #'

  # date
  survey$date <- as.Date(survey$date, format = '%d/%m/%Y')
  real(field = 'date')



  #' Categorical fields

  # day_of_week
  survey$day_of_week <- factor(x = survey$day_of_week, levels = seq(from = 0, to = 6),
                               labels = c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
                               ordered = TRUE)
  frequencies(field = 'day_of_week')

  # sex, the levels are in decreasing count order
  survey$sex <- factor(x = survey$sex, levels = c(0, 1, -1),
                       labels = c('female', 'male', 'unknown'))
  frequencies(field = 'sex')

  # occupation
  T <- frequencies(field = 'occupation') %>%
    dplyr::arrange(-frequency)
  occupations <- unlist(T$occupation)
  occupations <- occupations[!is.na(occupations)]
  survey$occupation <- factor(x = survey$occupation, levels = occupations)
  frequencies(field = 'occupation')

  # unmatched_postcode
  # Each case below has 136
  #     is.na(survey$postcode) & survey$unmatched_postcode == -1
  #     survey$unmatched_postcode == -1
  survey$unmatched_postcode <- factor(x = survey$unmatched_postcode, levels = c(0, 1, -1),
                                      labels = c('no', 'yes', 'unspecified'))
  frequencies(field = 'unmatched_postcode')



  #' Integers
  #'

  # age
  survey[survey$age < 0, 'age'] <- NA
  frequencies(field = 'age')
  survey$agegroup <- cut_interval(x = survey$age, length = 5)
  frequencies(field = 'agegroup')

  # household.size


}