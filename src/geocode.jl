mutable struct Location
    lonlat::Tuple{Float64,Float64}
    placeid::String
    address::String
    locationtype::String
    tags::Vector{String}
end

function Base.show(io::IO, loc::Location)
    pprint(s::String, width::Int=50) =
        length(s) > width ? string(s[1:(width-3)], "...") : s
    println(io, "Location")
    println(io, "========")
    println(io, " *    type: ", pprint(loc.locationtype))
    println(io, " * address: ", pprint(loc.address))
    println(io, " *    tags: (",length(loc.tags),") ", pprint(join(loc.tags," | ")))
end

function getlocation(loc::Dict)
    geom = loc["geometry"]
    Location(
        (geom["location"]["lng"], geom["location"]["lat"]), loc["place_id"],
        loc["formatted_address"], geom["location_type"], loc["types"]
    )
end

function geocode(;kwargs...)
    resultjson = requestjson("geocode"; kwargs...)
    if resultjson["status"] == "OK"
        return resultjson["results"]
    else
        return []
    end
end

geocode(address::String; kwargs...) = geocode(address=address; kwargs...)

geocode(lon::Float64, lat::Float64; kwargs...) =
    geocode(latlng = string(lat,",",lon); kwargs...)

geocode(lonlat::Tuple{Float64,Float64}; kwargs...) =
    geocode(lonlat...; kwargs...)
