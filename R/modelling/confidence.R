# Title     : confidence intervals
# Objective : confidece intervals
# Created by: Think
# Created on: 09/12/2021



# creating a data grid
gridplane <- expand.grid()


# $\hat{\mu}$
mu_ <- predict(modelglmnbstep, newdata = gridplane, type = 'response', se.fit = T)


# confidence intervals
est <- data.frame(fitted = mu_$fit,
                  ci_lower = mu_$fit - qnorm(p = 0.975) * mu_$se.fit,
                  ci_upper = mu_$fit + qnorm(p = 0.975) * mu_$se.fit)


# appending the 'ppgdp' & 'group'
est$ppgdp <- gridplane$ppgdp
est$group <- gridplane$group


# the graph
ggplot(data = est, mapping = aes(x = log(ppgdp), y = fitted, group = group, colour = group, fill = group)) +
  geom_line() +
  geom_ribbon(mapping = aes(ymin = ci_lower, ymax = ci_upper), alpha = 0.3, linetype = 0) +
  geom_point(data = un, mapping = aes(x = log(ppgdp), y = log(fertility)), alpha = 0.65, size = 2) +
  theme_minimal() +
  theme(plot.caption = element_text(hjust = 0, size = 11, colour = 'darkgrey'),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_line(size = 0.15),
        axis.title.x = element_text(size = 13, face = 'bold'), axis.text.x = element_text(size = 11),
        axis.title.y = element_text(size = 13, face = 'bold'), axis.text.y = element_text(size = 11) ) +
  ylab(label = TeX(string = '$\\hat{\\mu}$\n')) +
  xlab(label = '\nln(per capita gross domestic product)\n')