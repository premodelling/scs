# Title     : Explore Populations
# Objective : UK & Sample Populations
# Created by: greyhypotheses
# Created on: 09/12/2021

ExplorePopulations <- function (survey) {

  # census data
  census <- read.csv(file = '../../data/census.csv')
  census$AgeGroup <- as.factor(census$AgeGroup)


  # age group & sex tally
  T <- table(survey$agegroup, survey$sex)
  quotients <- data.frame(female = T[, 'female'], male = T[, 'male'],
                          unknown = T[, 'unknown'], agegroup = rownames(T))
  quotients <- quotients %>%
    filter(female > 0 | male > 0)


  # merge group & census
  quotients <- left_join(x = quotients, y = census, by = c('agegroup' = 'AgeGroup'))


  # calculate ratios
  quotients <- quotients %>%
    mutate(UK = Males/Females) %>%
    mutate(Sample = male/female)


  # draw
  quotients %>%
    dplyr::select(agegroup, UK, Sample) %>%
    tidyr::gather(key = 'M/F Ratio', value = 'value', -agegroup) %>%
    ggplot() +
    geom_col(mapping = aes(x = agegroup, y = value, fill = `M/F Ratio`), position = 'dodge2') +
    theme_minimal() +
    theme(axis.text.x = element_text(size = 11, angle = 90),
          axis.text.y = element_text(size = 11),
          axis.title.x = element_text(face = 'bold', size = 13),
          axis.title.y = element_text(face = 'bold', size = 13),
          legend.title = element_text(),
          panel.grid.minor = element_blank(), panel.grid.major = element_line(size = 0.15)) +
    xlab('\nage group') +
    ylab('ratio\n')
}