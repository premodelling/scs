# Title     : Places
# Objective : Interested in rural/urban interactions, etc
# Created by: greyhypotheses
# Created on: 08/12/2021


source(file = 'R/modelling/WithPlacesData.R')
source(file = 'R/modelling/WithPlacesGraphs.R')



# modelling & analysis data
focus <- WithPlacesData()



# correlations
# corrplot::corrplot(cor(focus[, c("lat", "long", "total_contacts", "age")]))



# dispersion: take note of 'rural village' & 'rural village in sparse settings'
CoordinatesContacts(focus = focus)
CoordinatesContactsPlace(focus = focus)



# Modelling
# modelglmnb <- glm.nb(formula = total_contacts ~ agegroup + ru11ind + occupation + household_size + sex, data = focus)
# summary(modelglmnb)
# plot(modelglmnb)
#
# modelglmnb <- glm.nb(formula = total_contacts ~ agegroup + ru11ind + occupation + household_size, data = focus)
# summary(modelglmnb)
# plot(modelglmnb)
#
# modelglmnb <- glm.nb(formula = total_contacts ~ agegroup + ru11ind + occupation, data = focus)
# summary(modelglmnb)
# plot(modelglmnb)


modelglmnb <- glm.nb(formula = total_contacts ~ agegroup + ru11ind + occupation + household_size + sex, data = focus)
modelglmnbstep <- step(modelglmnb, trace = 0)
summary(modelglmnbstep)
plot(modelglmnbstep)
