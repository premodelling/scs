# Title     : Explore Contacts
# Objective : Distribution of total contacts values
# Created by: Think
# Created on: 09/12/2021


TotalContactsDensity <- function (survey) {
  ggplot(data = survey) +
    geom_density(mapping = aes(x = total_contacts)) +
    theme_minimal()
}

TotalContactsHistogram <- function (survey) {
  ggplot(data = survey) +
    geom_histogram(mapping = aes(x = total_contacts)) +
    theme_minimal()
}

AgeGroupBar <- function () {
  barplot(table(survey$agegroup), col = 'black', las = 2,
          xlab = '\n', ylab = 'count\n', main = 'Age Groups')
}

OccupationBar <- function () {
  barplot(table(survey$occupation), col = 'black', las = 2,
          xlab = '\n', ylab = 'count\n', main = 'Occupations')
}

DayOfWeekBar <- function () {
  barplot(table(survey$day_of_week), col = 'black', las = 2,
          xlab = '\n', ylab = 'count\n', main = 'Day of Week')
}

