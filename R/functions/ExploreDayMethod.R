# Title     : Methods EDA
# Objective : Exploring the intersection of Methods & Day of Week
# Created by: Think
# Created on: 01/12/2021


FrameDayMethod <- function(survey) {

  T <- table(survey$day_of_week, survey$method)
  spreads <- data.frame(postal = T[, 'postal'], online = T[, 'online']) %>%
    mutate(postal_frac = as.numeric(postal / rowSums(select(., postal, online))),
           online_frac = as.numeric(online / rowSums(select(., postal, online))),
           day_of_week = row.names(T))
  row.names(spreads) <- NULL

  spreads$day_of_week <- factor(x = spreads$day_of_week, labels = c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
                                ordered = TRUE )

  return(spreads)


}


GraphDayMethod <- function(survey) {

  spreads <- FrameDayMethod(survey = survey)

  spreads %>%
    select(postal_frac, online_frac, day_of_week) %>%
    gather(key = 'method', value = 'fraction', -day_of_week) %>%
    ggplot() +
    geom_col(mapping = aes(x = day_of_week, y = fraction, fill = method), alpha = 0.25,
             position = position_dodge2(preserve = 'single')) +
    scale_fill_manual(values = c('red', 'green')) +
    theme_minimal() +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major = element_line(size = 0.15),
          axis.text.x = element_text(angle = 90)) +
    xlab('\n') +
    ylab('fraction\n')


}

