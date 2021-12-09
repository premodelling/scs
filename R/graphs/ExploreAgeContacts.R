# Title     : Age & Contacts
# Objective : Age & Contacts
# Created by: greyhypotheses
# Created on: 01/12/2021

GraphAgeContacts <- function (survey) {

  ggplot(data = survey) +
    geom_boxplot(mapping = aes(x = agegroup, y = total_contacts, col = agegroup),
                 show.legend = FALSE, notch = TRUE, notchwidth = 0.5, na.rm = TRUE) +
    ggplot2::coord_trans(y = 'log') +
    theme_minimal() +
    theme(axis.text.x = element_text(size = 11, angle = 90),
          axis.text.y = element_text(face = "bold", size = 11),
          axis.title.y = element_text(size = 13),
          aspect.ratio = 1) +
    ylab(label = 'total contacts') +
    xlab(label = '')

}

