# Title     : Day of Week & Occupation
# Objective : Day of Week & Occupation
# Created by: greyhypotheses
# Created on: 01/12/2021

GraphDayOccupation <- function (survey) {

  ggplot(data = survey) +
    geom_bar(mapping = aes(x = day_of_week, fill = occupation), alpha = 0.65, na.rm = TRUE) +
    theme_minimal() +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major = element_blank(),
          panel.spacing = unit(2, units = 'lines'),
          strip.text.x = element_text(size = 13),
          axis.text.x = element_text(size = 11, angle = 90),
          axis.text.y = element_text(size = 11),
          axis.title.x = element_text(size = 13),
          axis.title.y = element_text(size = 13)) +
    xlab(label = '\nday of week\n') +
    ylab(label = 'count\n')

}