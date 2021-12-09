# Title     : Graphs
# Objective : Graphs
# Created by: greyhypotheses
# Created on: 09/12/2021

CoordinatesContactsPlace <- function (focus) {

  ggplot(data = focus, aes(x = long, y = lat, col = ru11name, size = total_contacts)) +
    geom_point(alpha = 0.65) +
    coord_map() +
    scale_colour_manual(values = c('red', 'blue', 'green', 'orange', 'tan',
                                   'black', 'thistle', 'yellow', 'maroon', 'purple')) +
    theme_minimal() +
    theme(plot.caption = element_text(hjust = 0, size = 11, colour = 'darkgrey'),
          axis.title.x = element_text(size = 13, face = 'bold'), axis.text.x = element_text(size = 11),
          axis.title.y = element_text(size = 13, face = 'bold'), axis.text.y = element_text(size = 11)) +
    xlab(label = '\nlongitude') +
    ylab(label = '\nlatitude\n') +
    guides(col = guide_legend(title = 'Rural Urban Classification'),
           size = guide_legend(title = 'Total Contacts'))

}

CoordinatesContacts <- function (focus) {

  ggplot(data = focus, aes(x = long, y = lat, col = total_contacts, size = total_contacts)) +
    geom_point(alpha = 0.85) +
    scale_color_gradient(low = 'orange', high = 'black') +
    coord_map() +
    theme_minimal() +
    theme(plot.caption = element_text(hjust = 0, size = 11, colour = 'darkgrey'),
          axis.title.x = element_text(size = 13, face = 'bold'), axis.text.x = element_text(size = 11),
          axis.title.y = element_text(size = 13, face = 'bold'), axis.text.y = element_text(size = 11)) +
    xlab(label = '\nlongitude') +
    ylab(label = '\nlatitude\n') +
    guides(col = guide_legend(title = 'Rural Urban Classification'),
           size = guide_legend(title = 'Total Contacts'))

}

