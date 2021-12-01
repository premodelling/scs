# Title     : Explore Age Group & Method
# Objective : Explore Age Group & Method
# Created by: greyhypotheses
# Created on: 01/12/2021


MixedGraphAgeMethod <- function (survey) {

  ggplot(data = survey) +
    geom_bar(mapping = aes(x = agegroup, fill = method), alpha = 0.25, na.rm = TRUE) +
    scale_fill_manual(values = c('red', 'green')) +
    theme_minimal() +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major = element_blank(),
          axis.text.x = element_text(size = 11, angle = 90),
          axis.text.y = element_text(size = 11),
          axis.title.x = element_text(size = 13),
          axis.title.y = element_text(size = 13)) +
    xlab(label = '\nage group\n') +
    ylab(label = 'count\n')

}

SplitGraphAgeMethod <- function (survey) {

  ggplot(data = survey) +
    geom_bar(mapping = aes(x = agegroup), alpha = 0.65, na.rm = TRUE) +
    facet_wrap(facets = ~ method) +
    theme_minimal() +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major = element_blank(),
          panel.spacing = unit(2, units = 'lines'),
          strip.text.x = element_text(size = 13),
          axis.text.x = element_text(size = 11, angle = 90),
          axis.text.y = element_text(size = 11),
          axis.title.x = element_text(size = 13),
          axis.title.y = element_text(size = 13)) +
    xlab(label = '\nage group\n') +
    ylab(label = 'count\n')

}