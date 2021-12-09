# Title     : TODO
# Objective : TODO
# Created by: Think
# Created on: 01/12/2021

FrameAgeSex <- function(survey) {

  X <- table(survey$agegroup, survey$sex, useNA = 'always')
  return(X)
}

GraphAgeSex <- function(survey) {

  ggplot(data = survey) +
    geom_bar(mapping = aes(x = agegroup, fill = sex), alpha = 0.35, na.rm = TRUE) +
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