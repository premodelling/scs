# Title     : Explore Occupation & Contacts
# Objective : Explore Occupation & Contacts
# Created by: Think
# Created on: 01/12/2021


FrameOccupationContacts <- function (survey) {

  survey %>%
    select(occupation, total_contacts) %>%
    group_by(occupation) %>%
    summarise(median = median(total_contacts),
              mean = mean(total_contacts),
              maximum = max(total_contacts))

}

GraphOccupationContacts <- function (survey) {

  ggplot(data = survey) +
    geom_boxplot(mapping = aes(x = occupation, y = total_contacts, col = occupation),
                 show.legend = FALSE, notch = TRUE, notchwidth = 0.5, na.rm = TRUE) +
    ggplot2::coord_trans(y = 'log') +
    theme_minimal() +
    theme(axis.text.x = element_text(size = 11, angle = 22.5),
          axis.text.y = element_text(face = "bold", size = 11),
          axis.title.y = element_text(size = 13),
          aspect.ratio = 1) +
    ylab(label = 'total contacts') +
    xlab(label = '')

}