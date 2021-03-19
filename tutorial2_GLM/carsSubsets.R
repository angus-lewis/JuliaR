library(tidyverse)
library(MASS)
library(leaps)
library(tictoc)
setwd("~/Documents/JuliaR")

cars <- read_csv("cars.csv")
names(cars)

cars <- cars %>%
  mutate(City = 235.215/MPGCity) %>%
  filter(Cylinders != "rotary") %>%
  mutate(Cylinders = as.numeric(Cylinders)) %>%
  select(City, 
         Weight, 
         Price, 
         Length, 
         FuelTankCapacity, 
         Wheelbase, 
         RPM, 
         Horsepower, 
         EngineSize, 
         Cylinders, 
         Passengers)
tic()
all <- regsubsets(City~., data = cars)
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
    theFormula <- "City~1"
    for( n in 1:length(theVars) ){
      theFormula <- paste(theFormula, theVars[n], sep = "+")
      lm(as.formula(theFormula), data = cars)
    }
  }
}
toc()





