# Title     : Places
# Objective : Interested in rural/urban interactions, etc
# Created by: greyhypotheses
# Created on: 08/12/2021


source(file = 'R/modelling/WithPlacesData.R')
source(file = 'R/modelling/WithPlacesGraphs.R')

# modelling & analysis data
focus <- WithPlacesData()



# Sample for Sex, Age Group, Population



# census data
census <- read.csv(file = 'data/census.csv')
census$AgeGroup <- as.factor(census$AgeGroup)

T <- table(focus$agegroup, focus$sex)
quotients <- data.frame(female = T[, 'female'], male = T[, 'male'],
                        unknown = T[, 'unknown'], agegroup = rownames(T))
quotients <- quotients %>%
  filter(female > 0 | male > 0)

quotients <- left_join(x = quotients, y = census, by = c('agegroup' = 'AgeGroup'))

quotients <- quotients %>%
  mutate(reference_q <- Males/Females) %>%
  mutate(sample_q <- male/female)



# dispersion: take note of rural village & rural village in sparse setting point
CoordinatesContacts(focus = focus)
CoordinatesContactsPlace(focus = focus)



# Modelling
modelglmnb <- glm.nb(formula = total_contacts ~ agegroup + ru11ind + occupation + household_size + sex, data = focus)
summary(modelglmnb)
plot(modelglmnb)

modelglmnb <- glm.nb(formula = total_contacts ~ agegroup + ru11ind + occupation + household_size, data = focus)
summary(modelglmnb)
plot(modelglmnb)

modelglmnb <- glm.nb(formula = total_contacts ~ agegroup + ru11ind + occupation, data = focus)
summary(modelglmnb)
plot(modelglmnb)

modelglmnb <- glm.nb(formula = total_contacts ~ agegroup + ru11ind + occupation + household_size + sex, data = focus)
modelglmnbstep <- step(modelglmnb, trace = 0)
summary(modelglmnbstep)
plot(modelglmnbstep)