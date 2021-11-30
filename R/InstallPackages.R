# Title     : Install Packages
# Objective : Install Packages
# Created by: greyhypotheses
# Created on: 30/11/2021


InstallPackages <- function (){

  packages <- c('tidyverse', 'ggplot2', 'rmarkdown', 'latex2exp', 'equatiomatic')

  # Install
  .install <- function(x){
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      if (x == 'rmarkdown') {tinytex::install_tinytex()}
    }
  }
  lapply(packages, .install)

  # Activate
  .activate <- function (x){
    library(x, character.only = TRUE)
    if (x == 'rmarkdown') {library(tinytex)}
  }
  lapply(packages[!(packages %in% c('tidyverse', 'equatiomatic'))], .activate)

  # Active libraries
  sessionInfo()

}