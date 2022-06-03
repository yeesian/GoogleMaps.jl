struct DistanceMatrix
    distances::Matrix{Int}
    durations::Matrix{Int}
    durations_in_traffic::Matrix{Union{Missing,Int}}
end
function distancematrix(;kwargs...)
    resultjson = requestjson("distancematrix"; kwargs...)
    if resultjson["status"] == "OK"
        return parsedistancematrix(resultjson["rows"])
    else
        return DistanceMatrix(fill(0,0,0),fill(0,0,0));
    end
end

function distancematrix(
        origins::Vector{String},
        destinations::Vector{String};
        mode::String = "transit",
        alternatives::Bool = true,
        kwargs...)
    n_origins = reduce((a,b)->"$a | $b",origins);
    n_destinations = reduce((a,b)->"$a | $b",destinations);
    distancematrix(; alternatives = string(alternatives), origins = n_origins,destinations = n_destinations,kwargs...)
end

function distancematrix(
        lonlat_origin::Vector{Tuple{Float64,Float64}},
        lonlat_dest::Vector{Tuple{Float64,Float64}},
        args...;
        kwargs...
    )

    origins = map(x->string(x[2],",",x[1],lonlat_origin));
    destinations = map(x->string(x[2],",",x[1],lonlat_dest));
    distancematrix(origins,destinations,args...; kwargs...)
end

function parsedistancematrix(arg)
    rowmapped = map(arg) do row
        @assert haskey(row,"elements");
        map(row["elements"]) do col
            if col["status"]!="OK"
                (typemax(Int),typemax(Int),missing)
            else
                @assert haskey(col,"duration")
                @assert haskey(col,"distance")
                @assert haskey(col["duration"],"value")
                @assert haskey(col["distance"],"value")

                if haskey(col,"duration_in_traffic")
                    @assert haskey(col["duration_in_traffic"],"value");
                    tval = col["duration_in_traffic"]["value"]
                else
                    tval = missing;
                end
                (col["distance"]["value"],col["duration"]["value"],tval)
            end
        end
    end

    bundle = permutedims(hcat(rowmapped...));

    distances = map(x->x[1],bundle);
    durations = map(x->x[2],bundle);
    traffic = convert(Matrix{Union{Int,Missing}},map(x->x[3],bundle));
    DistanceMatrix(distances,durations,traffic);
end
