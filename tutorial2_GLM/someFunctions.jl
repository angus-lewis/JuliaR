head(df) = first(df,4) # first is a function from DataFrames
notRotary(cyl) = !isequal(cyl,"rotary") # exclude rotary engines
convertMPG(MPG) = 235.215./MPG # convert between MPG and L/100km

function filter_and_convert!(cars)
    filter!(:Cylinders => notRotary, cars) |> 
        x -> transform!(
            x,
            :MPGCity => convertMPG => :City, 
            :MPGHighway => convertMPG => :Highway
            ) |> 
        x -> select!(x, Not([:MPGCity,:MPGHighway])) 
    return cars 
end