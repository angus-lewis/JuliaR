## Load packages
using DataFrames, CSV
# can also use "import DataFrames, CSV" to add packagename to namespace

## read data. 
# either
income = CSV.File("income.csv") |> DataFrame
# or
income = CSV.read("income.csv", DataFrame)
typeof(income)

# see the variables
names(income)

# indexing variables
# options
# View
income[!,[:Sex]]
income[!,["Sex"]]
income[!,[3]]
# copy
income[:,[:Sex]]
income[:,["Sex"]]
income[:,[3]]
# all return data frames
# or
income.Sex
income."Sex"
income[:,:Sex]
income[:,"Sex"]
income[:,3]
# all return VECTORS
# can use ! instead of :

# inverted selection
income[:,Not(:Sex)]

# head and tail in R
first(income,6)
last(income,6)
# missing type instead of NA in R

# select
incomeWOSex = select(income, Not(:Sex))
incomeWOSex = select(income, [:Year, :AHE])
# but 
incomeView = income # watch out! only makes a view, not a copy!
select!(incomeView, Not(:Sex)) # ! mean that income2 will change
income # and this changes too
# make a copy instead
income = CSV.File("income.csv") |> DataFrame
incomeCopy = copy(income)
select(incomeCopy, r"a") # regex r"a" selects all columns with "a" in them
# select and rename
incomeSelect = select(incomeCopy, :AHE => :Income, :Sex)
incomeSelect = select(incomeCopy, :AHE => :Income, :Sex) # 
# select and transform
f(x) = x*0.9
incomeSelect = select(incomeCopy, :AHE => f) # 
incomeSelect = select(incomeCopy, :AHE => x -> x*0.9)

# new data 
# empty DataFrame
emptyDataFrame = DataFrame()
emptyDataFrame = DataFrame(A = Int[], B = String[])
# with values
newDataFrame = DataFrame(
    Year = 2021.0,
    AHE = 10,
    Sex = "male",
)

# adding rows 
push!(income,newDataFrame[1,:])

# transform column
transform!(income, :AHE => (row -> row.*0.9) => :Income)

# filter rows 
filter!(:Income => (x-> x>20), income)

# summarize data 
describe(income)
combine(income, [:Income] => (x -> sum(x)/length(x)))

# what does this do 
income = CSV.File("income.csv") |> DataFrame

adjIncome(income,sex) = (isequal.(sex,"male")*0.87 + isequal.(sex,"female")) .* income
mean(x) = sum(x)/length(x)
what = income |> 
        x -> rename(x, :AHE => :Income) |>
        x -> transform(x, [:Income, :Sex] => adjIncome => :Adjusted_Income) |>
        x -> groupby(x,[:Sex, :Year]) |> 
        x -> combine(x, 
            :Income => mean, 
            :Adjusted_Income => mean,
            :Income => maximum,
            :Income => minimum,
            ) |> 
        x -> sort(x,[:Sex, :Year])