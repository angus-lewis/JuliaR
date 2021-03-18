## import("pathto/getPackages.jl")
## run the line above in the julia REPL execute
## install packages
import Pkg 
Pkg.add("DataFrames") # similar to dplyr, i think
Pkg.add("CSV") # to read in CSV files
Pkg.add("Plots") # 
Pkg.add("Distributions") # julia equivalent of pnorm etc
Pkg.add("HypothesisTests") # julia equivalents of t.test etc
Pkg.add("GLM") # the linear models package
Pkg.add("RDatasets") # 700+ datasets from R packages

## save some data to read in
import RDatasets, CSV
income = RDatasets.dataset("Ecdat","CPSch3")
CSV.write("income.csv",income) # saves to current working directory
cars = RDatasets.dataset("MASS","Cars93")
CSV.write("cars.csv",cars) # saves to current working directory