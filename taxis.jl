using CSV, DataFrames

@time taxis = [
    CSV.read("yellow_tripdata_2020-01.csv", DataFrame);
    CSV.read("yellow_tripdata_2020-02.csv", DataFrame);
    CSV.read("yellow_tripdata_2020-03.csv", DataFrame);
    CSV.read("yellow_tripdata_2020-04.csv", DataFrame);
]
df = DataFrame(:a => [1;2], :b => [2;3])
transform!(df, [:a,:b] => ((x,y)->x.*y))

combine(groupby(df, :a), nrow, :a => sum)

@time taxis |> 
  x -> transform!(x,[:passenger_count,:trip_distance] => ((x,y)->x.*y) => :total_distance) |> 
  x -> groupby(x, :passenger_count) |> 
  x -> combine(x, nrow, :total_distance => sum)