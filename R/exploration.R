# Title     : Exploration
# Objective : Exploration of Social Contact Survey Data
# Created by: greyhypotheses
# Created on: 30/11/2021

source(file = 'R/functions/SurveyData.R')
source(file = 'R/functions/FrequenciesTable.R')


# the inspected/prepared survey data
survey <- SurveyData()


# function FrequenciesTable() outlines the elements frequencies
# of categorical/binary fields
FrequenciesTable(field = survey$agegroup, fieldname = 'agegroup')
FrequenciesTable(field = survey$method, fieldname = 'method')