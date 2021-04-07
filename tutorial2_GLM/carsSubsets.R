library(tidyverse)
library(MASS)
library(leaps)
library(tictoc)
setwd("~/Documents/JuliaR")

cars <- Cars93
names(cars)

cars <- cars %>%
  filter(Cylinders != "rotary") %>%
  mutate(Cylinders = as.numeric(Cylinders)) %>%
  dplyr::select(MPG.city, 
         Weight, 
         Price, 
         Length, 
         Fuel.tank.capacity, 
         Wheelbase, 
         RPM, 
         Horsepower, 
         EngineSize, 
         Cylinders, 
         Passengers)

tic()
all <- regsubsets(MPG.city~., data = cars)
toc()
summary(all)

tic()
predVars <- names(cars)[2:length(names(cars))]
nModels <- 0
for( ssSize in 1:length(predVars)){
  predVarsOfssSize <- combn(predVars, ssSize)
  nModels <- nModels + ncol(predVarsOfssSize)
  for(combination in 1:ncol(predVarsOfssSize)){
    theVars <- predVarsOfssSize[,combination]
    theFormula <- "MPG.city~1"
    for( n in 1:length(theVars) ){
      theFormula <- paste(theFormula, theVars[n], sep = "+")
      lm(as.formula(theFormula), data = cars)
    }
  }
}
toc()





